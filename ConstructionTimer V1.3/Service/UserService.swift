//
//  UserService.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class UserService {
    @Published var currentUser: UserModel?
    
    static let shared = UserService()
    
    init() {
        Task {
            try await fetchCurrentUser()
        }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let userDocument = try snapshot.data(as: UserModel.self)
        self.currentUser = userDocument
    }
    
    static func fetchUserUid(withUid uid: String) async throws -> UserModel {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: UserModel.self)
    }
    
    func resetUsers() {
        self.currentUser = nil // used to reset currentUser
    }
}
