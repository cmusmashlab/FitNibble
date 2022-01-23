//
//  Reminder.swift
//  FitByteTrial
//
//  Created by Yuchen Liang on 6/1/21.
//

import SwiftUI

struct Reminder: Identifiable {
    let id: UUID
    var title: String
    var time: DateComponents
    
    init(id: UUID = UUID(), title: String, time: DateComponents) {
        self.id = id
        self.title = title
        self.time = time
    }
}
