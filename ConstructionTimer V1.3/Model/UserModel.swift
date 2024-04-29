//
//  UserModel.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct UserModel: Identifiable, Codable {
    @DocumentID var id: String?
    let email: String
    let fullname: String
    let uid: String
    let username: String
    var profileImageUrl: String?
}
