import SwiftUI

struct ScanningHeaderView: View {
    @Binding var isConnected: Bool
    @Binding var isPairingOpen: Bool
    @ObservedObject var bleController: BLEController
    var body: some View {
        HStack {
            Text("Connection")
            Spacer()
            if isPairingOpen && !isConnected {
                Button(action: {
                    bleController.stopScanning()
                    bleController.startScanning()
                },
                label: {
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.large)
                })
            }
        }
    }
}

struct ScanningHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ScanningHeaderView(isConnected: .constant(false), isPairingOpen: .constant(true), bleController: BLEController.shared)
    }
}
