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
}
