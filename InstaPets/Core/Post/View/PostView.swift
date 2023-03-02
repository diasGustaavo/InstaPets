//
//  PostView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 25/02/23.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var viewModel: PostModelView
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(UIColor(Color.theme.backgroundColor))
                    .ignoresSafeArea(.all)
                
                VStack {
                    HeaderBarView(viewModel: viewModel)
                        .environmentObject(authViewModel)
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            
                            if let imgs = viewModel.images {
                                CarouselView(imgs: imgs, spacing: 10.0, headspace: 10, cornerRadius: 15)
                                    .frame(maxWidth: .infinity)
                                    .frame(alignment: .center)
                            }
                            
                            Text("\(viewModel.postImages.count) images selected.")
                                .font(.system(.caption))
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity)
                                .frame(alignment: .center)
                                .foregroundColor(Color.theme.foregroundColor)
                            
                            Spacer()
                                .frame(height: 25)
                            
                            
                            Text("Choose other photos")
                                .font(.system(size: 25, weight: .semibold))
                                .padding(.horizontal)
                                .foregroundColor(Color.theme.foregroundColor)
                            
                            HStack(alignment: .center) {
                                Button {
                                    // some action
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .frame(width: geo.size.width * 0.40, height: geo.size.width * 0.14)
                                            .foregroundColor(Color.theme.foregroundColor)
                                        
                                        HStack {
                                            Image(systemName: "camera")
                                                .font(.system(.title2))
                                                .foregroundColor(Color.theme.secondaryForegroundColor)
                                            
                                            Text("Camera")
                                                .font(.subheadline)
                                                .foregroundColor(Color.theme.secondaryForegroundColor)
                                        }
                                    }
                                }
                                
                                Button {
                                    // some action
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .frame(width: geo.size.width * 0.40, height: geo.size.width * 0.14)
                                            .foregroundColor(Color.theme.foregroundColor)
                                        
                                        HStack {
                                            Image(systemName: "photo.stack")
                                                .font(.system(.title2))
                                                .foregroundColor(Color.theme.secondaryForegroundColor)
                                            
                                            Text("Photos")
                                                .font(.subheadline)
                                                .foregroundColor(Color.theme.secondaryForegroundColor)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            Text("Description")
                                .font(.system(size: 25, weight: .semibold))
                                .padding(.horizontal)
                                .foregroundColor(Color.theme.foregroundColor)
                            
                            CustomTextfield(minRows: 5, maxRows: 5, placeholder: "Type your description right here.", filled: true, text: $viewModel.selectedDescription)
                                .padding(.horizontal)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
        .transition(.move(edge: .bottom))
            
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(viewModel: PostModelView())
            .environmentObject(AuthViewModel())
            .environmentObject(HomeViewModel())
    }
}

//MARK: - HeaderBarView

struct HeaderBarView: View {
    @ObservedObject var viewModel: PostModelView
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        HStack {
            Text("\(authViewModel.currentUser?.petEmoji ?? "") New Post")
                .font(.system(size: 40, weight: .semibold))
                .padding(.horizontal)
                .foregroundColor(Color.theme.foregroundColor)
            
            Spacer()
            
            Button {
                if let userUID = authViewModel.currentUserUID {
                    viewModel.savePostLocally()
                    viewModel.uploadPost(userUID: userUID)
                }
            } label: {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.theme.foregroundColor)
                    .font(.system(size: 30, weight: .semibold))
            }
        }
        .padding(.trailing)
    }
}
