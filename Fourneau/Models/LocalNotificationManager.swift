//
//  LocalNotificationManager.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/12/22.
//

import Foundation
import SwiftUI

class LocalNotificationManager: ObservableObject {
    var notifications = [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
    }
    
    func sendNotification(title: String, body: String, launchIn: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: launchIn, repeats: false)
        let request = UNNotificationRequest(identifier: "bakeNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
