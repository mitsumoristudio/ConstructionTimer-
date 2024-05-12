//
//  CircularProfileImageView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
// Copyright 2024 Satoshi Mitsumori. All rights reserved.

import Foundation
import SwiftUI
import Kingfisher

struct CircularProfileImageView: View {
    @State var user: UserModel?
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl { // if the user has a urlString, it will load the kingfisher image
           KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
            // Image("stashville")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .foregroundColor(.gray).opacity(0.7)
        }
    }
        
    }
