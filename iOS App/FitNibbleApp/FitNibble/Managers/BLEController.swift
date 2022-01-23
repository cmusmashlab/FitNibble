import Foundation
import CoreBluetooth
import SwiftUI

protocol BLEProtocol {
    func state(state: BLEController.State)
    func list(list: [BLEController.Device])
    func eating(isEating: Bool)
}

final class BLEController: NSObject, ObservableObject {
    static let shared = BLEController()
    var delegate: BLEProtocol?
    var peripherals = [Device]()
    var current: CBPeripheral?
    var state: State = .unknown { didSet { delegate?.state(state: state) } }
    var shouldReconnect = true
    
    private var manager: CBCentralManager?
    private var rxCharacteristic: CBCharacteristic?
    private var txCharacteristic: CBCharacteristic?
    private var notifyCharacteristic: CBCharacteristic?
    
    // MARK: Data Processing Attributes
    private var rxLine = ""
    private var eatingCounter: Int = 0
    @Published var eatingStatus: Bool = false
    var interacted: Bool = false
    var isDetecting: Bool = true
    let pred_fields: [Prediction] = [.drinking, .eating, .silent, .talking, .walking]
    

    private override init() {
            super.init()
        let options = [CBCentralManagerOptionRestoreIdentifierKey: "id.ble-central"]

        manager = CBCentralManager(delegate: self, queue: .none, options: options)
            manager?.delegate = self
    }
    
    func connect(_ peripheral: CBPeripheral) {
        if current != nil {
            guard let current = current else { return }
            manager?.cancelPeripheralConnection(current)
            manager?.connect(peripheral, options: [CBCentralManagerRestoredStatePeripheralsKey: "id.peripheral"])
        } else { manager?.connect(peripheral, options: nil) }
    }
    
    func disconnect(shouldReconnect: Bool) {
        guard let current = current else { return }
        self.shouldReconnect = shouldReconnect
        manager?.cancelPeripheralConnection(current)
    }
    
    func startScanning() {
        peripherals.removeAll()
        manager?.scanForPeripherals(withServices: [CBUUIDs.BLEService_UUID], options: nil)
    }
    func stopScanning() {
        peripherals.removeAll()
        manager?.stopScan()
    }
    
    func sendToWearable(data: String) {
        guard let characteristic = txCharacteristic else { return }
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        current?.writeValue(valueString!, for: characteristic, type: .withoutResponse)
    }
    
    
    
    enum State { case unknown, resetting, unsupported, unauthorized, poweredOff, poweredOn, error, connected, disconnected }
    
    enum Prediction: String {
        case silent = "silent"
        case walking = "walking"
        case drinking = "drinking"
        case talking = "talking"
        case eating = "eating"
    }
    
    struct Device: Identifiable {
            let id: Int
            let rssi: Int
            let uuid: String
            let peripheral: CBPeripheral
    }
    
    struct RequestInfo: Encodable {
        let deviceID: String
        let data: [[Float32]]
    }
    
    struct PredictionInfo: Decodable {
        let success: Bool
        let prediction: [[Float32]]
    }
}

extension BLEController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch manager?.state {
        case .unknown: state = .unknown
        case .resetting: state = .resetting
        case .unsupported: state = .unsupported
        case .unauthorized: state = .unauthorized
        case .poweredOff:
            state = .poweredOff
        case .poweredOn: state = .poweredOn
        default: state = .error
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let uuid = String(describing: peripheral.identifier)
        let filtered = peripherals.filter{$0.uuid == uuid}
        if filtered.count == 0 {
            guard let _ = peripheral.name else { return }
            let new = Device(id: peripherals.count, rssi: RSSI.intValue, uuid: uuid, peripheral: peripheral)
            peripherals.append(new)
            delegate?.list(list: peripherals)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) { print(error!) }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        current = nil
        state = .disconnected
        if shouldReconnect {
            self.connect(peripheral)
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        current = peripheral
        state = .connected
        shouldReconnect = true
        peripheral.delegate = self
        peripheral.discoverServices([CBUUIDs.BLEService_UUID])
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        let restoredPeripherals = dict[CBCentralManagerRestoredStatePeripheralsKey] as? [CBPeripheral] ?? []
        if let peripheral = restoredPeripherals.first {
            peripheral.delegate = self
        }
    }
}

