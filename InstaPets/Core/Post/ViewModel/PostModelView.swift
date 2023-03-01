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
    
    @Published var postReady: Bool = false
    @Published var selectedImages = [UIImage]()
    
    let storage = Storage.storage()
    
    var post = Post()
    var images: [UIImage]? {
        guard let postImages = post.postImages else { return nil }
        let imgs = postImages.map { $0.img }
        return imgs
    }
    
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
    
    func saveImagesLocally() {
        for selectedImage in selectedImages {
            let image = PostImage(img: selectedImage)
            
            if var postImages = post.postImages {
                postImages.append(image)
                post.postImages = postImages
            } else {
                post.postImages = [ image ]
            }
        }
        
        selectedImages.removeAll()
    }
    
    func uploadImagesToFirebase() {
        if let postImages = post.postImages {
            for postImage in postImages {
                let storageRef = self.storage.reference().child("\(post.id)/\(postImage.id).jpg")
                let data = postImage.img.jpegData(compressionQuality: 0.9)
                let metadata = StorageMetadata()
                metadata.contentType = "\(postImage.id)/jpg"
                
                if let data = data {
                    storageRef.putData(data, metadata: metadata) { (metadata, error) in
                        if let error = error {
                            print("Error while uploading file: ", error)
                        }
                    }
                }
            }
        } else {
            print("DEBUG: Could not upload images to Firebase: post.postImages is nil")
        }
    }
}
