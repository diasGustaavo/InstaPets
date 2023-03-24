//
//  Notifications.swift
//  InstaPets
//
//  Created by Gustavo Dias on 24/03/23.
//

import Foundation

struct Notification: Identifiable {
    let id = UUID().uuidString
    
    let actor: User
    let post: Post
    let description: String
}

extension Notification {
    static let example = Notification(actor: User.example, post: Post.example, description: "liked your post.")
}
