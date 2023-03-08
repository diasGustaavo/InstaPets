//
//  ProfileView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 07/03/23.
//

import SwiftUI

struct ProfileView: View {
    @State var postNum = 39
    @State var followersCounter = 50
    @State var followingCounter = 20
    
    var body: some View {
        ZStack {
            Color(UIColor(Color.theme.backgroundColor))
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack {
                    HStack {
                        Button {
                            // some action
                        } label: {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 22))
                                .foregroundColor(Color.theme.foregroundColor)
                        }
                        
                        Spacer()

                        Text("clebinhoo")
                            .font(.system(size: 19, weight: .black))
                            .foregroundColor(Color.theme.foregroundColor)
                        
                        Spacer()
                        
                        Spacer()
                            .frame(width: 10)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Image(uiImage: UIImage(named: "clebinho1")!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth * 0.28, height: UIScreen.screenWidth * 0.28)
                            .clipped()
                            .cornerRadius(999)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        VStack {
                            Text("\(postNum)")
                                .font(.system(size: 22, weight: .semibold))
                            Text("Posts")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .padding(.horizontal, 2)
                        
                        VStack {
                            Text("\(followersCounter)")
                                .font(.system(size: 22, weight: .semibold))
                            Text("Followers")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .padding(.horizontal, 2)
                        
                        VStack {
                            Text("\(followingCounter)")
                                .font(.system(size: 22, weight: .semibold))
                            Text("Following")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .padding(.horizontal, 2)
                        
                        Spacer()
                    }
                    .foregroundColor(Color.theme.foregroundColor)
                    .padding(.top)
                    
                    HStack {
                        Text("Clebinho da Silva Miau")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.theme.foregroundColor)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("As I've always said: Miau miau miau 🐈")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color.theme.foregroundColor)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Button {
                            // some action
                        } label: {
                            Text("Follow")
                                .padding()
                                .font(.system(size: 16, weight: .bold))
                                .frame(width: UIScreen.screenWidth * 0.46, height: 43)
                                .background(Color.theme.secondaryForegroundColor)
                                .foregroundColor(Color.theme.foregroundColor)
                                .cornerRadius(15)
                        }
                        
                        Button {
                            // some action
                        } label: {
                            Text("Follow")
                                .padding()
                                .font(.system(size: 16, weight: .bold))
                                .frame(width: UIScreen.screenWidth * 0.46, height: 43)
                                .background(Color.theme.secondaryForegroundColor)
                                .foregroundColor(Color.theme.foregroundColor)
                                .cornerRadius(15)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    LazyVStack(spacing: 2) {
                        ForEach(1...100, id: \.self) { value in
                            PhotoGridView(images: [UIImage(named: "charlottinha")!, UIImage(named: "clebinho2")!, UIImage(named: "clebinho1")! ])
                        }
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
