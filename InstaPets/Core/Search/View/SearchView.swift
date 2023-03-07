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
    
    @StateObject private var modelView = SearchModelView()
    
    var body: some View {
        
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
                    LazyVStack(spacing: 2) {
                        ForEach(1...100, id: \.self) { value in
                            PhotoRowView()
                        }
                    }
                } else {
                    LazyVStack(spacing: 2) {
//                        for user in modelView.users {
//                            SearchItemView()
//                        }
                        
                        ForEach(modelView.searchedUsers, id: \.self) { user in
                            SearchItemView(user: user)
                        }
                    }
                }
            }
            .onAppear(perform: modelView.fetchMostRecentUsers)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

