//
//  PhotoRowView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 07/03/23.
//

import SwiftUI

struct PhotoGridView: View {
    let images: [UIImage]
    let posts: [Post]
    
    var body: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: .infinity), spacing: 3)], spacing: 3) {
            ForEach(Array(images.enumerated()), id: \.1) { index, image in
                NavigationLink {
                    DedicatedPostView(post: posts[index])
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth * 0.33, height: UIScreen.screenWidth * 0.33)
                        .clipped()
                }
            }
        }
    }
}


struct PhotoGridView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGridView(images: [UIImage(named: "charlottinha")!, UIImage(named: "clebinho2")!, UIImage(named: "clebinho1")! ], posts: [Post.example])
    }
}
