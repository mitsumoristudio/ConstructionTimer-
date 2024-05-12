//
//  NotificationCenter.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
// Copyright 2024 Satoshi Mitsumori. All rights reserved.

import Foundation
import UserNotifications

class NotificationCenter {
    func askUserPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (result, error) in
            if result {
                print("Access Provided")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func sendNotification(date: Date, type: String, timeInterval: Double = 10, title: String, body: String) {
        var notificationtrigger:  UNNotificationTrigger?
        
        if type == "date" {
            let dateCompenents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            notificationtrigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)
        } else if type == "time" {
            notificationtrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: notificationtrigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}



