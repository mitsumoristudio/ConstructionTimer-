//
//  ConstructionTimer_V1_3App.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import SwiftUI

@main
struct ConstructionTimer_V1_3App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
         //   ContentView()
            MainTabView().environmentObject(CoreDataViewModel())
            // MARK: Set coredataviewmodel in JikanView to environmentObject
        }
    }
}
