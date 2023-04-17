//
//  SearchItemView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 07/03/23.
//

import SwiftUI

struct SearchItemView: View {
    @ObservedObject private var modelView: SearchItemModelView
    
    init(user: User) {
        self.modelView = SearchItemModelView(user: user)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image(uiImage: modelView.profileImg!)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth * 0.14, height: UIScreen.screenWidth * 0.14)
                .clipped()
                .cornerRadius(999)
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text(modelView.user.username)
                    .padding(.top, 10)
                    .font(.system(size: 16, weight: .black))
            
                Text(modelView.user.fullPetName)
                    .padding(.bottom)
                    .font(.system(size: 13, weight: .light))
            }
            .foregroundColor(Color.theme.foregroundColor)
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct SearchItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchItemView(user: User.example)
    }
}
