//
//  UserService.swift
//  InstaPets
//
//  Created by Gustavo Dias on 21/02/23.
//

import Firebase
import FirebaseFirestoreSwift

class UserService: ObservableObject {
    static let shared = UserService()
    @Published var user: User?
    
    init() {
        fetchUser()
    }
    
    func getPetTypeFromString(petString: String) -> PetType {
        switch petString {
        case "cat":
            return PetType.cat
        case "wildcat":
            return PetType.wildcat
        case "dog":
            return PetType.dog
        case "rabbit":
            return PetType.rabbit
        case "aligator":
            return PetType.aligator
        case "rat":
            return PetType.rat
        case "snake":
            return PetType.snake
        case "hamster":
            return PetType.snake
        default:
            return PetType.cat
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print(uid)
        
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
                    let posts = self.fetchPosts(withUIDs: postsUID)
                    let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, following: following, posts: posts)
                    self.user = user
                } else if !postsUID.isEmpty && following.isEmpty {
                    let posts = self.fetchPosts(withUIDs: postsUID)
                    let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, posts: posts)
                    self.user = user
                } else if postsUID.isEmpty && !following.isEmpty {
                    let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, following: following)
                    self.user = user
                } else if postsUID.isEmpty && following.isEmpty {
                    let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio)
                    self.user = user
                } else { return }
            } else {
                print("DEBUG: Error parsing user data to Swift properties")
            }
        }
    }
    
    func fetchPosts(withUIDs uids: [String]) -> [Post] {
        var posts = [Post]()
        
        for uid in uids {
            Firestore.firestore().collection("posts").document(uid).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let post = try? snapshot.data(as: Post.self) else { return }
                
                posts.append(post)
            }
        }
        
        return posts
    }
    
    func addPostToCurrentUser(post: Post) {
        guard var localUser = user else { return }
        
        if localUser.posts != nil {
            localUser.posts.append(post)
        } else {
            localUser.posts = [Post]()
            localUser.posts.append(post)
        }
        
        user = localUser
        updateCurrentUserPostsFirestore()
    }
    
    func updateCurrentUserPostsFirestore() {
        if let currentUser = user, let currentUserPosts = user?.postsUID {
            let userFirestoreRef = Firestore.firestore().collection("users").document(currentUser.uid)
            
            userFirestoreRef.updateData([
                "posts": currentUserPosts
            ]) { err in
                if let e = err {
                    print("DEBUG: Error saving posts data to firestore (\(e)")
                } else {
                    print("DEBUG: Posts sucessfully updated to firestore")
                }
            }
        }
    }
    
    func follow(followedUID: String) {
        if var currentUser = user {
            if (currentUser.following) != nil  {
                if !currentUser.following.contains(followedUID) {
                    currentUser.following.append(followedUID)
                }
            }
            else {
                currentUser.following = [followedUID]
            }
            print(currentUser)
            
            let userFirestoreRef = Firestore.firestore().collection("users").document(currentUser.uid)
            
            userFirestoreRef.updateData([
                "following": currentUser.following
            ]) { err in
                if let e = err {
                    print("DEBUG: Error saving following data to firestore (\(e)")
                } else {
                    print("DEBUG: Following sucessfully updated to firestore")
                }
            }
            
            let followedUserFirestoreRef = Firestore.firestore().collection("users").document(followedUID)
            
            followedUserFirestoreRef.updateData([
                "followers": currentUser.uid
            ]) { err in
                if let e = err {
                    print("DEBUG: Error saving followers data to firestore (\(e)")
                } else {
                    print("DEBUG: Followers sucessfully updated to firestore")
                }
            }
        }
    }
    
    // FETCH USER FUNCTION W/O COMBINE
    
    //    static func fetchUser(completion: @escaping(User) -> Void) {
    //        guard let uid = Auth.auth().currentUser?.uid else { return }
    //
    //        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
    //            guard let snapshot = snapshot else { return }
    //
    //            guard let user = try? snapshot.data(as: User.self) else { return }
    //
    //            completion(user)
    //        }
    //    }
}
