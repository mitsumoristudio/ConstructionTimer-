//
//  RegistrationViewModel.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
//

import Foundation
import SwiftUI

final class RegistrationViewModel: ObservableObject {
    @MainActor
    func createUser(email: String, password: String, fullname: String, username: String) async throws {
        try await AuthService.shared.createNewUser(withEmail: email, password: password, fullName: fullname, userName: username)
        
        print("Created New User")
        
    }
    func resetUserPassword(email: String) async throws {
        try await AuthService.shared.resetUserPassword(withEmail: email)
        
    }
    
}
