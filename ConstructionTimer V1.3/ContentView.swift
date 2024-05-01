//
//  ContentView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var log_Status: Bool = true 
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainTabView().environmentObject(CoreDataViewModel())
        
            } else if log_Status {
                MainTabView().environmentObject(CoreDataViewModel())
         
//            if viewModel.userSession != nil && log_Status {
//                MainTabView().environmentObject(CoreDataViewModel())
                
                
            } else {
                LoginView().environmentObject(ContentViewModel())
            }
        }
    }
}

#Preview {
    ContentView()
}
