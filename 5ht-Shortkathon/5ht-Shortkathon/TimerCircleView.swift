import SwiftUI
import Combine

struct TimerCircleView: View {
    // 전체 카운트다운 시간 (초)
    let totalDuration: TimeInterval = 300  // 나중에 값 입력받아서 넘기기
    
    // 남은 시간 (초)
    @State private var remainingTime: TimeInterval
    // 테두리 진행도 (0…1)
    @State private var progress: CGFloat
    
    // 타이머 퍼블리셔
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // MM:SS 포맷터
    private let formatter: DateComponentsFormatter = {
        let f = DateComponentsFormatter()
        f.allowedUnits = [.minute, .second]
        f.zeroFormattingBehavior = .pad
        return f
    }()
    
    init() {
        _remainingTime = State(initialValue: totalDuration)
        _progress = State(initialValue: 1.0)
    }
    
    var body: some View {
        ZStack {
            // 배경 원 (희미한 회색)
            Circle()
                .stroke(Color(hex: "1B143F"), lineWidth: 12)
                .frame(width: 200, height: 200)
            
            // 노란색 진행 테두리
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color(hex: "7012CE"),
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .frame(width: 200, height: 200)
                .animation(.linear(duration: 1), value: progress)
            
            // 중앙에 남은 시간 텍스트
            Text(formatter.string(from: remainingTime) ?? "00:00")
                .font(.system(size: 40, weight: .bold, design: .monospaced))
        }
        .onReceive(timer) { _ in
            guard remainingTime > 0 else {
                // 완료되면 타이머 취소
                timer.upstream.connect().cancel()
                return
            }
            
            // 1초씩 감소시키고, progress 업데이트
            remainingTime -= 1
            progress = max(0, CGFloat(remainingTime / totalDuration))
        }
    }
}

struct TimerCircleView_Previews: PreviewProvider {
    static var previews: some View {
        TimerCircleView()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
            case 3: // RGB (12-bit)
                (r, g, b, a) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17, 255)
            case 6: // RGB (24-bit)
                (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (r, g, b, a) = (0, 0, 0, 255)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
