//
//  feedView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 17/03/23.
//

import SwiftUI

struct feedView: View {
    @ObservedObject var viewModel: feedModelView
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(Color.theme.backgroundColor))
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    ForEach(viewModel.feedPostModelViews) { feedPostModelView in
                        if let feedPostModelView = feedPostModelView {
                            feedPostView(feedPostModelView: feedPostModelView)
                            Spacer()
                                .frame(height: 25)
                        } else {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color.theme.backgroundColor)
                                    .frame(width: UIScreen.screenWidth, height: 300)
                                
                                HStack {
                                    Spinner(lineWidth: 5, height: 32, width: 32)
                                    
                                    Spacer()
                                        .frame(width: 20)
                                    
                                    Text("Loading post 🐍")
                                        .font(.system(size: 20, weight: .semibold))
                                }
                            }
                        }
                    }
                }
            }
            Color(UIColor(Color.theme.backgroundColor))
                .ignoresSafeArea(.all)
        }
    }
    
    struct feedView_Previews: PreviewProvider {
        static var previews: some View {
            feedView(viewModel: feedModelView())
        }
    }
}
