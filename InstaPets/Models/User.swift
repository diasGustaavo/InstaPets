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

enum Sex: String, CaseIterable, Identifiable, Codable {
    case female, male, other
    var id: Self { self }
}

struct User: Codable {
    let fullPetName: String
    let username: String
    let email: String
    let sex: Sex
    let type: PetType
    let uid: String
}
