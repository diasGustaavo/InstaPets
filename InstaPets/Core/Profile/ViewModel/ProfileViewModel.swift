//
//  ProfileViewModel.swift
//  InstaPets
//
//  Created by Gustavo Dias on 13/03/23.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import UIKit

class ProfileViewModel: ObservableObject {
    let uid: String
    @Published var user: User?
    @Published var userPhotos = [UIImage]()
    @Published var isFollowButtonActivated = false
    
    private let userService = UserService.shared
    let storage = Storage.storage()
    let storageRef: AnyObject
    
    init(uid: String) {
        self.uid = uid
        storageRef = storage.reference()
        userService.fetchUser(withUID: uid, completion: { user in
            self.user = user
            self.fetchAllPostsMainImages()
            self.toggleFollowButton()
        })
    }
    
    func follow() {
        if let user = user {
            userService.follow(followedUID: user.uid) {
                self.userService.fetchUserAndDo {
                    self.toggleFollowButton()
                }
            }
        }
    }
    
    func unfollow() {
        if let user = user {
            userService.unfollow(unfollowedUID: user.uid) {
                self.userService.fetchUserAndDo {
                    self.toggleFollowButton()
                }
            }
        }
    }
    
    func toggleFollowButton() {
        if let user = user {
            if let userServiceUser = userService.user {
                if userServiceUser.following.contains(user.uid) {
                    isFollowButtonActivated = true
                    return
                }
            }
        }
        
        isFollowButtonActivated = false
    }
    
    var username: String {
        return user?.username ?? ""
    }
    
    var fullname: String {
        return user?.fullPetName ?? ""
    }
    
    var bio: String {
        return user?.bio ?? ""
    }
    
    var postNum: Int {
        return user?.postsUID?.count ?? 0
    }
    
    var followingNum: Int {
        return user?.following.count ?? 0
    }
    
    var followersNum = 69
    
    func fetchAllPostsMainImages() {
        guard let user = user else { return }
        guard let postsUID = user.postsUID else { return }
        
        for imageFolder in postsUID {
            let storageRef = Storage.storage().reference(withPath: imageFolder)
            
            // List all items in the folder
            storageRef.listAll { (result, error) in
                if let error = error {
                    print("Error listing files: \(error.localizedDescription)")
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
                            
                            self.userPhotos.append(image)
                        }
                    }
                }
            }
        }
    }
}
