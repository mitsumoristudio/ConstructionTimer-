//
//  LoginViewModel.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
//

import Foundation
import AuthenticationServices
import SwiftUI
import Firebase
import CryptoKit


final class LoginViewModel: ObservableObject {
    
    @MainActor
    func loginUser(email: String, password: String) async throws {
        try await AuthService.shared.loginUser(withEmail: email, password: password)
        
    }
    
    @MainActor
    func singInwithGoogle() async throws {
        try await AuthService.shared.signInwithGoogle()
    }
}
