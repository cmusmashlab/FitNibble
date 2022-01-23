import SwiftUI

struct SetupView: View {
    @ObservedObject var notificationManager: NotificationManager
    @State var date = UserDefaults.standard.object(forKey: "surveyTime") as? Date ?? {
        var components = DateComponents()
        components.hour = 21
        components.minute = 30
        return Calendar.current.date(from: components)!
    }()
    @Binding var personalID: String
    @Binding var isSetupOpen: Bool
    @Binding var surveyReminderSet: Bool
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Identifier")
                        .foregroundColor(Color(.systemGray))
                    Spacer()
                    TextField("Enter Your Customized ID", text: $personalID)
                        .multilineTextAlignment(.trailing)
                }
                .background(Color.white)
                .cornerRadius(5)
            }
            Section {
                HStack {
                    Text("Survey Reminder")
                        .foregroundColor(Color(.systemGray))
                    Spacer()
                    DatePicker("", selection: $date, displayedComponents: [.hourAndMinute])
                }
                .background(Color.white)
                .cornerRadius(5)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("Configuration"))
        .navigationBarItems(trailing: Button(action: {
            notificationManager.deleteSurvey()
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
            guard let hour = dateComponents.hour, let minute = dateComponents.minute else { return }
            notificationManager.createSurveyNotification(hour: hour, minute: minute) { error in
                if error == nil {
                    DispatchQueue.main.async {
                        self.isSetupOpen = false
                        self.surveyReminderSet = true
                        UserDefaults.standard.set(surveyReminderSet, forKey: "id.surveyReminderSet")
                        notificationManager.logRequired = true
                    }
                }
            }
        }, label: {
            Image(systemName: "checkmark.circle")
                .imageScale(.large)
        }))
        .onChange(of: isSetupOpen, perform: { open in
            if !open {
                UserDefaults.standard.set(personalID, forKey: "personalID")
                UserDefaults.standard.set(date, forKey: "surveyTime")
            }
        })
        .onDisappear(perform: {
            notificationManager.reloadLocalNotifications()
        })
    }
}

extension SetupView {
    func makeDefaultDate(hour: Int, minute: Int) -> Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components)!
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SetupView(notificationManager: NotificationManager.shared, personalID: .constant("FitNibble01"), isSetupOpen: .constant(true), surveyReminderSet: .constant(true))
        }
    }
}
