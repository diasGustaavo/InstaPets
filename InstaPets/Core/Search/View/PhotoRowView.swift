//
//  PhotoRowView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 07/03/23.
//

import SwiftUI

struct PhotoRowView: View {
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


struct PhotoRowView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRowView()
    }
}
