//
//  OnboardingViewCell.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import Foundation
import SwiftUI

struct OnboardingViewCell : View {
    let image: String
    let headline: String
    let subheadline: String
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: image)
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(headline)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(subheadline)
                        .font(.headline)
                        .fontWeight(.medium)
                }
            }
        }
    }
}
