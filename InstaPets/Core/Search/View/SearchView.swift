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
    
    var body: some View {
        
        ZStack {
            Color(UIColor(Color.theme.backgroundColor))
                .ignoresSafeArea(.all)
            
            ScrollView {
                HStack {
                    TextField("Search ...", text: $text)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 10)
                        .foregroundColor(Color.theme.foregroundColor)
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
                
                LazyVStack(spacing: 2) {
                    ForEach(1...100, id: \.self) { value in
                        PhotoRow()
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct PhotoRow: View {
    var body: some View {
        HStack(spacing: 2) {
            Button {
                // some action
            } label: {
                Image(uiImage: UIImage(named: "clebinho1")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth * 0.33, height: UIScreen.screenWidth * 0.33)
                    .clipped()
            }
            
            Button {
                // some action
            } label: {
                Image(uiImage: UIImage(named: "clebinho2")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth * 0.33, height: UIScreen.screenWidth * 0.33)
                    .clipped()
            }
            
            
            Button {
                // some actiopn
            } label: {
                Image(uiImage: UIImage(named: "charlottinha")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth * 0.33, height: UIScreen.screenWidth * 0.33)
                    .clipped()
            }
            
        }
    }
}
