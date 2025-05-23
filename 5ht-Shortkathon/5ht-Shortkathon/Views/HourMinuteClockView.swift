import SwiftUI

struct HourMinuteClockView: View {
    /// 현재 시간에 더할 오프셋(초). 기본값 0.
    let offset: TimeInterval
    
    // 시:분 포맷터
    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()
    
    init(offset: TimeInterval = 0) {
        self.offset = offset
    }
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1.0)) { context in
            // context.date 에 offset(초)을 더한 날짜
            let displayDate = context.date.addingTimeInterval(offset)
            
            Text(formatter.string(from: displayDate))
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .padding()
        }
    }
}

struct HourMinuteClockView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            Text("현재 시:분")
            HourMinuteClockView()              // offset = 0
            
            Text("+1시간 후 시:분")
            HourMinuteClockView(offset: 3600)  // offset = 1시간(3600초)
            
            Text("+30분 후 시:분")
            HourMinuteClockView(offset: 1800)  // offset = 30분(1800초)
        }
    }
}
