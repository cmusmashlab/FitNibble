import SwiftUI
import UserNotifications

struct HomePageView: View {
    
    @ObservedObject var notificationManager: NotificationManager
    @ObservedObject var bleController: BLEController
    @StateObject var activityManager = ActivityManager()
    @State var presented: Bool = false
    @State var list = [BLEController.Device]()
    
    
    @State var personalID = UserDefaults.standard.string(forKey: "personalID") ?? ""
    
    
    // MARK: View Presentation Properties
    @State private var isCreatePresented = false
    @State private var isConfirmationPresented = false
    @State private var isSetupPresented = false
    
    @State var surveyReminderSet = UserDefaults.standard.bool(forKey: "id.surveyReminderSet")
    
    @State var isConnected: Bool = false
    @State private var isPairingOpen = UserDefaults.standard.bool(forKey: "IS-PAIRING-OPEN")
    
    @State var isEating = false
    
    @Environment(\.openURL) var openURL
    
    private static var notificationDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    private func timeDisplayText(from notification: UNNotificationRequest) -> String {
        guard let nextTriggerDate = (notification.trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate() else { return "" }
        return Self.notificationDateFormatter.string(from: nextTriggerDate)
    }
    
    var body: some View {
        List {
            Section(header: ScanningHeaderView(isConnected: $isConnected, isPairingOpen: $isPairingOpen, bleController: bleController)) {
                Toggle("Pair Device", isOn: $isPairingOpen)
                if isPairingOpen {
                    if !isConnected {
                        ForEach(list, id: \.id) { device in
                            Button(action: {
                                bleController.connect(device.peripheral)
                            }, label: {
                                BLECardView(deviceName: device.peripheral.name ?? "Unknown", rssi: String(device.rssi), bleController: bleController, isConnected: $isConnected)
                            })
                        }
                    } else {
                        Button(action: {}, label: {
                            BLECardView(deviceName: bleController.current?.name ?? "Unknown", rssi: "", bleController: bleController, isConnected: $isConnected)
                        })
                    }
                } else {
                    EmptyView()
                }
            }
            
            Section(header: Text("Journaling")) {
                Button(action: {
                    openURL(URL(string: ExternalURLs.foodility.rawValue)!)
                    activityManager.addActivity(eventType: "Clicked", description: "Foodility")
                    activityManager.sendAllActivities()
                }, label: {
                    Text("Launch Foodility")
                })
            }
            
            Section(header: Text("Daily Surveys")) {
                Button(action: {
                    openURL(URL(string: ExternalURLs.surveyPhase2.rawValue)!)
                    activityManager.addActivity(eventType: "Clicked", description: "Survey")
                    activityManager.sendAllActivities()
                }, label: {
                    Text("Survey")
                })
            }
            
            Section(header: HStack {
                Text("Reminders")
                Spacer()
                Button(action: {
                    switch notificationManager.authorizationStatus {
                    case .authorized:
                        isCreatePresented = true
                    default:
                        notificationManager.requestAuthorization()
                    }
                }, label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                })
            }) {
                ForEach(notificationManager.notifications, id: \.identifier) { notification in
                    if notification.content.categoryIdentifier == "REMINDERS" {
                        ReminderCardView(title: notification.content.title, time: timeDisplayText(from: notification))
                    }
                }
                .onDelete(perform: delete)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("FitNibble"))
        .navigationBarItems(trailing: Button(action: {
            isSetupPresented = true
        }, label: {
            Image(systemName: "ellipsis.circle")
                .imageScale(.large)
        }))
        .popover(isPresented: $notificationManager.opened) {
            NavigationView {
                JournalConfirmationView(notificationManager: notificationManager, activityManager: activityManager, bleController: bleController, isPresented: $notificationManager.opened, isConnected: $isConnected)
            }
        }
        .background(
            HStack {
                EmptyView()
            }
            .popover(isPresented: $isSetupPresented, content: {
                NavigationView {
                    SetupView(notificationManager: notificationManager, personalID: $personalID, isSetupOpen: $isSetupPresented, surveyReminderSet: $surveyReminderSet)
                }
            })
            .hidden()
        )
        .sheet(isPresented: $isCreatePresented) {
            NavigationView {
                CreateNewReminderView(
                    notificationManager: notificationManager,
                    isPresented: $isCreatePresented
                )
            }
            .accentColor(.primary)
        }
        .onAppear {
            bleController.delegate = self
            activityManager.personalID = personalID
            notificationManager.reloadAuthorizationStatus()
            UNUserNotificationCenter.current().delegate = notificationManager
            notificationManager.setNotificationCategories()
            
            if isPairingOpen && !isConnected {
                bleController.startScanning()
            }
        }
        .onChange(of: isConnected, perform: { connected in
            if isPairingOpen && !connected {
                bleController.startScanning()
            }
            if connected {
                activityManager.addActivity(eventType: "BLE", description: "Connected")
                activityManager.sendAllActivities()
            } else {
                activityManager.addActivity(eventType: "BLE", description: "Disconnected")
                activityManager.sendAllActivities()
            }
            
        })
        .onChange(of: isPairingOpen, perform: { open in
            UserDefaults.standard.set(open, forKey: "IS-PAIRING-OPEN")
            if open {
                bleController.startScanning()
            } else {
                bleController.disconnect(shouldReconnect: false)
            }
        })
        .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                notificationManager.requestAuthorization()
            case .denied:
                notificationManager.requestAuthorization()
            case .authorized:
                notificationManager.reloadLocalNotifications()
            default:
                break
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            notificationManager.reloadAuthorizationStatus()
        }
        .onChange(of: surveyReminderSet, perform: { set in
            if set {
                activityManager.addActivity(eventType: "Survey-Reminder", description: "Create")
                activityManager.sendAllActivities()
            }
        })
        .onChange(of: notificationManager.logRequired, perform: { required in
            if required {
                activityManager.addActivity(eventType: "Reminder", description: "Create")
                activityManager.sendAllActivities()
                notificationManager.logRequired = false
            }
        })
        .onChange(of: personalID, perform: { id in
            activityManager.personalID = id
        })
    }
}

