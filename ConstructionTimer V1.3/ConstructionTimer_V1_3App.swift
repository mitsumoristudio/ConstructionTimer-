//
//  ConstructionTimer_V1_3App.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

class AppDelegates: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
    
    internal func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct ConstructionTimer_V1_3App: App {
    @UIApplicationDelegateAdaptor(AppDelegates.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(LoginViewModel())
          //  ContentView().environmentObject(CoreDataViewModel())
        //    MainTabView().environmentObject(CoreDataViewModel())
            // MARK: Set coredataviewmodel in JikanView to environmentObject
        }
    }
}

