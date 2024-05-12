//
//  MainTabView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
// Copyright 2024 Satoshi Mitsumori. All rights reserved.

import Foundation
import SwiftUI

struct MainTabView: View {
    @AppStorage("log_Status") var log_Status: Bool = false
    
    var body: some View {
        VStack {
            TabView {
                JikanView()
                    .tabItem {
                        VStack {
                            Image(systemName: "timer")
                            Text("Delay Timer")
                        }
                    }
                    .tag(0)
                
                DelayRowListing()
            //    DelayListView()
                    .tabItem {
                        VStack {
                            Image(systemName: "list.bullet.circle")
                            Text("List")
                        }
                    }
                    .tag(1)
                
                TimerView()
                    .tabItem {
                        VStack {
                            Image(systemName: "clock.arrow.circlepath")
                            Text("StopWatch")
                        }
                    }
                    .tag(2)
                
               CurrentUserProfileView()
                    .tabItem {
                        VStack {
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                        }
                    }
                    .tag(3)
                
            }
        }
        .overlay(
        MessageView())
       
        }
    }
    

struct MainTabView_preview: PreviewProvider {
    static var previews: some View {
        MainTabView().environmentObject(CoreDataViewModel())
    }
}

