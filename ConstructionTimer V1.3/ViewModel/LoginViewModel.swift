//
//  LoginViewModel.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
//  Copyright 2024 Satoshi Mitsumori. All rights reserved.

import Foundation
import AuthenticationServices
import SwiftUI
import Firebase


final class LoginViewModel: ObservableObject {
    @Environment (\.dismiss) var dismiss
    
    @MainActor
    func loginUser(email: String, password: String) async throws {
        try await AuthService.shared.loginUser(withEmail: email, password: password)
        
    }
    
    @MainActor
    func signInwithGoogle() async throws {
        try await AuthService.shared.signInWithGoogle()
    //    try await AuthService.shared.signInWithGoogle()
   
    }
}
