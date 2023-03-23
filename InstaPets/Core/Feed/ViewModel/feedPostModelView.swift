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

class feedPostModelView: ObservableObject{
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
    
    init(post: Post) {
        self.likedByCurrentUser = userService.wasPostLikedByCurrentUser(post: post)
        self.amountOfLikes = post.likes.count
        self.userService.fetchUser(withUID: post.authorUID) { user in
            guard let user = user else { return }
            self.ownerUsername = user.username
        }
        self.post = post
        fetchMostRecentComments()
        fetchAllComments()
        fetchPostImages { postImages in
            self.postImages = postImages
        }
    }
    
    func fetchAllComments() {
        if let post = post {
            if post.comments.isEmpty { return }
            for comment in post.comments {
                var prefix = String(comment.prefix(28))
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
                    print("Error listing files: \(error.localizedDescription)")
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
