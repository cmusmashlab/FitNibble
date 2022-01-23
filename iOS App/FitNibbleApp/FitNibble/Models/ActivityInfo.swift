//
//  ActivityInfo.swift
//  FitByteTrial
//
//  Created by Yuchen Liang on 6/3/21.
//

import Foundation

struct ActivityInfo: Encodable {
    let id: UUID
    let timeStamp: String
    let personalID: String
    let deviceID: String
    let eventType: String
    let description: String
    
    init(id: UUID = UUID(), timeStamp: String, personalID: String, deviceID: String, eventType: String, description: String) {
        self.id = id
        self.timeStamp = timeStamp
        self.deviceID = deviceID
        self.personalID = personalID
        self.eventType = eventType
        self.description = description
    }
}
