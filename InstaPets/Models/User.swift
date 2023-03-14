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

struct User: Codable, Hashable {
    let fullPetName: String
    let username: String
    let email: String
    let type: PetType
    let uid: String
    var bio: String?
    var following: [String]?
    var posts: [Post]?
    
    var postsUID: [String]? {
        if let posts = posts {
            return posts.map { $0.id }
        }
        else {
            return nil
        }
    }
    
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
    
    func getPetTypeFromString(petString: String) -> PetType {
        switch petString {
        case "cat":
            return PetType.cat
        case "wildcat":
            return PetType.wildcat
        case "dog":
            return PetType.dog
        case "rabbit":
            return PetType.rabbit
        case "aligator":
            return PetType.aligator
        case "rat":
            return PetType.rat
        case "snake":
            return PetType.snake
        case "hamster":
            return PetType.snake
        default:
            return PetType.cat
        }
    }
}


extension User {
    static let example = User(fullPetName: "clebinho da silva", username: "clebinhoo", email: "clebinho@icloud.com", type: .cat, uid: NSUUID().uuidString, bio: "As I've always said: Miau miau miau 🐈")
}
