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

@MainActor class PostModelView: ObservableObject {
    let storage = Storage.storage()
    var post = Post()
    var images: [UIImage]? {
        guard let postImages = post.postImages else { return nil }
        let imgs = postImages.map { $0.img }
        return imgs
    }
    
    @Published var selectedItems = [PhotosPickerItem]()
    @Published var selectedImages = [UIImage]()
    
    init(post: Post = Post()) {
        self.post = post
    }
    
//    func listItem() {
//        // Create a reference with an initial file path and name
//        let pathReference = storage.reference(withPath: "images/stars.jpg")
//
//
//    }
    
    func deletePostLocally() {
        post.postImages = nil
        post.description = ""
    }
    
    func uploadImages() {
        for selectedImage in selectedImages {
            let image = PostImage(img: selectedImage)
            
            if var postImages = post.postImages {
//                print("ENTROU AQUI")
                postImages.append(image)
                post.postImages = postImages
            } else {
//                print("ENTROU AQUI NO SEGUNDO")
                post.postImages = [ image ]
            }
            
            let storageRef = self.storage.reference().child("\(post.id)/\(image.id).jpg")
            let data = image.img.jpegData(compressionQuality: 0.9)
            let metadata = StorageMetadata()
            metadata.contentType = "\(image.id)/jpg"
            
            if let data = data {
                storageRef.putData(data, metadata: metadata) { (metadata, error) in
                    if let error = error {
                        print("Error while uploading file: ", error)
                    }
                    
//                    if let metadata = metadata {
//                        print("Metadata: ", metadata)
//                    }
                }
            }
        }
    }
    
    func uploadImagesFromPhotoPicker() async {
        selectedImages.removeAll()
        
        for item in selectedItems {
            if let data = try? await item.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImages.append(uiImage)
                }
            }
        }
        
        uploadImages()
        selectedItems.removeAll()
    }
}
