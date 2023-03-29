//
//  Notifications.swift
//  InstaPets
//
//  Created by Gustavo Dias on 24/03/23.
//

import Foundation

struct Notification: Identifiable, Codable {
    let id = UUID().uuidString
    
    let actorUID: String
    let receiverUID: String
    let postUID: String
    let description: String
}

extension Notification {
    static let example = Notification(actorUID: User.example.uid, receiverUID: User.example.uid, postUID: Post.example.id, description: "liked your post.")
}
