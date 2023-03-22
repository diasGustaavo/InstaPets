//
//  Post.swift
//  InstaPets
//
//  Created by Gustavo Dias on 23/02/23.
//

import UIKit

struct Post: Codable, Hashable, Identifiable {
    var id = UUID().uuidString
    
    var description: String
    var postImages: [String]
    var authorUID: String
    var dateEvent: Date
    var likes = [String]()
}

extension Post {
    static let example = Post(
        description: "Miau miau miau miau miau miauuuuuuuuuuuuuuu",
        postImages: [
            "teste1",
            "teste2",
            "teste3",
        ], authorUID: "12345678", dateEvent: Date()
    )
    
    static let postsUIDExample = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString]
}
