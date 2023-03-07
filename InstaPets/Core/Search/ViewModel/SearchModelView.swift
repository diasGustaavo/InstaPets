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
    
    func fetchMostRecentUsers() {
        let _: Void = Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                print(documents)
                
                let searchedUsers = documents.compactMap({ try? $0.data(as: User.self) })
                self.searchedUsers = searchedUsers
            }
    }
    
//    func searchUsers(withUsername username: String) -> [User] {
//        Firestore.firestore().collection("users")
//
//    }
}
