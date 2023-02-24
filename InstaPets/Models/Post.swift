//
//  Post.swift
//  InstaPets
//
//  Created by Gustavo Dias on 23/02/23.
//

import Foundation

struct Post {
    var id = UUID().uuidString
    
    var description: String
    var imageURLS: [URL]
}

extension Post {
    static let example = Post(
        description: "Just had lunch together with my friends from Oregon, it was so nice seeing them again :)",
        imageURLS: [
            URL(string: "https://picsum.photos/1080/1080")!,
            URL(string: "https://picsum.photos/1080/1081")!,
            URL(string: "https://picsum.photos/1080/1082")!,
            URL(string: "https://picsum.photos/1080/1083")!,
        ]
    )
}
