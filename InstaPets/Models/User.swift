//
//  User.swift
//  InstaPets
//
//  Created by Gustavo Dias on 20/02/23.
//

import Firebase

enum PetType: String, CaseIterable, Identifiable, Codable {
    case cat
    case wildcat
    case dog
    case rabbit
    case aligator
    case rat
    case snake
    case hamster
    var id: Self { self }
}

struct User: Codable {
    let fullPetName: String
    let username: String
    let email: String
    let type: PetType
    let uid: String
    
    var petEmoji: String {
        switch type {
        case .cat:
            return "🐱"
        case .wildcat:
            return "🐱"
        case .dog:
            return "🐶"
        case .rabbit:
            return "🐰"
        case .aligator:
            return "🐊"
        case .rat:
            return "🐀"
        case .snake:
            return "🐍"
        case .hamster:
            return "🐹"
        }
    }
}
