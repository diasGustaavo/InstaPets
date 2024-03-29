//
//  SearchModelView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 07/03/23.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class SearchModelView: ObservableObject {
    @Published var searchedUsers = [User]()
    @Published var postsUID = [String]()
    @Published var posts = [Post]()
    @Published var postsPhotos = [UIImage]()
    @Published var arePostsPhotosLoading = true
    
    let storage = Storage.storage()
    private let userService = UserService.shared
    
    init() {
        fetchAllPosts {
            self.fetchAllPostsMainImages{
                self.arePostsPhotosLoading = false
            }
        }
    }
    
    func fetchMostRecentUsers() {
        searchedUsers = [User]()
        let collectionRef = Firestore.firestore().collection("users")
        
        collectionRef.getDocuments { snapshot, e in
            if let e =  e {
                print("DEBUG: Error getting documents \(e.localizedDescription)")
            } else {
                for document in snapshot!.documents {
                    self.userService.fetchUser(withUID: document.documentID) { user in
                        if let user = user {
                            self.searchedUsers.append(user)
                        }
                    }
                }
            }
        }
    }
    
    func fetchAllPosts(completion: @escaping () -> Void) {
        Firestore.firestore().collection("posts").getDocuments { snapshot, e in
            if e != nil {
                print("DEBUG: Error getting posts documents")
            } else {
                for document in snapshot!.documents {
                    do {
                        let post = try document.data(as: Post.self)
                        self.posts.append(post)
                        self.postsUID.append(document.documentID)
                    }
                    catch {
                        print(error)
                    }
                }
                completion()
            }
        }
    }
    
    func fetchAllPostsMainImages(completion: @escaping () -> Void) {
        var tempPostsPhotos = Array(repeating: UIImage(named: "minismalistCat")!, count: postsUID.count)
        var count = 0
        for (index, imageFolder) in postsUID.enumerated() {
            let storageRef = Storage.storage().reference(withPath: imageFolder)

            // List all items in the folder
            storageRef.listAll { (result, error) in
                if let error = error {
                    print("DEBUG: Error listing files: \(error.localizedDescription)")
                    return
                }

                // Unwrap the items array
                guard let result = result else { return }

                result.items[0].getData(maxSize: 10000 * 10000) { data, e in
                    if let e = e {
                        print("DEBUG: Error downloading image: \(e.localizedDescription)")
                    }
                    else {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            guard let image = image else { return }

                            tempPostsPhotos[index] = image
                            count += 1
                            
                            if count >= self.postsUID.count {
                                self.postsPhotos = tempPostsPhotos
                                completion()
                            }
                        }
                    }
                }
            }
        }
    }
}
