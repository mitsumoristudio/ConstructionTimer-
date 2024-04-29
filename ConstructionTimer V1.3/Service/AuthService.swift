//
//  AuthService.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

import GoogleSignIn
import GoogleSignInSwift

final class AuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var didsendPasswordReset: Bool = false
    
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func loginUser(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            
            // MARK: fetchCurrentUser 
            try await UserService.shared.fetchCurrentUser()
            
        } catch {
            print("Debug failed to create user with error \(error.localizedDescription)")
            
        }
    }
    
    @MainActor
    func resetUserPassword(withEmail email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            self.didsendPasswordReset = true
            
        } catch {
            print("Debug: Failed to reset user password \(error.localizedDescription)")
        }
        
        
    }
    
    
    func signOutUser() {
        try? Auth.auth().signOut() // Signout user on backend
        self.userSession = nil // this removes the session locally and updates routing
        UserService.shared.resetUsers() // reset suers. sets the current user object to nil
    }
    
    @MainActor
    func createNewUser(withEmail email: String, password: String, fullName: String, userName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            try await uploadUserInfo(withEmail: email, fullname: fullName, username: userName, uid: result.user.uid)
            
            print("Debug: Create user \(result.user.uid)")
            // MARK: Come back
            
        } catch {
            print("Debug Failed to create user with error \(error.localizedDescription)")
        }
        
    }
    
    @MainActor
    private func uploadUserInfo(withEmail email: String, fullname: String, username: String, uid: String) async throws {
        let user = UserModel(email: email, fullname: fullname, uid: uid, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(uid).setData(userData)
        
        UserService.shared.currentUser = user // when we signin our user, it will automatically set up the currentUser
        
    }
    
    // MARK: - SignIn with Google using
    
    @MainActor
    func signInwithGoogle() async throws -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID was found in Firebase configuration")
        }
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("There is no root view controller")
            return false
        }
        do {
            let userAutentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAutentication.user
            guard let idToken = user.idToken else {
                throw fatalError("ID token Missing")
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            return true
            
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
}

