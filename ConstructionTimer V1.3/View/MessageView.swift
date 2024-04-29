//
//  MessageView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import Foundation
import SwiftUI

struct MessageView: View {
    @State var timerset: Double = 0.0
    @State var showMessage: Bool = true
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    func titleFormat(title: String) -> some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            titleFormat(title: "Welcome to Construction Timer")
            
            OnboardingViewCell(image: "clock.arrow.circlepath", headline: "Easy Formatting", subheadline: "Set specific delays and group them in category, provides setback duration. ")
            
            OnboardingViewCell(image: "list.clipboard.fill", headline: "Simplify Construction Delay", subheadline: "Navigate through contractors delays by managing loss time")
            
            OnboardingViewCell(image: "deskclock.fill", headline: "Countdown Timer", subheadline: "Keep track of meaningful delays with ease and offers a clear view of remaining time")

            Button {
                withAnimation {
                    showMessage = false
                }
            } label: {
                Text("Next")
                    .fontWeight(.medium)
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                    .accentColor(.primary)
            }
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 30)
        .padding(.vertical, 40)
        .background(VisualEffectBlur(blurStyle: .systemUltraThinMaterialLight))
        .cornerRadius(30)
        .shadow(radius: 20)
        .padding(20)
        .opacity(showMessage ? 1: 0)
        .offset(y: showMessage ? 0: 220)
        .blur(radius: showMessage ? 0: 20)
        
        }
    }

struct MessageView_Preview: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
