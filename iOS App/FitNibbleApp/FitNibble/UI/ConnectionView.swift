////
////  ConnectionView.swift
////  FitByteTrial
////
////  Created by Yuchen Liang on 6/4/21.
////
//
//import SwiftUI
//
//struct ConnectionView: View {
//    @ObservedObject var bleManager: BLEManager
//    @State var isConnectionDetailPresented = false
//
//    var body: some View {
//            VStack (spacing: 10) {
//
//                Text("Bluetooth Devices")
//                    .font(.largeTitle)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                
//                List(bleManager.peripherals) { wrapper in
//                    Button(action: {
//                        bleManager.connectToDevice(wrapper: wrapper)
//                    }, label: {
//                        let connected = wrapper.peripheral.state == .connected
//                        BLECardView(deviceName: wrapper.name, isConnected: .constant(true), rssi: String(wrapper.rssi), bleManager: bleManager)
//                    })
//                }
//                .frame(height: 300)
//                
//
//                Spacer()
//
//                Text("STATUS")
//                    .font(.headline)
//
//                // Status goes here
//                if bleManager.isSwitchOn {
//                    Text("Bluetooth is switched on")
//                        .foregroundColor(.green)
//                }
//                else {
//                    Text("Bluetooth is NOT switched on")
//                        .foregroundColor(.red)
//                }
//
//                Spacer()
//
//                HStack {
//                    VStack (spacing: 10) {
//                        Button(action: {
//                            bleManager.startScanning()
//                        }) {
//                            Text("Start Scanning")
//                        }
//                        Button(action: {
//                            bleManager.stopScanning()
//                        }) {
//                            Text("Stop Scanning")
//                        }
//                    }.padding()
//
//                    Spacer()
//
//                    VStack (spacing: 10) {
//                        Button(action: {
//                            print("Disconnect")
//                            bleManager.disconnectFromDevice(wrapper: bleManager.connectedDevice)
//                        }) {
//                            Text("Disconnect")
//                        }
//                        Button(action: {
//                            print("Stop Advertising")
//                        }) {
//                            Text("Stop Advertising")
//                        }
//                    }.padding()
//                }
//                Spacer()
//            }
//        }
//}
//
//struct ConnectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnectionView(bleManager: BLEManager())
//    }
//}

