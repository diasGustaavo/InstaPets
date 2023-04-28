//
//  PersonalProfileView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 23/03/23.
//

import SwiftUI

struct PersonalProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel: PersonalProfileViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingConfirmation = false
    @State private var showPhotos = false
    
    init(personalProfileViewModel: PersonalProfileViewModel) {
        self.viewModel = personalProfileViewModel
    }
    
    var body: some View {
        ZStack {
            Color(UIColor(Color.theme.backgroundColor))
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: 20)
                        
                        Spacer()
                        
                        Text("\(viewModel.username)")
                            .font(.system(size: 20, weight: .bold))
                        
                        Spacer()
                        
                        Button {
                            showingConfirmation = true
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.forward")
                                .font(.system(size: 22))
                                .foregroundColor(Color.theme.foregroundColor)
                        }
                        .alert("Do you want to signout?", isPresented: $showingConfirmation) {
                            Button("Cancel", role: .cancel) {
                                // some action
                            }
                            Button("Signout", role: .destructive) {
                                authViewModel.signout()
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Image(uiImage: viewModel.ownerImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth * 0.28, height: UIScreen.screenWidth * 0.28)
                            .clipped()
                            .cornerRadius(999)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        VStack {
                            Text("\(viewModel.postNum)")
                                .font(.system(size: 22, weight: .semibold))
                            Text("Posts")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .padding(.horizontal, 2)
                        
                        VStack {
                            Text("\(viewModel.followersNum)")
                                .font(.system(size: 22, weight: .semibold))
                            Text("Followers")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .padding(.horizontal, 2)
                        
                        VStack {
                            Text("\(viewModel.followingNum)")
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
                        Text(viewModel.fullname)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.theme.foregroundColor)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text(viewModel.bio)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color.theme.foregroundColor)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Button {
                            showPhotos.toggle()
                        } label: {
                            Text("Edit photo")
                                .padding()
                                .font(.system(size: 16, weight: .bold))
                                .frame(width: UIScreen.screenWidth * 0.46, height: 43)
                                .background(Color.theme.secondaryForegroundColor)
                                .foregroundColor(Color.theme.foregroundColor)
                                .cornerRadius(15)
                        }
                        // PHOTOS VIEW
                        .sheet(isPresented: $showPhotos, onDismiss: {
                            viewModel.processPhotoSelection()
                        }) {
                            PhotoPicker(images: $viewModel.selectedImages, selectionLimit: 1)
                        }
                        
                        Button {
                            UIPasteboard.general.string = viewModel.username
                        } label: {
                            Text("Share profile")
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
                    
                    if viewModel.arePostsPhotosLoading {
                        VStack {
                            Spacer()
                                .frame(height: 20)
                            
                            HStack {
                                Spinner(lineWidth: 5, height: 32, width: 32)
                                
                                Spacer()
                                    .frame(width: 20)
                                
                                Text("Loading photos 🐈")
                                    .font(.system(size: 20, weight: .semibold))
                            }
                        }
                    } else {
                        LazyVStack(spacing: 2) {
                            PhotoGridView(images: viewModel.userPhotos, posts: viewModel.posts)
                        }
                    }
                }
            }
        }
    }
}

struct PersonalProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfileView(personalProfileViewModel: PersonalProfileViewModel())
    }
}
