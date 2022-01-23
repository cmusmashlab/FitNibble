import SwiftUI
import UIKit

@main
struct FitNibbleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var notificationManager = NotificationManager.shared
    @StateObject var bleController = BLEController.shared
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomePageView(notificationManager: notificationManager, bleController: bleController)
            }
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            print("Hello")
            return true
        }
        func applicationWillTerminate(_ application: UIApplication) {
            print("Bye")
        }
    }
}

struct appButton: ButtonStyle {
    let color: Color
    
    public init(color: Color = .accentColor) {
        self.color = color
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .foregroundColor(.accentColor)
            .background(Color.accentColor.opacity(0.2))
            .cornerRadius(8)
    }
}

struct appTextField: TextFieldStyle {
    @Binding var focused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(focused ? Color.accentColor : Color.accentColor.opacity(0.2), lineWidth: 2)
            ).padding()
    }
}

enum ExternalURLs: String {
    case surveyPhase1 = "SURVEY_LINK_1" // anonymized
    case surveyPhase2 = "SURVEY_LINK_2" // anonymized
    case foodility = "com.googleusercontent.apps.421909440014-9ud0fdmutrra3925ui87qi2cbejiij0d://"
}
