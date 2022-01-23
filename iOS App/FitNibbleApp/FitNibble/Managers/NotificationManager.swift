import Foundation
import UIKit
import UserNotifications
import AudioToolbox

class NotificationManager: NSObject, ObservableObject {
    static let shared = NotificationManager()
    @Published private(set) var notifications = UserDefaults.standard.array(forKey: "NotificationRequests") as? [UNNotificationRequest] ?? []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    @Published var logRequired: Bool = false
    @Published var opened = false
    
    private var center: UNUserNotificationCenter
    
    @Published private(set) var dummy: Notification!
    
    let surveyID = "id.surveys"
    @Published var latestIsDetection = false
    
    private override init() {
        center = UNUserNotificationCenter.current()
    }
    
    func reloadAuthorizationStatus() {
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, error in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
            
        }
    }
    
    func reloadLocalNotifications() {
        print("reloadLocalNotifications")
        center.getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
                print("# Notifications amount: \(notifications.count)")
            }
        }
    }
    
    func createLocalNotification(title: String, body: String, hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.sound = .default
        notificationContent.categoryIdentifier = "REMINDERS"
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        center.add(request, withCompletionHandler: completion)
    }
    
    func createSurveyNotification(hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        center.removePendingNotificationRequests(withIdentifiers: ["SURVEY-ID"])
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Fill out your Daily Survey!"
        notificationContent.body = "Write your reflection on today's journaling"
        notificationContent.sound = .default
        notificationContent.categoryIdentifier = "SURVEYS"
        
        let request = UNNotificationRequest(identifier: surveyID, content: notificationContent, trigger: trigger)
        
        center.add(request, withCompletionHandler: completion)
    }
    
    func createDetectionNotification(completion: @escaping (Error?) -> Void) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Are you eating right now?"
        notificationContent.body = "Keep track of your diet!"
        notificationContent.sound = .default
        notificationContent.categoryIdentifier = "DETECTION"
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: nil) // deliever right away
        
        center.add(request, withCompletionHandler: completion)
    }
    
    func createDisconnectionNotification(completion: @escaping (Error?) -> Void) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "FitNibble Disconnected"
        notificationContent.body = "Please reconnect your device!"
        notificationContent.sound = .default
        notificationContent.categoryIdentifier = "CONNECTION"
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: nil) // deliever right away
        
        center.add(request, withCompletionHandler: completion)
    }
    
    func createConnectionNotification(completion: @escaping (Error?) -> Void) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "FitNibble Connected"
        notificationContent.body = "Please make sure you wear your glasses properly"
        notificationContent.sound = .default
        notificationContent.categoryIdentifier = "CONNECTION"
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: nil) // deliever right away
        
        center.add(request, withCompletionHandler: completion)
    }
    
    
    func deleteLocalNotifications(identifiers: [String]) {
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    func deleteSurvey() {
        self.deleteLocalNotifications(identifiers: ["id.surveys"])
    }
    
    func setNotificationCategories() {
        let category_survey = UNNotificationCategory(identifier: "SURVEYS", actions: [], intentIdentifiers: [], options: [])
        let category_reminder = UNNotificationCategory(identifier: "REMINDERS", actions: [], intentIdentifiers: [], options: [])
        let category_detection = UNNotificationCategory(identifier: "DETECTION", actions: [], intentIdentifiers: [], options: [])
        let category_dummy = UNNotificationCategory(identifier: "DUUMMY", actions: [], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category_survey, category_reminder, category_detection, category_dummy])
    }
    
}

/// handling in-app notifications
extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
        if notification.request.content.categoryIdentifier == "SURVEYS" {
            self.latestIsDetection = false
            if let link = URL(string: ExternalURLs.surveyPhase2.rawValue), UIApplication.shared.canOpenURL(link) {
                UIApplication.shared.open(link) { result in
                    print("> open url result: \(result)")
                }
            }
        } else if notification.request.content.categoryIdentifier == "CONNECTION" {
            print("-*-")
            self.latestIsDetection = false
        } else {
            self.latestIsDetection = notification.request.content.categoryIdentifier == "DETECTION"
            self.opened = true
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        if response.notification.request.content.categoryIdentifier == "SURVEYS" {
            self.latestIsDetection = false
            if let link = URL(string: ExternalURLs.surveyPhase2.rawValue), UIApplication.shared.canOpenURL(link) {
                UIApplication.shared.open(link) { result in
                    print("> open url result: \(result)")
                }
            }
        } else if response.notification.request.content.categoryIdentifier == "CONNECTION" {
            print("-*-")
            self.latestIsDetection = false
        } else {
            self.latestIsDetection = response.notification.request.content.categoryIdentifier == "DETECTION"
            self.opened = true
        }
    }
}
