import SwiftUI

struct ConnDetailView: View {
    @ObservedObject var bleController: BLEController
    let deviceName: String
    @Binding var isConnected: Bool
    var body: some View {
        List {
            HStack {
                Text("Device Name")
                    .foregroundColor(Color(.systemGray))
                Spacer()
                Text(deviceName)
            }
            if isConnected {
                HStack {
                    Text("Eating Status")
                        .foregroundColor(Color(.systemGray))
                    Spacer()
                    if bleController.eatingStatus {
                        Text("Eating")
                    } else {
                            Text("Not Eating")
                    }
                }
                
                Button(action: {
                    bleController.disconnect(shouldReconnect: false)
                }, label: {
                    Text("Disconnect")
                })
            } else {
                EmptyView()
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct ConnDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConnDetailView(bleController: BLEController.shared, deviceName: "Arduino", isConnected: .constant(true))
    }
}
