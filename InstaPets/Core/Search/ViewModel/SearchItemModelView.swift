//
//  SearchItemModelView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 17/04/23.
//

import Foundation
import UIKit

class SearchItemModelView: ObservableObject {
    private let service = UserService.shared
    let user: User
    @Published var profileImg = UIImage(named: "minismalistCat")
        
    init(user: User) {
        self.user = user
        fetchUserImage()
    }
    
    func fetchUserImage() {
        service.fetchUserImage(user: self.user) { img in
            self.profileImg = img
        }
    }
}
