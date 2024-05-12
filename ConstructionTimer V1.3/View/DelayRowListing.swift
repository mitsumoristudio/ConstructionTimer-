//
//  DelayRowListing.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/29/24.
// Copyright 2024 Satoshi Mitsumori. All rights reserved.

import SwiftUI

struct DelayRowListing: View {
    @EnvironmentObject var coreDataVM: CoreDataViewModel
    @State private var needtoRefresh: Bool = false
    
    var body: some View {
     
        NavigationStack {
            VStack(alignment: .leading, spacing: 5) {
                List {
                    ForEach(coreDataVM.savedEntities.sorted(by: { $0.endTime ?? "" > $1.endTime ?? "" }), id: \.self) { delays in
                        NavigationLink(destination: {
//                            UpdateDetailView(coreDataVM: coreDataVM, needsRefresh: $needtoRefresh, delayCollection: delays)
                           CategoryCell(coreDataVM: coreDataVM, needtoRefresh: $needtoRefresh, delayCollection: delays)
                        }, label: {
                            VStack {
                                DelayRowView(category: delays.category ?? "", delayDescription: delays.delayDescription ?? "", categoryColor: delays.categoryColor ?? "", startDate: delays.startDate ?? "", totalTime: delays.totaltime ?? "", endTime: delays.endTime ?? "")
                            }
                        })
                    }
                    .onDelete(perform: { indexSet in
                        coreDataVM.deleteDelayTime(indexSet: indexSet)
                    })
                }
                .onAppear {
                   coreDataVM.fetchprojectDelayTime()
                }
            }
            .navigationTitle("Ongoing Delay")
            .navigationBarTitleDisplayMode(.inline)
            
            .refreshable {
                        Task {
                            coreDataVM.fetchprojectDelayTime
                        }
                    }
        }
        
    }
}

struct DelayRowListing_Preview: PreviewProvider {
    static var previews: some View {
        DelayRowListing().environmentObject(CoreDataViewModel())
    }
}
