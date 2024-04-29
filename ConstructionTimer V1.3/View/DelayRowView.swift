//
//  DelayRowView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/29/24.
//

import Foundation
import SwiftUI

struct DelayRowView: View {
    @State  var category: String
    @State  var delayDescription: String
    @State  var categoryColor: String
    @State  var startDate: String
    @State  var totalTime: String
    @State var endTime: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 0) {
                Text(category)
                    .font(.headline)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background {
                        Capsule()
                            .fill(.white.opacity(0.40))
                    }
            }
            
            Text(delayDescription)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical, 12)
                .lineLimit(4)
            
            HStack(alignment: .bottom, spacing: 2) {
                VStack(alignment: .leading, spacing: 10) {
                    Label {
                        Text(startDate)
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.callout)
                    
                    Label {
                        Text(endTime)
                    } icon: {
                        Image(systemName: "deskclock.fill")
                    }
                    
                    Label {
                        Text(totalTime)
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .font(.callout)
                }
                
            }
            
        }
      
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(categoryColor))
        }
    }
}

struct DelayRowView_Preview: PreviewProvider {
    static var previews: some View {
        DelayRowView(category: "GC Delay", delayDescription: "1 hr Grading work grade", categoryColor: "lightYellow", startDate: "03/29/24", totalTime: "0:01:00", endTime: "3:25 PM")
    }
}
