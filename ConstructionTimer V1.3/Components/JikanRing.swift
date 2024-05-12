//
//  JikanRing.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
// Copyright 2024 Satoshi Mitsumori. All rights reserved.

import Foundation
import SwiftUI

struct JikanRing: View {
    @State var progress: CGFloat = 0.0
    @EnvironmentObject var progressVM : JikanViewModel
 
    func rotationalCircle() -> some View {
        Circle()
            .stroke(lineWidth: 20)
            .foregroundColor(Color.gray)
            .opacity(0.2)
    }
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            rotationalCircle()
            
            Circle()
                .trim(from: 0.0, to: min(progressVM.progress, 1.0))
            
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)), Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)), Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)), Color(#colorLiteral(red: 0.5921568627, green: 0.8509803922, blue: 0.8823529412, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 360))
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.0), value: progressVM.progress)
        }
        .frame(width: 300, height: 290)
        .padding()
        
    }
}

extension Int {
    var asTimestamps: String {
        let hour = self / 3600
        let minute = self / 60 % 60
        let second = self % 60
        
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
}



