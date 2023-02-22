//
//  PostModelView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 22/02/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import PhotosUI

class PostModelView: ObservableObject {
    let storage = Storage.storage()
    
    @Published var selectedItems = [PhotosPickerItem]()
    @Published var selectedImages = [UIImage]()
    
    var images: [PostImage]?
    
    func uploadImages() {
        for selectedImage in selectedImages {
            let image = PostImage(content: selectedImage)
            images?.append(image)
            
            let storageRef = self.storage.reference().child("\(image.id)/\(image.id).jpg")
            let data = image.content.jpegData(compressionQuality: 0.9)
            let metadata = StorageMetadata()
            metadata.contentType = "\(image.id)/jpg"
            
            if let data = data {
                storageRef.putData(data, metadata: metadata) { (metadata, error) in
                    if let error = error {
                        print("Error while uploading file: ", error)
                    }
                    
                    if let metadata = metadata {
                        print("Metadata: ", metadata)
                    }
                }
            }
        }
    }
    
    func uploadImagesFromPhotoPicker() async {
        selectedItems.removeAll()
        selectedImages.removeAll()
        
        for item in selectedItems {
            if let data = try? await item.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImages.append(uiImage)
                }
            }
        }
        
        uploadImages()
    }
}
