//
//  NotificationsView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 24/03/23.
//

import SwiftUI

struct NotificationsView: View {
    @ObservedObject var viewModel: NotificationsModelView
    
    init(userUid: String) {
        self.viewModel = NotificationsModelView()
    }
    
    let stockImage = UIImage(named: "minismalistCat")!
    
    var body: some View {
        ZStack {
            Color(UIColor(Color.theme.backgroundColor))
                .ignoresSafeArea(.all)
            
            VStack() {
                // Header
                Text("Notifications")
                    .font(.system(size: 26, weight: .bold))
                    .frame(maxWidth: Double.infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Divider()
                
                ScrollView {
                    ForEach(Array(viewModel.notifications.enumerated()), id: \.element) { index, notification in
                        HStack() {
                            NavigationLink(destination: ProfileView(uid: notification.actorUID).navigationBarBackButtonHidden(true)) {
                                Image(uiImage: UIImage(named: "clebinho1")!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.screenWidth * 0.12, height: UIScreen.screenWidth * 0.12)
                                    .clipped()
                                    .cornerRadius(999)
                                    .padding(.horizontal)
                            }
                            
                            Text(notification.description)
                            
                            Spacer()
                            
                            if !viewModel.notificationsThumbs.isEmpty {
                                Image(uiImage: viewModel.notificationsThumbs[index] ?? stockImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.screenWidth * 0.12, height: UIScreen.screenWidth * 0.12)
                                    .clipped()
                                    .padding(.horizontal)
                            } else {
                                Rectangle()
                                    .fill(Color.theme.foregroundColor)
                                    .cornerRadius(7)
                                    .frame(width: UIScreen.screenWidth * 0.12, height: UIScreen.screenWidth * 0.12)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView(userUid: "FD8YTUYPsDRMIS70ArPxchm9Grv2")
    }
}
