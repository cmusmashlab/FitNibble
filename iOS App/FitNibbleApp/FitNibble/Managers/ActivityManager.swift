import SwiftUI

final class ActivityManager: ObservableObject {
    @Published private(set) var activities: [ActivityInfo]
    @Published var personalID: String = ""
    let deviceID: String
    
    init() {
        self.activities = []
        self.deviceID = UIDevice.current.identifierForVendor!.uuidString
    }
    
    private var eventDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        return formatter
    }()
    
    func addActivity(eventType: String, description: String) {
        let today = Date()
        let currentActivity = ActivityInfo(
            timeStamp: eventDateFormatter.string(from: today),
            personalID: personalID, deviceID: deviceID,
            eventType: eventType, description: description)
        activities.append(currentActivity)
        print("> Activity appended")
        print(currentActivity)
    }
    
    func sendActivity(activity: ActivityInfo) {
        guard let encoded = try? JSONEncoder().encode(activity) else {
            print("Failed to encode info")
            return
        }
        let IP_ADDRESS = "IP_ADDRESS" // anonymized
        let url = URL(string: "http://\(IP_ADDRESS)/api/get_info")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { data, response, error  in
            // handle the result
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error").")
                return
            }
            print(data)
            if let decodedInfo = try? JSONDecoder().decode(ResponseInfo.self, from: data) {
                print(decodedInfo)
            } else {
                print("Invalid Response")
            }
        }.resume()
    }
    
    func sendAllActivities() {
        self.activities.forEach { activity in
            sendActivity(activity: activity)
        }
        self.emptyActivities()
    }
    
    func emptyActivities() {
        self.activities.removeAll()
    }
    
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
    
    struct ResponseInfo: Decodable {
        let status: String
        let message: String
    }
    
}
