//
//  ProgressRing.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import Foundation
import SwiftUI

struct ProgressRing: View {
    @State var progress: CGFloat = 0.0
    @EnvironmentObject var progressVM : TimerViewModel

    
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
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)), Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)), Color(#colorLiteral(red: 0.5921568627, green: 0.8509803922, blue: 0.8823529412, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 360))
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.0), value: progressVM.progress)
        }
        .frame(width: 300, height: 300)
        .padding()
    }
}

struct ProgressRing_Preview: PreviewProvider {
    static var previews: some View {
        ProgressRing().environmentObject(TimerViewModel())
    }
}

extension Int {
    var asTimestamp: String {
        let hour = self / 3600
        let minute = self / 60 % 60
        let second = self % 60
        
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
}



