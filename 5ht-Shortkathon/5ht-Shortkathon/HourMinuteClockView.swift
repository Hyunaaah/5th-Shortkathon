import SwiftUI

struct HourMinuteClockView: View {
    // 시:분 포맷터
    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1.0)) { context in
            Text(formatter.string(from: context.date))
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .padding()
        }
    }
}

struct HourMinuteClockView_Previews: PreviewProvider {
    static var previews: some View {
        HourMinuteClockView()
    }
}
