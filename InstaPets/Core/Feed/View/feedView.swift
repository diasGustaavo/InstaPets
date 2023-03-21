//
//  feedView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 17/03/23.
//

import SwiftUI

struct feedView: View {
    @ObservedObject var viewModel: feedModelView
    
    init() {
        self.viewModel = feedModelView()
    }
    
    var body: some View {
        if let posts = viewModel.posts {
            ScrollView {
                ForEach(posts) { post in
                    if let post = post {
                        feedPostView(post: post)
                        Spacer()
                            .frame(height: 25)
                    } else {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.theme.backgroundColor)
                                .frame(width: UIScreen.screenWidth, height: 300)
                            
                            HStack {
                                Spinner(lineWidth: 8, height: 32, width: 32)
                                
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
    }
}

struct feedView_Previews: PreviewProvider {
    static var previews: some View {
        feedView()
    }
}
