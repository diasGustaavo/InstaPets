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
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(UIColor(Color.theme.backgroundColor))
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .leading) {
                    Text("\(authViewModel.currentUser?.petEmoji ?? "") New Post")
                        .font(.system(size: 40, weight: .semibold))
                        .padding(.horizontal)
                        .foregroundColor(Color.theme.foregroundColor)
                    
                    if let imgs = viewModel.images {
                        CarouselView(imgs: imgs, spacing: 10.0, headspace: 10, cornerRadius: 15)
                    }
                    
                    Text("\(viewModel.post.postImages?.count ?? 0) images selected.")
                        .font(.system(.caption))
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .frame(alignment: .center)
                        .foregroundColor(Color.theme.foregroundColor)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    
                    Text("Add More Photos")
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.horizontal)
                        .foregroundColor(Color.theme.foregroundColor)
                    
                    HStack(alignment: .center) {
                        Button {
                            // some action
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: geo.size.width * 0.45, height: geo.size.width * 0.18)
                                    .foregroundColor(Color.theme.foregroundColor)
                                
                                HStack {
                                    Image(systemName: "camera")
                                        .font(.system(.title))
                                        .foregroundColor(Color.theme.backgroundColor)
                                    
                                    Text("Camera")
                                        .foregroundColor(Color.theme.backgroundColor)
                                }
                            }
                        }
                        
                        Button {
                            // some action
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: geo.size.width * 0.45, height: geo.size.width * 0.18)
                                    .foregroundColor(Color.theme.foregroundColor)
                                
                                HStack {
                                    Image(systemName: "photo.stack")
                                        .font(.system(.title))
                                        .foregroundColor(Color.theme.backgroundColor)
                                    
                                    Text("Photos")
                                        .foregroundColor(Color.theme.backgroundColor)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(alignment: .center)
                    
                    Text("Description")
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.horizontal)
                        .foregroundColor(Color.theme.foregroundColor)
                    
                    CustomTextfield(placeholder: "Type your description right here.", minRows: 5, maxRows: 5, filled: true)
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(viewModel: PostModelView(post: Post.example))
            .environmentObject(AuthViewModel())
    }
}
