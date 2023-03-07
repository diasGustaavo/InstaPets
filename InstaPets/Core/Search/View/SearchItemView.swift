//
//  SearchItemView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 07/03/23.
//

import SwiftUI

struct SearchItemView: View {
    let user: User
    
    var body: some View {
        HStack(alignment: .top) {
            Image(uiImage: UIImage(named: "clebinho1")!)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth * 0.14, height: UIScreen.screenWidth * 0.14)
                .clipped()
                .cornerRadius(999)
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .padding(.top, 10)
                    .font(.system(size: 16, weight: .semibold))
            
                Text(user.fullPetName)
                    .padding(.bottom)
                    .font(.system(size: 13, weight: .light))
            }
            
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
