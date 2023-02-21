//
//  PickMediaView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 21/02/23.
//

import SwiftUI

struct PickMediaView: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "camera")
                    
                    Text("Camera")
                }
                .padding(.top, 10)
                
                Divider()
                    .background(Color.theme.accentTextColor)
                
                HStack {
                    Image(systemName: "photo.stack")
                    
                    Text("Photos")
                }
                .padding(.bottom, 10)
            }
            .padding(.horizontal)
            .frame(maxWidth: 130)
            .background(Color.theme.foregroundColor)
            .foregroundColor(Color.theme.accentTextColor)
            .cornerRadius(16)
            
            Spacer()
                .frame(height: 50)
        }
    }
}

struct PickMediaView_Previews: PreviewProvider {
    static var previews: some View {
        PickMediaView()
    }
}