extension HomePageView: BLEProtocol {
    
    func state(state: BLEController.State) {
        switch state {
        case .unknown: print("◦ .unknown")
        case .resetting: print("◦ .resetting")
        case .unsupported: print("◦ .unsupported")
        case .unauthorized:
            print("◦ bluetooth disabled, enable it in settings")
        case .poweredOff:
            print("◦ turn on bluetooth")
        case .poweredOn: print("◦ everything is ok")
        case .error: print("• error")
        case .connected:
            print("◦ connected to \(bleController.current?.name ?? "")")
            isConnected = true
            notificationManager.createConnectionNotification { error in
                print("> Connection notification fired")
            }
        case .disconnected:
            print("◦ disconnected")
            isConnected = false
            notificationManager.createDisconnectionNotification { error in
                print("> Disconnection notification fired")
            }
        }
    }
    func list(list: [BLEController.Device]) { self.list = list }
    
    func eating(isEating: Bool) {
        self.isEating = isEating
        if isEating {
            notificationManager.createDetectionNotification() { error in
                if error == nil {
                    DispatchQueue.main.async {
                        bleController.isDetecting = false
                        print(">>>")
                    }
                }
            }
            activityManager.addActivity(eventType: "Detection", description: "Eating")
            DispatchQueue.main.asyncAfter(deadline: .now() + 5 * 60) { //MARK: 10 min
                if !bleController.interacted {
                    activityManager.addActivity(eventType: "Confirmation", description: "No-Immediate-Response")
                    activityManager.sendAllActivities()
                    bleController.interacted = true
                    bleController.isDetecting = true
                }
            }
        }
    }
}

// MARK: Other functions
extension HomePageView {
    func delete(_ indexSet: IndexSet) {
        DispatchQueue.main.async {
            notificationManager.deleteLocalNotifications(
                identifiers: indexSet.map {
                    notificationManager.notifications[$0].identifier
                })
            activityManager.addActivity(eventType: "Reminder", description: "Delete")
            activityManager.sendAllActivities()
            notificationManager.reloadLocalNotifications()
        }
    }
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomePageView(notificationManager: NotificationManager.shared, bleController: BLEController.shared)
        }
    }
}
