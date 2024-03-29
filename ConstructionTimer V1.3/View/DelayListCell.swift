//
//  DelayListCell.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import Foundation
import SwiftUI

struct DelayListCell: View {
    @State var category: String = ""
    @State var delayDescription: String = ""
  
    @State var startTime: String = ""
    @State var startDate: String = ""
 
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image("wheel")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 55, height: 55)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(startDate)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    
                    Text("Description: \(category)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("Details: \(delayDescription)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    Text("Start Time: \(startTime)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                }
            }
            .frame(width: 330)
            .frame(maxHeight: .infinity)
            .background(.ultraThickMaterial)
                 .contrast(10)
                 .cornerRadius(20)
        }
    }
}

struct DelayListCell_Preview: PreviewProvider {
    static var previews: some View {
     DelayListCell()
    }
}
