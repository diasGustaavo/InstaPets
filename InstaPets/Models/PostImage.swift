//
//  PostImage.swift
//  InstaPets
//
//  Created by Gustavo Dias on 22/02/23.
//

import UIKit

struct PostImage: Identifiable {
    let content: UIImage
    let id = NSUUID().uuidString
}