extension BLEController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        print("Found \(characteristics.count) characteristics.")
        
        for characteristic in characteristics {
            if characteristic.uuid.isEqual(CBUUIDs.BLE_Characteristic_uuid_Rx) {
                rxCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: self.rxCharacteristic!)
                peripheral.readValue(for: characteristic)
            }
            if characteristic.uuid.isEqual(CBUUIDs.BLE_Characteristic_uuid_Tx){
                txCharacteristic = characteristic
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) { }
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) { }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        var characteristicASCIIValue = NSString()
        
        guard characteristic == rxCharacteristic,
              let characteristicValue = characteristic.value,
              let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }
        
        characteristicASCIIValue = ASCIIstring
        rxLine += String(characteristicASCIIValue)
        if rxLine.contains("\r\n") {
            if isDetecting {
                processRxLine()
            } else {
                print("IDLE - Not Detecting")
            }
        }
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "Notify"), object: "\((characteristicASCIIValue as String))")
    }
}

// MARK: Data Processing
extension BLEController {
    
    func pauseDetection(minute: Double, second: Double) {
        isDetecting = false
        DispatchQueue.main.asyncAfter(deadline: .now() + (60 * minute) + second) {
            self.isDetecting = true
        }
    }
    
    func processRxLine() {
        let lines = self.rxLine.components(separatedBy: " \r\n")
        
        var features = [Float]()
        var count = 0
        for item in lines[0].components(separatedBy: " ") {
            features.append((item as NSString).floatValue)
            count = count+1
        }
        print(count)
        sendRequest(data: [features])
        print("[new Line]")
        self.rxLine=lines[1]
    }
    
    func sendRequest(data: [[Float32]]) {
        if data[0].count != 42 {
            print("> Wrong size")
            return
        }
        let requestInfo = RequestInfo(deviceID: UIDevice.current.identifierForVendor!.uuidString, data: data)
        guard let encoded = try? JSONEncoder().encode(requestInfo) else {
            print("> Fail to encode request info")
            return
        }
        let url = URL(string: "http://128.237.79.51:8004/api/predict")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error").")
                return
            }
            print(data)
            if let decodedInfo = try? JSONDecoder().decode(PredictionInfo.self, from: data) {
                if decodedInfo.success {
                    var predictionDict: [Prediction: Float32] = [:]
                    
                    for (idx, key) in self.pred_fields.enumerated() {
                        predictionDict[key] = decodedInfo.prediction[0][idx]
                    }
                    
                    let greatest = predictionDict.max { (a, b) -> Bool in
                        return a.value < b.value
                    }
                    print("\n>>> Prediction - \(String(describing: greatest!.key)): \(String(describing: greatest!.value))")
                    print("[", terminator: "")
                    
                    for (key, value) in predictionDict.sorted(by: { $0.0.rawValue < $1.0.rawValue }) {
                        print("\(key.rawValue): \(value)", terminator: ", ")
                    }
                    print("]")
                    if (greatest!.key == .eating || greatest!.key == .drinking) {
                        DispatchQueue.main.async {
                            self.eatingCounter += 1
                        }
                        if self.eatingCounter == 5 {
                            print("Eating!!!!!!")
                            DispatchQueue.main.async {
                                self.eatingStatus = true
                                self.interacted = false
                                self.eatingCounter = 0
                                self.delegate?.eating(isEating: self.eatingStatus)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.eatingCounter = 0
                            self.eatingStatus = false
                            self.delegate?.eating(isEating: self.eatingStatus)
                        }
                    }
                }
            } else {
                print("Invalid Response")
            }
        }.resume()
    }
}


struct CBUUIDs{

    static let kBLEService_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
    static let kBLE_Characteristic_uuid_Tx = "6e400002-b5a3-f393-e0a9-e50e24dcca9e"
    static let kBLE_Characteristic_uuid_Rx = "6e400003-b5a3-f393-e0a9-e50e24dcca9e"
    static let MaxCharacters = 20

    static let BLEService_UUID = CBUUID(string: kBLEService_UUID)
    static let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_Characteristic_uuid_Tx)//(Property = Write without response)
    static let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_Characteristic_uuid_Rx)// (Property = Read/Notify)
}
