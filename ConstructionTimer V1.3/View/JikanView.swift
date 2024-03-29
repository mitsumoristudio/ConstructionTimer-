//
//  JikanView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import Foundation
import SwiftUI

struct JikanView: View {
    var buttonStyleConfig = ButtonStyleService()
    @StateObject var viewModel = JikanViewModel()
    @Environment(\.scenePhase) var scenePhase
 //   @StateObject var coreDataVM: CoreDataViewModel
   @EnvironmentObject var coreDataVM : CoreDataViewModel
    @EnvironmentObject var jikanEntity : JikanEntity
    @Environment(\.self) var enviornmentSelf
    
    let notification = NotificationCenter()
    @State var actualDelay : delayEnum = .none
    @State private var isPlaying: Bool = false
    @State private var delayEncountered: String = "1 hr GC delay"
    var backgroundGradientlight =  Color(#colorLiteral(red: 0.2496928573, green: 0.2774389088, blue: 0.2719847858, alpha: 0.8977390315))
    
    
    private func subheadlineText(withPlaceholder placeholder: String) -> some View {
        Text(placeholder)
            .foregroundStyle(Color.white)
            .font(.title2)
            .fontWeight(.bold)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack(spacing: 5) {
                    progressViewTimer
                    
                    timerControlView
                    
                    delaytextFieldView
                }
              
                .offset(x: 0, y: -0)
                // add the offset to move column grid above
                Spacer()
            }
            .onChange(of: scenePhase) { _ , newPhase in
                viewModel.onChangeofScenePhase(newPhase)
            }
        }
    }
    
    @ViewBuilder
    var progressViewTimer: some View {
        ZStack {
            withAnimation {
                JikanRing(progress: viewModel.progress)
                    
//                ProgressRing(progress: viewModel.progress)
                    .environmentObject(viewModel)
            }
            VStack(spacing: 5) {
                
                
                Text(viewModel.secondsToCompletion.asTimestamps)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack(spacing: 5) {
                    Image(systemName: "bell.fill")
                    Text(viewModel.completionDate, format: .dateTime.hour().minute())
                }
            }
        }
        .frame(width: 360, height: 240)
        .padding()
        .offset(x:0, y: 30)
    }
}

