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
        fetchUser()
        fetchAllPostsMainImages()
        toggleFollowButton()
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
        print("toggleFollowButton pressed")
        if let user = user {
            if let userServiceUser = userService.user {
                if userServiceUser.following.contains(user.uid) {
                    print("true")
                    isFollowButtonActivated = true
                    return
                }
            }
        }
        
        print("false")
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
    
    func fetchUser() {
        userService.fetchUser(withUID: uid) { user in
            self.user = user
        }
    }
    
    func fetchAllPostsMainImages() {
        guard let user = user else { return }
        guard let postsUID = user.postsUID else { return }
        
        for imageFolder in postsUID {
            let imagesRef = storageRef.child(imageFolder)
            
            imagesRef.listAll { result, e in
                if let e = e {
                    print("DEBUG: Error listing images \(e.localizedDescription)")
                } else {
                    imagesRef.getData(maxSize: 1 * 1024 * 1024) { data, e in
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
}
