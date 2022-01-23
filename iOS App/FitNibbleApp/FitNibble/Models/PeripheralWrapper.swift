//
//  PeripheralWrapper.swift
//  FitByteTrial
//
//  Created by Yuchen Liang on 6/6/21.
//

import Foundation
import CoreBluetooth

struct PeripheralWrapper: Identifiable, Equatable {
    let id: Int
    let name: String
    let rssi: Int
    let peripheral: CBPeripheral
}
