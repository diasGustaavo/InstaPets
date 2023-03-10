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
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }

            guard let user = try? snapshot.data(as: User.self) else { return }
            
            self.user = user
        }
    }
    
    func follow(followedUID: String) {
        if var currentUser = user {
            if (currentUser.following) != nil  {
                if !currentUser.following!.contains(followedUID) {
                    currentUser.following!.append(followedUID)
                }
            }
            else {
                currentUser.following = [followedUID]
            }
            print(currentUser)
            
            let userFirestoreRef = Firestore.firestore().collection("users").document(currentUser.uid)
            
            userFirestoreRef.updateData([
                "following": currentUser.following!
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
