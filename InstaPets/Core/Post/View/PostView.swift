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
                
                VStack {
                    VStack {
                        Text("\(authViewModel.currentUser?.petEmoji ?? "") New post")
                            
                    }
                    
                    if let imgs = viewModel.images {
                        CarouselView(imgs: imgs, spacing: 10.0, headspace: 10, cornerRadius: 20)
                    }
                    
                    VStack {
                        CustomTextfield(placeholder: "Description", minRows: 5, maxRows: 5, filled: true)
                    }
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
