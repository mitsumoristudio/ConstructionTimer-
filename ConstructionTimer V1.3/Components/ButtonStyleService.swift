//
//  ButtonStyleService.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
// Copyright 2024 Satoshi Mitsumori. All rights reserved.


import Foundation
import SwiftUI

struct ButtonStyleService {
    func pausebutton() -> some View {
        Text("Pause")
            .fontWeight(.semibold)
            .font(.title2)
            .padding()
            .frame(width: 100, height: 200)
            .foregroundStyle(.white)
            .background(Color(#colorLiteral(red: 0.3030837766, green: 0.7372360325, blue: 0.8846649485, alpha: 0.8470588235)))
            .clipShape(Circle())
            .shadow(radius: 10)
    }
    
    func startbutton() -> some View {
        Text("Start")
            .fontWeight(.semibold)
            .font(.title2)
            .padding()
            .frame(width: 100, height: 200)
            .foregroundStyle(.white)
           // .background(Color(#colorLiteral(red: 0.1923083849, green: 0.6083164035, blue: 0.2002578062, alpha: 1)))
            .background(Color(#colorLiteral(red: 0, green: 0.6158103347, blue: 0.1219210401, alpha: 0.6241721854)))
            .clipShape(Circle())
            .shadow(radius: 10)
    }
    
    func timerStartButton() -> some View {
        Text("Start")
            .fontWeight(.semibold)
            .font(.title2)
            .padding()
            .frame(width: 100, height: 200)
            .foregroundStyle(.white)
           // .background(Color(#colorLiteral(red: 0.1923083849, green: 0.6083164035, blue: 0.2002578062, alpha: 1)))
            .background(Color(#colorLiteral(red: 0.08203943819, green: 0.3224852085, blue: 0.9777283072, alpha: 0.8851407285)))
            .clipShape(Circle())
            .shadow(radius: 10)
    }
    
    func cancelbutton() -> some View {
        Text("Cancel")
            .fontWeight(.semibold)
            .font(.title2)
            .padding()
            .frame(height: 100)
            .foregroundStyle(.white)
            .background(Color.gray)
            .clipShape(Circle())
            .shadow(radius: 10)
    }
    
    func recordButton2(color: Color, text: String) -> some View {
        Text(text)
            .fontWeight(.semibold)
            .font(.title3)
            .lineLimit(2)
            .padding()
            .frame(width: 100, height: 200)
            .foregroundColor(.white)
            .background(color)
            .clipShape(Circle())
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
    
    func recordbutton() -> some View {
        Text("Record")
            .fontWeight(.semibold)
            .font(.title3)
            .lineLimit(1)
            .padding()
            .frame(width: 100, height: 200)
            .foregroundColor(.white)
            .background(Color(#colorLiteral(red: 0.3630844653, green: 0.3664460778, blue: 1, alpha: 1)))
            .clipShape(Circle())
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
    
    func stopRecording() -> some View {
        Text("Stop Recording")
            .fontWeight(.semibold)
            .font(.title3)
            .lineLimit(1)
            .padding()
            .frame(width: 100, height: 200)
            .foregroundColor(.white)
            .background(Color(#colorLiteral(red: 1, green: 0.1614242494, blue: 0.02747139335, alpha: 0.8685844371)))
            .clipShape(Circle())
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}




