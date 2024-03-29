//
//  JikanViewModel.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import Foundation
import SwiftUI

enum JikanStates {
    case active
    case paused
    case resumed
    case cancelled
    case record
    case stoprecording
}

final class JikanViewModel: ObservableObject {
    @Published var secondsToCompletion = 0
    @Published var progress: CGFloat = 0.0
    @Published var completionDate = Date.now
    
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var updateTimer: Timer?
    
    
    init() {
        let calender = Calendar.current
        let components = DateComponents(hour: 0)
        let scheduledTime = calender.nextDate(after: .now, matching: components, matchingPolicy: .nextTime)!
    //    print("scheduled time", scheduledTime.formatted(.dateTime.month().day().hour().minute().second()))
        
        startTime = scheduledTime
        endTime = scheduledTime.addingTimeInterval(1)
    }
    
    private var timer: Timer?
  //  private var timer = Timer()
    private var totalTimeForCurrentSelection: Int = 0
    
    // MARK: - backgroundTask
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            print("iOS has signaled time has expired")
            self?.endBackgroundTaskIfActive()
        }
    }
    
    func endBackgroundTaskIfActive() {
        let isBackgroundTaskActive = backgroundTask != .invalid
        if isBackgroundTaskActive {
            print("Background Task has ended")
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
    
    func onChangeofScenePhase(_ newPhase: ScenePhase) {
        switch newPhase {
        case .background:
            let isTimerRunning = timer != nil
            let isTaskUnregistered = backgroundTask == .invalid
            
            if isTimerRunning && isTaskUnregistered {
                registerBackgroundTask()
            }
        case .active:
            endBackgroundTaskIfActive()
        default:
            break
        }
        
    }
    
    private func updateCompletionDate() {
        completionDate = Date.now.addingTimeInterval(Double(secondsToCompletion))
    }
    
    @Published private(set) var startTime: Date {
        didSet {
            print("Start Time", startTime.formatted(.dateTime.month().day().hour().minute().second()))
        }
    }
    @Published private(set) var endTime: Date {
        didSet {
            print("End Time", endTime.formatted(.dateTime.month().hour().minute().second()))
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            
            self.secondsToCompletion += 1
          //  print("elapsed Time", secondsToCompletion)
            
            if self.secondsToCompletion < 0 {
                self.timeStates = .cancelled
            
            }
        })
    }
    @Published var timeStates: JikanStates = .cancelled {
        didSet {
            switch timeStates {
            case .active:
                startTimer()
                
                secondsToCompletion = totalTimeForCurrentSelection
                progress = 1.0
                
                updateCompletionDate()
                
            case .paused:
                timer?.invalidate()
            case .resumed:
                startTimer()
                
                updateCompletionDate()
                
            case .cancelled:
                timer?.invalidate()
                secondsToCompletion = 0
                progress = 0
                
//            case .record:
//                timer?.invalidate()
//                secondsToCompletion = 0
//                progress = 0
            case .record:
                startTimer()
                secondsToCompletion = totalTimeForCurrentSelection
                progress = 1.0
                updateCompletionDate()
                
            case .stoprecording:
                timer?.invalidate()
               
            }
        }
    }
    
}