extension JikanView {
    // MARK: timerControl View
    var timerControlView: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.timeStates = .cancelled
                    
                }, label: {
                    buttonStyleConfig.cancelbutton()
                })
                
                Button(action: {
                    isPlaying.toggle()
                    
                    let dateNow = Date()
                    let dtFormatter = DateFormatter()
                        dtFormatter.dateStyle = .full
                        dtFormatter.timeStyle = .short
                    
                    let timeonlyFormatter = DateFormatter()
                    timeonlyFormatter.dateStyle = .full
                    timeonlyFormatter.timeStyle = .none
                    let timeformatDateTime = timeonlyFormatter.string(from: dateNow)
                    
                    let timeNow = DateFormatter()
                    timeNow.dateStyle = .none
                    timeNow.timeStyle = .long
                    let checkTimeNow = timeNow
                    let laterTimeNow = timeNow
                    let timeOnlyformat = laterTimeNow.string(from: dateNow)
                    
//                    isPlaying ? coreDateVM.addConstructionStartTime(category: actualDelay.rawValue, delayDescription: delayEncountered, startTime: "", startDate: timeformatDateTime) : coreDateVM.addConstructionEndTime(endTime: laterTimeNow.string(from: Date()), totalTime: viewModel.secondsToCompletion.asTimestamps)
                    
//                    isPlaying ? coreDataVM.addTime(topic: actualDelay.rawValue, startDate: timeformatDateTime, delay: delayEncountered, startTime: checkTimeNow.string(from: Date())) : coreDataVM.endDelayTime(finishTime: laterTimeNow.string(from: Date()))
                    isPlaying ? coreDataVM.addTestTime() : coreDataVM.addEndTime(category: actualDelay.rawValue, delayDescription: delayEncountered, categoryColor: coreDataVM.categoryColor, endTime: timeOnlyformat, totalTime: viewModel.secondsToCompletion.asTimestamps, startDate: timeformatDateTime)
                    
//                    isPlaying ? coreDataVM.addTestTime() : coreDataVM.addendtimeEntity(context: enviornmentSelf.managedObjectContext)
                    
                    viewModel.timeStates = isPlaying ? .active : .cancelled
                }, label: {
                    buttonStyleConfig.recordButton2(color: isPlaying ? .red : .indigo, text: isPlaying ? "Stop Record": "Record")
                })
                .onTapGesture {
                    withAnimation(Animation.spring()) {
                        self.isPlaying.toggle()
                      
                    }
                }
                .padding(.horizontal, 20)
             //   Spacer()
                // MARK: - Multi-state button in swiftui
                
                switch viewModel.timeStates {
                case .active:
                    Button(action: {
                        viewModel.timeStates = .paused
                    }, label: {
                        buttonStyleConfig.pausebutton()
                    })
                case .paused:
                    Button(action: {
                        viewModel.timeStates = .resumed
                    }, label: {
                        buttonStyleConfig.pausebutton()
                    })
                case .resumed:
                    Button(action: {
                        viewModel.timeStates = .paused
                    }, label: {
                        buttonStyleConfig.pausebutton()
                    })
                case .cancelled:
                    Button(action: {
                        viewModel.timeStates = .active
   
                    }, label: {
                        buttonStyleConfig.startbutton()
                    })
                case .record:
                    Button(action: {
                        viewModel.timeStates = .record
                    }, label: {
                        buttonStyleConfig.recordbutton()
                    })
                case .stoprecording:
                    Button(action: {
                        viewModel.timeStates = .stoprecording
                    }, label: {
                        buttonStyleConfig.stopRecording()
                    })
                }
            }
            .padding()
        }
    }
}

extension JikanView {
    // MARK: delaytextFieldView
    var delaytextFieldView: some View {
   
        let colors: [String] = ["lightYellow","lightGreen","lightBlue","lightPurple","lightRed","lightOrange"]
        
        return VStack(alignment: .leading) {
                subheadlineText(withPlaceholder: "Select Project Delay")
                    .padding(.horizontal, 30)
            
            
            HStack(spacing: 15) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(Color(color))
                        .frame(width: 25, height: 25)
                        .background {
                            if coreDataVM.categoryColor == color {
                                Circle()
                                    .strokeBorder(Color.blue)
                                    .padding(-5)
                                    .fontWeight(.bold)
                            }
                        }
                        .contentShape(Circle())
                        .onTapGesture {
                            coreDataVM.categoryColor = color
                        }
                    // add onTapgesture to interact with color
                    
                }
            }
            .padding(.horizontal, 40)
            .padding(.leading, 4)
            .padding(.vertical, 4)
                
                HStack(spacing: 5) {
                    GradientIconButton(icon: "exclamationmark.triangle.fill")
                        .padding(.horizontal, 5)
                    
                    Picker("Select Delay", selection: $actualDelay) {
                        ForEach(delayEnum.allCases, id: \.self) { delays in
                            Text(delays.rawValue)
                        }
                        .foregroundColor(Color.white)
                    }
                    .pickerStyle(.menu)
                    .font(.headline)
                }
                .padding(.horizontal, 30)
                .padding(.bottom)
                
                HStack(spacing: 5) {
                    TextEditor(text: $delayEncountered)
                        .modifier(TextFieldClearButton(nextText: $delayEncountered))
                        .modifier(ChangeSmallerFrameSize())
                }
                .font(.headline)
            }
           
        
            .frame(width: 370, height: 240)
                .background(backgroundGradientlight)
            .cornerRadius(20)
        
            .shadow(color: .secondary, radius: 4)
            .padding(.horizontal, 12)
            .offset(y: -30)
        }
    
    
}

struct JikanView_Preview: PreviewProvider {
    static var previews: some View {
        JikanView().environmentObject(CoreDataViewModel())
    }
}
