//
//  PostCommentsView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 22/03/23.
//

import SwiftUI

struct PostCommentsView: View {
    @Environment(\.dismiss) private var dismiss
    @State var comments: [Comment]
    
    var body: some View {
        ZStack {
            Color(UIColor(Color.theme.backgroundColor))
                .ignoresSafeArea(.all)
                    
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .imageScale(.medium)
                            .padding(.vertical)
                            .foregroundColor(Color.theme.basicTextColor)
                    }
                    
                    Spacer()
                    
                    Text("Comments")
                        .font(.system(size: 19, weight: .bold))
                    
                    Spacer()
                        .frame(width: UIScreen.screenWidth * 0.36)
                }
                .padding(.leading)
                
                Divider()
                    .padding(.bottom)
                
                ScrollView {
                    ForEach(comments) { comment in
                        CommentView(comment: comment)
                    }
                }
            }
        }
    }
}

struct PostCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        PostCommentsView(comments: [Comment.example])
    }
}

struct CommentView: View {
    @State var comment: Comment
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            NavigationLink(destination: LazyView {
                ProfileView(uid: comment.authorID).navigationBarBackButtonHidden(true)
            }) {
                Image(uiImage: UIImage(named: "clebinho1")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth * 0.10, height: UIScreen.screenWidth * 0.10)
                    .clipped()
                    .cornerRadius(999)
                    .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                NavigationLink(destination: LazyView {
                    ProfileView(uid: comment.authorID).navigationBarBackButtonHidden(true)
                }) {
                    Text(comment.authorUsername)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Text(comment.description)
            }
            
            Spacer()
        }
        .padding(.trailing)
    }
}
