//
//  PickMediaView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 21/02/23.
//

import SwiftUI
import PhotosUI

struct PickMediaView: View {
    @ObservedObject var viewModel: PostModelView
    
    @State private var showCamera = false
    
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
                    ImagePicker(sourceType: .camera, selectedImages: $viewModel.selectedImages)
                }
                
                Divider()
                    .background(Color.theme.accentTextColor)
                
                PhotosPicker(selection: $viewModel.selectedItems, matching: .images) {
                    HStack {
                        Image(systemName: "photo.stack")
                        
                        Text("Photos")
                    }
                }
                .padding(.bottom, 10)
                .onChange(of: viewModel.selectedItems) { _ in
                    Task {
                        await viewModel.uploadImagesFromPhotoPicker()
                    }
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
        PickMediaView(viewModel: PostModelView())
    }
}
