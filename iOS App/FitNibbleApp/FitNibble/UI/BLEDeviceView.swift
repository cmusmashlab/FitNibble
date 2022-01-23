//
//  PullToRefreshView.swift
//  FitByteTrial
//
//  Created by Yuchen Liang on 6/6/21.
//

import SwiftUI

struct BLEDeviceView: View {
    @ObservedObject var bleManager: BLEManager
    var body: some View {
        if !bleManager.isConnected {
            ForEach(bleManager.peripherals, id: \.id) { wrapper in
                Button(action: {
                    bleManager.connectToDevice(wrapper: wrapper)
                }, label: {
                    BLECardView(deviceName: wrapper.name, rssi: String(wrapper.rssi), bleManager: bleManager)
                })
            }
        } else {
            Button(action: {
                print("Status: \(String(describing: bleManager.selectedDevice))")
                bleManager.checkStatus()
            }, label: {
                BLECardView(deviceName: bleManager.selectedDevice.name, rssi: String(bleManager.selectedDevice.rssi), bleManager: bleManager)
            })
        }
    }
}

struct PullToRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        BLEDeviceView(bleManager: BLEManager())
    }
}
