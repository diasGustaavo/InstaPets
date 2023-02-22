//
//  PostModelView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 22/02/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

class PostModelView: ObservableObject {
    let storage = Storage.storage()
    let images: [PostImage]?
    
    init(images: [PostImage]) {
        self.images = images
    }
    
    func uploadImages() {
        for image in images! {
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
}
