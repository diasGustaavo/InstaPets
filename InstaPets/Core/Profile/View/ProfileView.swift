//
//  ProfileView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 07/03/23.
//

import SwiftUI

struct ProfileView: View {
    let uid: String
    @ObservedObject var profileViewModel: ProfileViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(uid: String) {
        self.uid = uid
        self.profileViewModel = ProfileViewModel(uid: uid)
    }
    
    var body: some View {
        ZStack {
            Color(UIColor(Color.theme.backgroundColor))
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 22))
                                .foregroundColor(Color.theme.foregroundColor)
                        }
                        
                        Spacer()

                        Text(profileViewModel.username)
                            .font(.system(size: 19, weight: .black))
                            .foregroundColor(Color.theme.foregroundColor)
                        
                        Spacer()
                        
                        Spacer()
                            .frame(width: 10)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Image(uiImage: profileViewModel.ownerImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth * 0.28, height: UIScreen.screenWidth * 0.28)
                            .clipped()
                            .cornerRadius(999)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        VStack {
                            Text("\(profileViewModel.postNum)")
                                .font(.system(size: 22, weight: .semibold))
                            Text("Posts")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .padding(.horizontal, 2)
                        
                        VStack {
                            Text("\(profileViewModel.followersNum)")
                                .font(.system(size: 22, weight: .semibold))
                            Text("Followers")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .padding(.horizontal, 2)
                        
                        VStack {
                            Text("\(profileViewModel.followingNum)")
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
                        Text(profileViewModel.fullname)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.theme.foregroundColor)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text(profileViewModel.bio)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color.theme.foregroundColor)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        if profileViewModel.isFollowButtonActivated {
                            Button {
                                profileViewModel.unfollow()
                            } label: {
                                Text("Unfollow")
                                    .padding()
                                    .font(.system(size: 16, weight: .bold))
                                    .frame(width: UIScreen.screenWidth * 0.46, height: 43)
                                    .background(Color.theme.secondaryForegroundColor)
                                    .foregroundColor(.red)
                                    .cornerRadius(15)
                            }
                        } else {
                            Button {
                                profileViewModel.follow()
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
                        
                        Button {
                            // some action
                        } label: {
                            Text("Message")
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
                        PhotoGridView(images: profileViewModel.userPhotos, posts: profileViewModel.posts)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(uid: "FD8YTUYPsDRMIS70ArPxchm9Grv2")
    }
}
