//
//  DelayListView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import Foundation
import SwiftUI

struct DelayListView: View {
    @StateObject var coreModelVM = CoreDataViewModel()
    
    var body: some View {
        NavigationStack {
    
            VStack(alignment: .leading, spacing: 5) {
                List {
                    ForEach(coreModelVM.savedEntities, id: \.self) { delays in
                        VStack(alignment: .leading, spacing: 5) {
                            if let startTime = delays.starttime {
                            if let startDate = delays.starttime {
                                if let details = delays.delayDescription {
                                    if let category = delays.category {
                                        DelayListCell(category: category, delayDescription: details, startTime: startTime, startDate: startDate)
                                    }
                                }
                                }
                            }
                            if let totaltime = delays.totaltime {
                                if let endtime = delays.endTime {
                                    HStack {
                                        VStack() {
                                            Text("End Time: \(endtime)")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .padding(.horizontal, 40)
                                            Text("Total Time:  \(totaltime)")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .padding(.horizontal, 40)
                                        }
                                    }
                                    .background(.ultraThinMaterial)
                                    .frame(maxWidth: .infinity)
                                }
                            }
                        }
                        
                    }
                    .onDelete(perform: { indexSet in
                        coreModelVM.deleteDelayTime(indexSet: indexSet)
                    })
                }
            }
            .refreshable {
                Task {
                    coreModelVM.fetchprojectDelayTime()
                }
            }
        }
    }
}
