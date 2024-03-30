//
//  DelayRowListing.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/29/24.
//

import SwiftUI

struct DelayRowListing: View {
    @StateObject var coremodelVM = CoreDataViewModel()
    
    var body: some View {
     
        NavigationStack {
            VStack(alignment: .leading, spacing: 5) {
                List {
                    ForEach(coremodelVM.savedEntities, id: \.self) { delays in
                        VStack {
                            DelayRowView(category: delays.category ?? "", delayDescription: delays.delayDescription ?? "", categoryColor: delays.categoryColor ?? "", startDate: delays.startDate ?? "", totalTime: delays.totaltime ?? "", endTime: delays.endTime ?? "")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        coremodelVM.deleteDelayTime(indexSet: indexSet)
                    })
                }
                .onAppear {
                    coremodelVM.fetchprojectDelayTime()
                }
            }
            .navigationTitle("Ongoing Delay")
            .navigationBarTitleDisplayMode(.inline)
            
            .refreshable {
                        Task {
                            coremodelVM.fetchprojectDelayTime
                        }
                    }
        }
        
    }
}

struct DelayRowListing_Preview: PreviewProvider {
    static var previews: some View {
        DelayRowListing()
    }
}
