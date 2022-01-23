//
//  Notification.swift
//  FitByteTrial
//
//  Created by Yuchen Liang on 6/10/21.
//

import Foundation
import UserNotifications

struct Notification: Identifiable {
    let id: String
    var notification: UNNotificationRequest
    var timer: Timer
    
    init(notification: UNNotificationRequest, timer: Timer) {
        self.id = notification.identifier
        self.notification = notification
        self.timer = timer
    }
}
