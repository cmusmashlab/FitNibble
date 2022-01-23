import SwiftUI

struct JournalConfirmationView: View {
    @Environment(\.openURL) var openURL
    @ObservedObject var notificationManager: NotificationManager
    @ObservedObject var activityManager: ActivityManager
    @ObservedObject var bleController: BLEController
    @Binding var isPresented: Bool
    @Binding var isConnected: Bool
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    
                    
                    Button {
                        bleController.interacted = true
                        if notificationManager.latestIsDetection {
                            bleController.pauseDetection(minute: 30, second: 0)
                        }
                        isPresented = false
                        openURL(URL(string: ExternalURLs.foodility.rawValue)!)
                        activityManager.addActivity(eventType: "Reminder", description: "Foodility")
                        activityManager.sendAllActivities()
                    } label: {
                        Text("Yes, start journaling with Foodility!")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(5)
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    Button {
                        bleController.interacted = true
                        isPresented = false
                        if notificationManager.latestIsDetection {
                            bleController.pauseDetection(minute: 30, second: 0)
                        }
                        activityManager.addActivity(eventType: "Confirmation", description: "No")
                        activityManager.sendAllActivities()
                    } label: {
                        Text("No, I'm not eating.")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(5)
                    .buttonStyle(PlainButtonStyle())
                    
                    if isConnected {
                        Button {
                            bleController.interacted = true
                            isPresented = false
                            bleController.isDetecting = true
                        } label: {
                            Text("Just a Test")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .contentShape(Rectangle())
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(5)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .listRowBackground(Color(.systemGroupedBackground))
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text("Are you Eating?"), displayMode: .automatic)
    }
}

struct JournalConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JournalConfirmationView(notificationManager: NotificationManager.shared, activityManager: ActivityManager(), bleController: BLEController.shared, isPresented: .constant(true), isConnected: .constant(true))
        }
    }
}
