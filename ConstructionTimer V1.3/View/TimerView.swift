//
//  TimerView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//  Copyright 2024 Satoshi Mitsumori. All rights reserved.

import Foundation
import SwiftUI

struct TimerView: View {
    var buttonStyleConfig = ButtonStyleService()
    @StateObject private var viewModel = TimerViewModel()
    let notification = NotificationCenter()
    @State private var timeInterval: Double = 30.0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                if viewModel.timeState == .cancelled {
                    timePickerControl
                } else {
                    progressView
                }
                timerControl
               Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.1132417929, green: 0.1132417929, blue: 0.1132417929, alpha: 1)))
        .foregroundColor(.white)
        .navigationBarBackButtonHidden(true)
        }
    }
}

extension TimerView {
    // MARK: ProgressView of timer UIView
    
    var progressView: some View {
        ZStack {
            withAnimation {
                ProgressRing(progress: viewModel.progress)
                    .environmentObject(viewModel)
                    .padding()
            }
            
            VStack(spacing: 5) {
                
                Text(viewModel.secondsToCompletion.asTimestamp)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing: 5) {
                    Image(systemName: "bell.fill")
                    Text(viewModel.completionDate, format: .dateTime.hour().minute())
                }
            }
        }
        .frame(width: 360, height: 250)
        .padding(.all, 32)
    }
}

extension TimerView {
    // MARK: timerPickerControl UIView
    
    var timePickerControl: some View {
        VStack(spacing: 10) {
            HStack(spacing: 5) {
                TimePickerView(title: "hours", range: viewModel.hoursRange, binding: $viewModel.selectedHoursAmount)
                
                TimePickerView(title: "min", range: viewModel.minutesRange, binding: $viewModel.selectedMinutesAmount)
                
                TimePickerView(title: "sec", range: viewModel.secondsRange, binding: $viewModel.selectedSecoundsAmount)
           
            }
            .frame(width: 360, height: 255)
            .padding(.all, 32)
        }
    }
}

extension TimerView {
        // MARK: timerControl UI View
    
    var timerControl: some View {
        HStack {
            Button(action: {
                viewModel.timeState = .cancelled
                
                notification.sendNotification(date: Date(), type: "time", timeInterval: timeInterval, title: "Time Interval", body: "This is a reminder that your time has passed the requested time")
                
            }, label: {
                buttonStyleConfig.cancelbutton()
            })
            Spacer()
            
            switch viewModel.timeState {
            case .active:
                Button(action: {
                    viewModel.timeState = .paused
                }, label: {
                    buttonStyleConfig.pausebutton()
                })
            case .paused:
                Button(action: {
                    viewModel.timeState = .resumed
                }, label: {
                    buttonStyleConfig.pausebutton()
                })
            case .resumed:
                Button(action: {
                    viewModel.timeState = .paused
                }, label: {
                    buttonStyleConfig.pausebutton()
                })
            case .cancelled:
                Button(action: {
                    viewModel.timeState = .active
                    
                    notification.sendNotification(date: Date(), type: "time", timeInterval: timeInterval, title: "Time Interval", body: "This is a reminder that your time has passed the requested time")
                    
                }, label: {
                    buttonStyleConfig.timerStartButton()
                  //  buttonStyleConfig.startbutton()
                })
            }
        }
            .padding(.horizontal, 30)
    }
}

struct TimerView_Preview: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
