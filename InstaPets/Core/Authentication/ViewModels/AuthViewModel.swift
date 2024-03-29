//
//  AuthViewModel.swift
//  InstaPets
//
//  Created by Gustavo Dias on 21/02/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = false

    private var handle: AuthStateDidChangeListenerHandle?
    
    public var currentUserUID: String? {
        return currentUser?.uid
    }
    
    private let service = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
        handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.isLoggedIn = user != nil
        }
    }
    
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let e = error {
                print("DEBUG: Failed to sign in with error: \(e.localizedDescription)")
                return
            }
            self.userSession = result?.user
            UserService.shared.fetchUserAndDo {
                self.fetchUser()
            }
        }
    }
    
    func registerUser(fullPetName: String, username: String, withEmail email: String, type: PetType, withPassword password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let e = error {
                print("DEBUG: Failed to sign up with error: \(e.localizedDescription)")
                return
            }
            
            guard let firebaseUser = result?.user else {
                print("DEBUG: error getting firebase user")
                return
            }
            self.userSession = firebaseUser
            UserService.shared.fetchUserAndDo {
                self.fetchUser()
            }
            
            let user = User(fullPetName: fullPetName, username: username, email: email, type: type, uid: firebaseUser.uid, bio: "")
            self.currentUser = user
            
            guard let encodedUser = try? Firestore.Encoder().encode(user) else {
                print("DEBUG: error getting firebase user")
                return
            }
            Firestore.firestore().collection("users").document(firebaseUser.uid).setData(encodedUser)
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            UserService.shared.user = nil
        } catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    // FETCH USER FUNCTION W/O COMBINE
    
//    func fetchUser() {
//        UserService().fetchUser { user in
//            self.currentUser = user
//        }
//    }
    
    func fetchUser() {
        service.$user
            .sink { user in
                self.currentUser = user
            }
            .store(in: &cancellables)
        
    }
}
