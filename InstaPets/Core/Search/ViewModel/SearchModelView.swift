//
//  SearchModelView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 07/03/23.
//

import Foundation
import FirebaseFirestore

class SearchModelView: ObservableObject {
    @Published var searchedUsers = [User]()
    private let userService = UserService.shared
    
    func fetchMostRecentUsers() {
        let collectionRef = Firestore.firestore().collection("users")
        
        collectionRef.getDocuments { snapshot, e in
            if let e =  e {
                print("DEBUG: Error getting documents \(e.localizedDescription)")
            } else {
                for document in snapshot!.documents {
                    if let fetchUser = self.fetchUser(withUID: document.documentID) {
                        self.searchedUsers.append(fetchUser)
                    }
                }
            }
        }
    }
    
    func fetchUser(withUID uid: String) -> User? {
        print(uid)
        var user = User.example
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            
            guard let data = snapshot.data() else { return }
            
            if let fullPetName = data["fullPetName"] as? String,
               let username = data["username"] as? String,
               let bio = data["bio"] as? String,
               let email = data["email"] as? String,
               let type = data["type"] as? String,
               let uid = data["uid"] as? String,
               let following = data["following"] as? [String],
               let postsUID = data["posts"] as? [String] {
                if !postsUID.isEmpty && !following.isEmpty {
                    let posts = self.userService.fetchPosts(withUIDs: postsUID)
                    user = User(fullPetName: fullPetName, username: username, email: email, type: self.userService.getPetTypeFromString(petString: type), uid: uid, bio: bio, following: following, posts: posts)
                } else if !postsUID.isEmpty && following.isEmpty {
                    let posts = self.userService.fetchPosts(withUIDs: postsUID)
                    user = User(fullPetName: fullPetName, username: username, email: email, type: self.userService.getPetTypeFromString(petString: type), uid: uid, bio: bio, posts: posts)
                } else if postsUID.isEmpty && !following.isEmpty {
                    user = User(fullPetName: fullPetName, username: username, email: email, type: self.userService.getPetTypeFromString(petString: type), uid: uid, bio: bio, following: following)
                } else if postsUID.isEmpty && following.isEmpty {
                    user = User(fullPetName: fullPetName, username: username, email: email, type: self.userService.getPetTypeFromString(petString: type), uid: uid, bio: bio)
                } else { return }
            } else {
                print("DEBUG: Error parsing user data to Swift properties")
            }
        }
        
        return user
    }
}
