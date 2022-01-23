import SwiftUI
import CoreBluetooth

struct BLECardView: View {
    let deviceName: String
    let rssi: String
    @State var isConnDetailPresented = false
    @ObservedObject var bleController: BLEController
    @Binding var isConnected: Bool
    
    
    var body: some View {
        HStack {
            Text(deviceName)
                .foregroundColor(.black)
            Spacer()
            if isConnected {
                Text("Connected")
                    .foregroundColor(Color(.systemGray))
            } else {
                Text("Not Connected")
                    .foregroundColor(Color(.systemGray))
                Text(rssi)
                    .foregroundColor(.blue)
                    .font(.callout)
            }
            
            Button(action: {
                isConnDetailPresented = true
            }, label: {
                Image(systemName: "info.circle")
                .imageScale(.large)
            })
        }
        .background(
            NavigationLink(
                destination: ConnDetailView(bleController: bleController, deviceName: deviceName, isConnected: $isConnected),
                isActive: $isConnDetailPresented,
                label: {
                    EmptyView()
                })
                .hidden()
        )
    }
}

struct BLECardView_Previews: PreviewProvider {
    static var previews: some View {
        BLECardView(deviceName: "Arduino", rssi: "-1", bleController: BLEController.shared, isConnected: .constant(true))
            .previewLayout(.fixed(width: 400, height: 30))
    }
}

