//
//  UpdateDetailView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/4/24.
//

import Foundation
import SwiftUI

struct UpdateDetailView: View {
    @StateObject var coreDataVM: CoreDataViewModel
    @State private var category: String = ""
    @State private var delayDescription: String = ""
    @Binding var needsRefresh: Bool
    let delayCollection: JikanEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField(delayCollection.category ?? "", text: $category)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField(delayCollection.delayDescription ?? "", text: $delayDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                if !category.isEmpty {
                    delayCollection.category = category
                    delayCollection.delayDescription = delayDescription
                    
                    coreDataVM.saveDelays()
                   // coreDataVM.saveConstructionTime()
                    needsRefresh.toggle()
                }
            }, label: {
                Text("Update")
                    .foregroundStyle(Color.white)
                    .font(.title2)
            })
            .frame(width: 120, height: 50)
            .background(Color.indigo)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
    }
}
