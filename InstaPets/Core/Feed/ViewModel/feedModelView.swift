//
//  feedModelView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 17/03/23.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import UIKit

class feedModelView: ObservableObject {
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    @Published var posts: [Post]?
    @Published var feedPostModelViews = [feedPostModelView]()
    
    
    init() {
        fetchMostRecentPosts(completion: {
            self.fetchFeedPostModelViews()
        })
    }
    
    func fetchFeedPostModelViews() {
        if let posts = posts {
            feedPostModelViews.removeAll()
            for post in posts {
                let newPost = feedPostModelView(post: post)
                feedPostModelViews.append(newPost)
            }
        }
    }
    
    func fetchMostRecentPosts(completion: @escaping () -> Void) {
        fetchFirstXPostsUID(x: 3) { postsUID in
            UserService.shared.fetchPosts(withUIDs: postsUID) { posts in
                self.posts = posts
                completion()
            }
        }
    }
    
    func fetchFirstXPostsUID(x amountOfPosts: Int, completion: @escaping ([String]) -> Void) {
        let collectionRef = db.collection("posts")
        var fetchedPostsUID = [String]()

        collectionRef.getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("DEBUG: Error getting documents: \(error)")
            } else {
                var counter = 0
                for document in querySnapshot!.documents {
                    fetchedPostsUID.append(document.documentID)
                    counter += 1
                    if counter >= amountOfPosts {
                        break
                    }
                }
            }
            
            completion(fetchedPostsUID)
        }
    }
}
