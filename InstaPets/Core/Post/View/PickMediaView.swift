//
//  PickMediaView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 21/02/23.
//

import SwiftUI
import PhotosUI

struct PickMediaView: View {
    @State private var image = UIImage()
    @State private var showCamera = false
    @State private var showPhotos = false
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "camera")
                    
                    Text("Camera")
                }
                .padding(.top, 10)
                .onTapGesture {
                    showCamera = true
                }
                .sheet(isPresented: $showCamera) {
                    ImagePicker(sourceType: .camera, selectedImage: self.$image)
                }
                
                Divider()
                    .background(Color.theme.accentTextColor)
                
                
                HStack {
                    Image(systemName: "photo.stack")
                    
                    Text("Photos")
                }
                .padding(.bottom, 10)
                .onTapGesture {
                    showPhotos = true
                }
                .sheet(isPresented: $showPhotos) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                }
                .onChange(of: image) { image in
                    let post = PostModelView(images: [PostImage(content: image)])
                    post.uploadImages()
                }
                
            }
            .padding(.horizontal)
            .frame(maxWidth: 130)
            .background(Color.theme.foregroundColor)
            .foregroundColor(Color.theme.accentTextColor)
            .cornerRadius(16)
            
            Spacer()
                .frame(height: 50)
        }
        .transition(.move(edge: .bottom))
    }
}

struct PickMediaView_Previews: PreviewProvider {
    static var previews: some View {
        PickMediaView()
    }
}
