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
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @Published var selectedImages = [UIImage]()
    @Published var selectedDescription: String = ""
    
    @Published var description: String = ""
    @Published var images = [UIImage]()
    
    let id = UUID().uuidString
    
    var postImages: [PostImage] {
        get {
            var content = [PostImage]()
            for image in images {
                content.append(PostImage(img: image))
            }
            
            return content
        }
    }
    
    var postImagesID: [String] {
        get {
            var content = [String]()
            for image in postImages {
                content.append(image.id)
            }
            
            return content
        }
    }
    
    var postReady: Bool {
        if images.count >= 1 {
            return true
        }
        
        return false
    }
    
//    func listItem() {
//        // Create a reference with an initial file path and name
//        let pathReference = storage.reference(withPath: "images/stars.jpg")
//
//
//    }
    
    func deletePostLocally() {
        images.removeAll()
        description = ""
    }
    
    func savePostLocally() {
        for selectedImage in selectedImages {
            images.append(selectedImage)
        }
        
        description = selectedDescription
        
        selectedDescription = ""
        selectedImages.removeAll()
    }
    
    func uploadPost(userUID: String) {
        uploadImagesToFirebase()
        
        let post = Post(description: description, postImages: postImagesID, authorUID: userUID, dateEvent: Date())
        
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        Firestore.firestore().collection("posts").document().setData(encodedPost) { _ in
            print("DEBUG: Did upload post to firestore")
        }
    }
    
    func uploadImagesToFirebase() {
        for postImage in postImages {
            let storageRef = self.storage.reference().child("\(id)/\(postImage.id).jpg")
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
    }
}
