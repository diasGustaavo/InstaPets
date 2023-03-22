//
//  feedPostView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 17/03/23.
//

import SwiftUI

struct feedPostView: View {
    @ObservedObject var viewModel: feedPostModelView
    @State private var animateHeart = false
    
    init(post: Post) {
        self.viewModel = feedPostModelView(post: post)
    }
    
    var body: some View {
        VStack() {
            HStack(spacing: 0) {
                Image(uiImage: UIImage(named: "clebinho1")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth * 0.10, height: UIScreen.screenWidth * 0.10)
                    .clipped()
                    .cornerRadius(999)
                    .padding(.horizontal)
                
                Text(viewModel.ownerUsername)
                    .font(.system(size: 20, weight: .semibold))
                
                Spacer()
            }
            
            if let postImages = viewModel.postImages {
                ZStack {
                    CarouselView(imgs: postImages, spacing: 0, headspace: 0, slideScaling: 1.0, width: 1.0)
                        .frame(maxWidth: .infinity)
                        .frame(alignment: .center)
                        .onTapGesture(count: 2) {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)) {
                                viewModel.toggleLike()
                                animateHeart.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                    animateHeart.toggle()
                                })
                            }
                        }
                    
                    if animateHeart {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 100))
                            .foregroundColor(.red)
                            .scaleEffect(animateHeart ? 1.0 : 0.5)
                    }
                }
            } else {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.theme.backgroundColor)
                        .frame(width: UIScreen.screenWidth, height: 300)
                    
                    HStack {
                        Spinner(lineWidth: 8, height: 32, width: 32)
                        
                        Spacer()
                            .frame(width: 20)
                        
                        Text("Loading photos 🐈")
                            .font(.system(size: 20, weight: .semibold))
                    }
                }
            }
            
            HStack {
                Group {
                    Button<Image> {
                        viewModel.toggleLike()
                    } label: {
                        Image(systemName: viewModel.likedByCurrentUser ? "heart.fill" : "heart")
                    }
                    .foregroundColor(.black)
                    .padding(.trailing, 2)
                    
                    Image(systemName: "bubble.left")
                }
                .font(.system(size: 28))
                
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
                .frame(height: 6)
            
            HStack {
                Text("\(viewModel.amountOfLikes) like\(viewModel.amountOfLikes > 1 ? "s" : "")")
                    .font(.system(size: 20, weight: .semibold))
                
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
                .frame(height: 6)
            
            HStack {
                Text("**\(viewModel.ownerUsername)** \(viewModel.post?.description ?? "")")
                    .font(.system(size: 20, weight: .regular))
                    .lineLimit(3)
                
                Spacer()
            }
            .padding(.horizontal)
            
            ForEach(viewModel.mostRecentComments) { comment in
                HStack {
                    Text(try! AttributedString(markdown: comment))
                        .font(.system(size: 20, weight: .regular))
                        .lineLimit(1)

                    Spacer()
                }
                .padding(.horizontal)
            }
            
            HStack {
                Text("View complete post")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.gray.opacity(0.9))
                    .lineLimit(3)
                
                Spacer()
            }
            .padding(.horizontal)
            
            // Add comment & time info
            Group {
                HStack(spacing: 0) {
                    Image(uiImage: UIImage(named: "clebinho1")!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth * 0.08, height: UIScreen.screenWidth * 0.08)
                        .clipped()
                        .cornerRadius(999)
                        .padding(.horizontal)
                    
                    Text("Add a comment...")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.gray.opacity(0.9))
                    
                    Spacer()
                }
                
                HStack {
                    Text("42 minutes ago")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.gray.opacity(0.9))
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct feedPostView_Previews: PreviewProvider {
    static var previews: some View {
        feedPostView(post: Post.example)
    }
}
