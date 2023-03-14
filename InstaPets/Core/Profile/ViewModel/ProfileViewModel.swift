//
//  ProfileViewModel.swift
//  InstaPets
//
//  Created by Gustavo Dias on 13/03/23.
//

import Firebase
import FirebaseFirestoreSwift

class ProfileViewModel: ObservableObject {
    let uid: String
    @Published var user: User?
    
    private let userService = UserService.shared
    
    init(uid: String) {
        self.uid = uid
        fetchUser()
    }
    
    func follow() {
        if let user = user {
            userService.follow(followedUID: user.uid)
        }
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
        return user?.following?.count ?? 0
    }
    
    var followersNum = 69
    
    func fetchUser() {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            
            guard let user = try? snapshot.data(as: User.self) else { return }
            
            self.user = user
        }
    }
}
