//
//  Post.swift
//  InstaPets
//
//  Created by Gustavo Dias on 23/02/23.
//

import UIKit

struct Post {
    var id = UUID().uuidString
    
    var description: String?
    var postImages: [PostImage]?
}

extension Post {
    static let example = Post(
        description: "Miau miau miau miau miau miauuuuuuuuuuuuuuu",
        postImages: [
            PostImage(img: UIImage(named: "clebinho1.jpg")!),
            PostImage(img: UIImage(named: "clebinho2.jpg")!),
            PostImage(img: UIImage(named: "charlottinha.jpg")!),
        ]
    )
}
