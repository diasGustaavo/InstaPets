//
//  feedPostModelView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 20/03/23.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import UIKit

class feedPostModelView: ObservableObject, Identifiable {
    let db = Firestore.firestore()
    let storage = Storage.storage()
    private let userService = UserService.shared
    
    @Published var post: Post?
    @Published var postImages: [UIImage]?
    @Published var likedByCurrentUser = false
    @Published var amountOfLikes = 0
    @Published var ownerUsername = ""
    @Published var mostRecentComments = [String]()
    @Published var allComments = [Comment]()
    @Published var ownerImage = UIImage(named: "minismalistCat")!
    
    init(post: Post) {
        self.likedByCurrentUser = userService.wasPostLikedByCurrentUser(post: post)
        self.amountOfLikes = post.likes.count
        self.userService.fetchUser(withUID: post.authorUID) { user in
            guard let user = user else { return }
            self.ownerUsername = user.username
        }
        self.post = post
        fetchOwnerImage()
        fetchMostRecentComments()
        fetchAllComments()
        fetchPostImages { postImages in
            self.postImages = postImages
        }
    }
    
    func fetchOwnerImage() {
        if let post = post {
            let imageRef = storage.reference().child("profilePhotos/\(post.authorUID).jpg")
            
            imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                if error != nil {
                    // Handle error
                    print("DEBUG: User \(post.authorUID) does not have a profile photo.")
                } else {
                    // Data for image is returned, you can now create a UIImage with it
                    if let data = data, let image = UIImage(data: data) {
                        // Use the image as needed
                        // e.g. display it in an image view
                        self.ownerImage = image
                    } else {
                        print("Error converting data to image")
                    }
                }
            }
        }
    }
    
    func fetchAllComments() {
        if let post = post {
            if post.comments.isEmpty { return }
            for comment in post.comments {
                let prefix = String(comment.prefix(28))
                let suffix = String(comment.suffix(comment.count - 27))
                
                self.userService.fetchUser(withUID: prefix) { user in
                    guard let user = user else { return }
                    let username = user.username
                    
                    self.allComments.append(Comment(description: suffix, authorID: prefix, authorUsername: username))
                }
            }
        }
    }
    
    func fetchMostRecentComments() {
        if let post = post {
            if post.comments.isEmpty {
                return
            }
            else if post.comments.count == 1 {
                mostRecentComments.removeAll()
                getCommentTreatedString(comment: post.comments[0]) { treatedComment in
                    self.mostRecentComments.append(treatedComment)
                }
            } else if post.comments.count >= 2 {
                mostRecentComments.removeAll()
                getCommentTreatedString(comment: post.comments[0]) { treatedComment in
                    self.mostRecentComments.append(treatedComment)
                }
                getCommentTreatedString(comment: post.comments[1]) { treatedComment in
                    self.mostRecentComments.append(treatedComment)
                }
            }
        }
    }
    
    func getCommentTreatedString(comment: String, completion: @escaping (String) -> Void) {
        var prefix = String(comment.prefix(28))
        let suffix = String(comment.suffix(comment.count - 28))
        
        self.userService.fetchUser(withUID: prefix) { user in
            guard let user = user else { return }
            prefix = "**\(user.username)**"
            completion(prefix + suffix)
        }
    }
    
    func updatePost() {
        if let post = post {
            userService.fetchPost(withUID: post.id) { post in
                self.amountOfLikes = post.likes.count
                self.post = post
            }
        }
    }
    
    func toggleLike() {
        likedByCurrentUser.toggle()
        if let post = post {
            userService.toggleLike(post: post)
            updatePost()
        }
    }
    
    func fetchPostImages(completion: @escaping ([UIImage]) -> Void) {
        if let postUID = post?.id {
            let storageRef = storage.reference(withPath: postUID)
            
            // List all items in the folder
            storageRef.listAll { (result, error) in
                if let error = error {
                    print("DEBUG: Error listing files: \(error.localizedDescription)")
                    return
                }
                
                // Unwrap the items array
                guard let result = result else { return }
                
                var imageArray = [UIImage]()
                var itemsCount = 0
                for img in result.items {
                    img.getData(maxSize: 10000 * 10000) { data, e in
                        if let e = e {
                            print("DEBUG: Error downloading image: \(e.localizedDescription)")
                        }
                        else {
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                if let image = image {
                                    imageArray.append(image)
                                }
                            }
                        }
                        
                        itemsCount += 1
                        if itemsCount >= result.items.count {
                            completion(imageArray)
                        }
                    }
                }
            }
        }
    }
}
