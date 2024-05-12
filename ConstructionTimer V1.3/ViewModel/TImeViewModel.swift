//
//  TImeViewModel.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//  Copyright 2024 Satoshi Mitsumori. All rights reserved.

import Foundation
import SwiftUI

enum TimeState {
    case active
    case paused
    case resumed
    case cancelled
}

final class TimerViewModel: ObservableObject {
    @Published var selectedHoursAmount = 0
    @Published var selectedMinutesAmount = 1
    @Published var selectedSecoundsAmount = 0
    
    let hoursRange = 0...23
    let minutesRange = 0...59
    let secondsRange = 0...59
    
    init() {
        let calender = Calendar.current
        let components = DateComponents(hour: 0)
        let scheduleTime = calender.nextDate(after: .now, matching: components, matchingPolicy: .nextTime)!
      //  print("schedule Time", scheduleTime.formatted(.dateTime.month().day().hour().minute().second()))
        startTime = scheduleTime
        endTime = scheduleTime.addingTimeInterval(1)
    }
    
    private var timer = Timer()
    private var totalTimeForCurrentSelection: Int {
        (selectedHoursAmount * 3600) + (selectedMinutesAmount * 60) + selectedSecoundsAmount
    }
    
    @Published var secondsToCompletion = 0
    @Published var progress: CGFloat = 0.0
    @Published var completionDate = Date.now
    
    private func updateCompletionDate() {
        completionDate = Date.now.addingTimeInterval(Double(secondsToCompletion))
    }
    
    @Published private(set) var startTime: Date {
        didSet {
            print("Start Time", startTime.formatted(.dateTime.month().day().hour().minute().second()))
        }
    }
    
    @Published private(set) var endTime: Date {
        didSet{
            print("End Time", endTime.formatted(.dateTime.month().day().hour().minute().second()))
        }
    }
    
    private func startTiming() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            
            self.secondsToCompletion -= 1
            self.progress = CGFloat(Float(self.secondsToCompletion) / Float(self.totalTimeForCurrentSelection))
            
            if self.secondsToCompletion < 0 {
                self.timeState = .cancelled
            }
        })
    }
    
    @Published var timeState: TimeState = .cancelled {
        didSet {
            switch timeState {
            case .active:
                startTiming()
                
                secondsToCompletion = totalTimeForCurrentSelection
                progress = 1.0
                
                updateCompletionDate()
                
            case .paused:
                timer.invalidate()
            case .resumed:
                startTiming()
                
                updateCompletionDate()
                
            case .cancelled:
                timer.invalidate()
                secondsToCompletion = 0
                progress = 0
            }
        }
    }
}



