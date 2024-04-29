//
//  ContentViewModel.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
//

import Foundation
import Combine
import Firebase


final class ContentViewModel : ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()// used for signing out user
    
    init() {
        setupSubcribers()
    }
    
    private func setupSubcribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession // to avoid retaining cycle weak self
        }.store(in: &cancellables)
        
    }
}

