//
//  CurrentuserProfileViewModel.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
//

import Foundation
import SwiftUI
import Combine

class CurrentuserProfileViewModel: ObservableObject {
    @Published var currentUser: UserModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
    }
}
