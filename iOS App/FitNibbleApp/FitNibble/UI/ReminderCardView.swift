import SwiftUI

struct ReminderCardView: View {
    let title: String
    let time: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(time)
                    .font(.largeTitle)
                Spacer()
                HStack {
                    Text(title)
                    Image(systemName: "clock")
                }
                .font(.callout)
            }
            Spacer()
        }
    }
    
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderCardView(title: "Breakfast", time: "10:00 AM")
            .previewLayout(.fixed(width: 400, height: 60))
    }
}

