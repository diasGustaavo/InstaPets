//
//  Comment.swift
//  InstaPets
//
//  Created by Gustavo Dias on 23/03/23.
//

import Foundation

struct Comment: Identifiable {
    let id = UUID().uuidString
    
    let description: String
    let authorID: String
    let authorUsername: String
}

extension Comment {
    static let example = Comment(description: "loolllll such a fat cattttt", authorID: UUID().uuidString, authorUsername: "diasgustaavo")
}
