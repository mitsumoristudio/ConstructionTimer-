//
//  TimerPickerView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import Foundation
import SwiftUI

struct TimePickerView: View {
    let title: String
    let range: ClosedRange<Int>
    let binding: Binding<Int>
    private let pickerViewTitlePadding: CGFloat = 4.0
    
    var body: some View {
        HStack(spacing: -pickerViewTitlePadding) {
            Picker(title, selection: binding) {
                ForEach(range, id: \.self) { timeIncrement in
                    HStack {
                        Spacer()
                        Text("\(timeIncrement)")
                            .foregroundStyle(Color.white)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .pickerStyle(InlinePickerStyle())
            .labelsHidden()
            
            Text(title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
        }
    }
}

struct TimePickerView_Preview: PreviewProvider {
    static var previews: some View {
        TimePickerView(title: "TimePicker", range: 0...59, binding: Binding.constant(0))
    }
}



