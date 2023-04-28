//
//  SearchView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 03/03/23.
//

import SwiftUI

struct SearchView: View {
    @State private var text: String = ""
    @State private var isEditing = false
    
    @ObservedObject private var modelView: SearchModelView
    
    init(modelView: SearchModelView) {
        self.modelView = modelView
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(Color.theme.backgroundColor))
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    HStack {
                        TextField("", text: $text)
                            .padding(7)
                            .padding(.horizontal, 25)
                            .background(Color.theme.foregroundColor)
                            .cornerRadius(8)
                            .padding(.horizontal, 10)
                            .foregroundColor(Color.theme.secondaryForegroundColor)
                            .onTapGesture {
                                withAnimation {
                                    self.isEditing = true
                                }
                            }
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 16)
                                    
                                    if isEditing {
                                        Button(action: {
                                            self.text = ""
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 16)
                                        }
                                    }
                                }
                            )
                        
                        if isEditing {
                            Button(action: {
                                withAnimation {
                                    self.isEditing = false
                                    self.text = ""
                                }
                                
                            }) {
                                Text("Cancel")
                                    .foregroundColor(Color.theme.foregroundColor)
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                        }
                    }
                    
                    if !isEditing {
//                        LazyVStack(spacing: 2) {
//                            ForEach(1...100, id: \.self) { value in
//                                PhotoGridView(images: [UIImage(named: "charlottinha")!, UIImage(named: "clebinho2")!, UIImage(named: "clebinho1")! ], posts: [Post.example])
//                            }
//                        }
                        if modelView.arePostsPhotosLoading {
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
                                PhotoGridView(images: modelView.postsPhotos, posts: modelView.posts)
                            }
                        }
                    } else {
                        LazyVStack(spacing: 2) {
                            ForEach(modelView.searchedUsers, id: \.self) { user in
                                NavigationLink(destination: LazyView {
                                    ProfileView(uid: user.uid).navigationBarBackButtonHidden(true)
                                }) {
                                    SearchItemView(user: user)
                                }
                            }
                        }
                    }
                }
                .onAppear(perform: modelView.fetchMostRecentUsers)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(modelView: SearchModelView())
    }
}

