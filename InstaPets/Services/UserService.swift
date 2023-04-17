//
//  UserService.swift
//  InstaPets
//
//  Created by Gustavo Dias on 21/02/23.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import UIKit

class UserService: ObservableObject {
    static let shared = UserService()
    @Published var user: User?
    @Published var userPhoto = UIImage(named: "minismalistCat")!
    
    init() {
        fetchUser()
    }
    
    func fetchUserImage(user: User, completion: @escaping (UIImage) -> Void) {
        let imageRef = Storage.storage().reference().child("profilePhotos/\(user.uid).jpg")
        
        imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if error != nil {
                // Handle error
                print("DEBUG: User \(user.uid) does not have a profile photo.")
            } else {
                // Data for image is returned, you can now create a UIImage with it
                if let data = data, let image = UIImage(data: data) {
                    // Use the image as needed
                    // e.g. display it in an image view
                    completion(image)
                } else {
                    print("Error converting data to image")
                }
            }
        }
    }
    
    func fetchOwnerImage() {
        if let user = user {
            let imageRef = Storage.storage().reference().child("profilePhotos/\(user.uid).jpg")
            
            imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                if error != nil {
                    // Handle error
                    print("DEBUG: User \(user.uid) does not have a profile photo.")
                } else {
                    // Data for image is returned, you can now create a UIImage with it
                    if let data = data, let image = UIImage(data: data) {
                        // Use the image as needed
                        // e.g. display it in an image view
                        self.userPhoto = image
                    } else {
                        print("Error converting data to image")
                    }
                }
            }
        }
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
    
    func fetchUserNotifications(completion: @escaping ([Notification]) -> Void) {
        guard let user = user else { return }
        let notificationsUID = user.notifications
        var notifications = [Notification]()
        
        var counter = 0
        for notificationUID in notificationsUID {
            let docRef = Firestore.firestore().collection("notifications").document(notificationUID)
            
            docRef.getDocument { document, e in
                if (e as NSError?) != nil {
                    print("DEBUG: Error fetching notification")
                } else {
                    if let document = document {
                        do {
                            let notification = try document.data(as: Notification.self)
                            notifications.append(notification)
                            counter += 1
                        }
                        catch {
                            print("DEBUG: Error turning firestore notification into local notification")
                        }
                    }
                }
                
                if counter >= notificationsUID.count {
                    completion(notifications)
                }
            }
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
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
               let notifications = data["notifications"] as? [String],
               let postsUID = data["posts"] as? [String] {
                if !postsUID.isEmpty && !following.isEmpty {
                    self.fetchPosts(withUIDs: postsUID) { posts in
                        guard let posts = posts else { return }
                        let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, following: following, posts: posts, notifications: notifications)
                        self.user = user
                        print("DEBUG: Logged as \(String(describing: user.username))")
                    }
                } else if !postsUID.isEmpty && following.isEmpty {
                    self.fetchPosts(withUIDs: postsUID) { posts in
                        guard let posts = posts else { return }
                        let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, posts: posts, notifications: notifications)
                        self.user = user
                        print("DEBUG: Logged as \(String(describing: user.username))")
                    }
                } else if postsUID.isEmpty && !following.isEmpty {
                    let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, following: following, notifications: notifications)
                    self.user = user
                    print("DEBUG: Logged as \(String(describing: user.username))")
                } else if postsUID.isEmpty && following.isEmpty {
                    let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, notifications: notifications)
                    self.user = user
                    print("DEBUG: Logged as \(String(describing: user.username))")
                } else { return }
            } else {
                print("DEBUG: Error parsing user data to Swift properties")
            }
        }
    }
    
    func fetchUserAndDo(completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
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
                    self.fetchPosts(withUIDs: postsUID) { posts in
                        guard let posts = posts else { return }
                        let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, following: following, posts: posts)
                        self.user = user
                        completion()
                    }
                } else if !postsUID.isEmpty && following.isEmpty {
                    self.fetchPosts(withUIDs: postsUID) { posts in
                        guard let posts = posts else { return }
                        let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, posts: posts)
                        self.user = user
                        completion()
                    }
                } else if postsUID.isEmpty && !following.isEmpty {
                    let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, following: following)
                    self.user = user
                    completion()
                } else if postsUID.isEmpty && following.isEmpty {
                    let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio)
                    self.user = user
                    completion()
                } else { return }
            } else {
                print("DEBUG: Error parsing user data to Swift properties")
            }
        }
    }
    
    func fetchUser(withUID uid: String, completion: @escaping (User?) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            
            guard let data = snapshot.data() else { return }
            
//            print(data)
            
            if let fullPetName = data["fullPetName"] as? String,
               let username = data["username"] as? String,
               let bio = data["bio"] as? String,
               let email = data["email"] as? String,
               let type = data["type"] as? String,
               let uid = data["uid"] as? String,
               let following = data["following"] as? [String],
               let postsUID = data["posts"] as? [String] {
                if !postsUID.isEmpty && !following.isEmpty {
                    self.fetchPosts(withUIDs: postsUID) { posts in
                        guard let posts = posts else { return }
                        let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, following: following, posts: posts)
                        completion(user)
                        return
                    }
                } else if !postsUID.isEmpty && following.isEmpty {
                    self.fetchPosts(withUIDs: postsUID) { posts in
                        guard let posts = posts else { return }
                        let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, posts: posts)
                        completion(user)
                        return
                    }
                } else if postsUID.isEmpty && !following.isEmpty {
                    let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio, following: following)
                    completion(user)
                    return
                } else if postsUID.isEmpty && following.isEmpty {
                    let user = User(fullPetName: fullPetName, username: username, email: email, type: self.getPetTypeFromString(petString: type), uid: uid, bio: bio)
                    completion(user)
                    return
                } else { return }
            } else {
                print("DEBUG: Error parsing user data to Swift properties")
            }
        }
    }
    
    func fetchPost(withUID uid: String, completion: @escaping (Post) -> Void) {
        Firestore.firestore().collection("posts").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            
            guard let post = try? snapshot.data(as: Post.self) else {
                print("error transforming firestore post into local post")
                return
            }
            
            completion(post)
        }
    }
    
    func fetchPosts(withUIDs uids: [String], completion: @escaping ([Post]?) -> Void) {
        var posts = [Post]()
        let uidsCount = uids.count
        
        var counter = 0
        if uidsCount <= 0 {
            completion(nil)
            return
        }
        for i in 0...(uidsCount - 1) {
            fetchPost(withUID: uids[i]) { post in
                posts.append(post)
                counter += 1
                
                if counter == uidsCount {
                    completion(posts)
                }
            }
        }
    }
    
    func fetchPostsFromUser(userUID: String, completion: @escaping ([Post]?) -> Void) {
        fetchUser(withUID: userUID) { user in
            if let user = user {
                completion(user.posts)
            }
        }
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
    
    func follow(followedUID: String, completion: @escaping () -> Void) {
        if var currentUser = user {
            if (currentUser.following) != nil  {
                if !currentUser.following.contains(followedUID) {
                    currentUser.following.append(followedUID)
                }
            }
            else {
                currentUser.following = [followedUID]
            }
            
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
            
            let notification = Notification(actorUID: currentUser.uid, receiverUID: followedUID, postUID: "follow", description: "\(currentUser.username) followed you")
            self.addNotificationToFirebase(notification: notification)
            
            let followedUserFirestoreRef = Firestore.firestore().collection("users").document(followedUID)
            
            followedUserFirestoreRef.updateData([
                "followers": FieldValue.arrayUnion([currentUser.uid]),
                "notifications": FieldValue.arrayUnion([notification.id])
            ]) { err in
                if let e = err {
                    print("DEBUG: Error saving followers data to firestore (\(e)")
                } else {
                    print("DEBUG: Followers sucessfully updated to firestore")
                    completion()
                }
            }
        }
    }
    
    func unfollow(unfollowedUID: String, completion: @escaping () -> Void) {
        if var currentUser = user {
            if currentUser.following.contains(unfollowedUID) {
                currentUser.following.removeAll(where: { $0 == unfollowedUID})
            }
            
            let userFirestoreRef = Firestore.firestore().collection("users").document(currentUser.uid)
            
            userFirestoreRef.updateData([
                "following": currentUser.following
            ]) { err in
                if let e = err {
                    print("DEBUG: Error saving Removed following data to firestore (\(e)")
                } else {
                    print("DEBUG: Removed Following sucessfully updated to firestore")
                }
            }
            
            let followedUserFirestoreRef = Firestore.firestore().collection("users").document(unfollowedUID)
            
            followedUserFirestoreRef.updateData([
                "followers": FieldValue.arrayRemove([currentUser.uid])
            ]) { err in
                if let e = err {
                    print("DEBUG: Error saving Removed followers data to firestore (\(e)")
                } else {
                    print("DEBUG: Removed Followers sucessfully updated to firestore")
                    completion()
                }
            }
        }
    }
    
    func wasPostLikedByCurrentUser(post: Post) -> Bool {
        guard let currentUser = user else { return false }
        return post.likes.contains(currentUser.uid) ? true : false
    }
    
    func toggleLike(post: Post) {
        if let currentUser = user {
            if post.likes.contains(currentUser.uid) {
                removePostLike(postUID: post.id)
            } else {
                addPostLike(postUID: post.id)
            }
        }
    }
    
    func addPostLike(postUID: String) {
        if let currentUser = user {
            let postFirestoreRef = Firestore.firestore().collection("posts").document(postUID)
            
            postFirestoreRef.updateData([
                "likes": FieldValue.arrayUnion([currentUser.uid])
            ]) { err in
                if let e = err {
                    print("DEBUG: Error saving post like to firestore (\(e)")
                } else {
                    print("DEBUG: Post like sucessfully updated to firestore")
                }
            }
            
            fetchPost(withUID: postUID) { post in
                postFirestoreRef.getDocument(as: Post.self) { result in
                    switch result {
                    case .success(let post):
                        let notification = Notification(actorUID: currentUser.uid, receiverUID: post.authorUID, postUID: post.id, description: "\(currentUser.username) liked your post.")
                        
                        self.addNotificationToFirebase(notification: notification)
                        
                        let userFirestoreRef = Firestore.firestore().collection("users").document(post.authorUID)
                        
                        userFirestoreRef.updateData([
                            "notifications": FieldValue.arrayUnion([notification.id])
                        ]) { err in
                            if let e = err {
                                print("DEBUG: Error saving notifications data to firestore (\(e)")
                            } else {
                                print("DEBUG: Sucessfully saved notifications data to firestore")
                            }
                        }
                    case .failure(let error):
                        print("DEBUG: Error decoding post \(error)")
                    }
                }
            }
        }
    }
    
    func removePostLike(postUID: String) {
        if let currentUser = user {
            let postFirestoreRef = Firestore.firestore().collection("posts").document(postUID)
            
            postFirestoreRef.updateData([
                "likes": FieldValue.arrayRemove([currentUser.uid])
            ]) { err in
                if let e = err {
                    print("DEBUG: Error saving post like to firestore (\(e)")
                } else {
                    print("DEBUG: Post like sucessfully updated to firestore")
                }
            }
        }
    }
    
    func addNotificationToFirebase(notification: Notification) {
        if let currentUser = user {
            do {
                try Firestore.firestore().collection("notifications").document(notification.id).setData(from: notification)
            } catch {
                print("DEBUG: Error updating notification to Firestore")
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
