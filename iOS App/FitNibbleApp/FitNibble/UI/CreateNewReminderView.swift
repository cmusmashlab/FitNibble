import SwiftUI

struct CreateNewReminderView: View {
    @ObservedObject var notificationManager: NotificationManager
    @State private var title = ""
    @State private var date = Date()
    @Binding var isPresented: Bool
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    HStack {
                        TextField("Title", text: $title)
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: [.hourAndMinute])
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .cornerRadius(5)
                    
                    Button {
                        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
                        guard let hour = dateComponents.hour, let minute = dateComponents.minute, !title.isEmpty else { return }
                        notificationManager.createLocalNotification(title: title, body: "Keep track of your diet!", hour: hour, minute: minute) { error in
                            if error == nil {
                                DispatchQueue.main.async {
                                    self.isPresented = false
                                    notificationManager.logRequired = true
                                }
                            }
                        }
                    } label: {
                        Text("New Notification")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(5)
                    .buttonStyle(PlainButtonStyle())
                }
                .listRowBackground(Color(.systemGroupedBackground))
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onDisappear {
            notificationManager.reloadLocalNotifications()
        }
        .navigationTitle("Create")
        .navigationBarItems(trailing: Button {
            isPresented = false
        } label: {
            Image(systemName: "xmark.circle")
                .imageScale(.large)
        })
    }
}

struct CreateNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateNewReminderView(
                notificationManager: NotificationManager.shared,
                isPresented: .constant(false)
            )
        }
    }
}
