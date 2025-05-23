import SwiftUI
import Combine

// ───────────────────────────────────────────────
// 1) 카운트다운 + 일시정지/재개 지원
struct TimerCircleView: View {
    let totalDuration: TimeInterval
    @Binding var isPaused: Bool

    @State private var remainingTime: TimeInterval
    @State private var progress: CGFloat
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private let formatter: DateComponentsFormatter = {
        let f = DateComponentsFormatter()
        f.allowedUnits = [.minute, .second]
        f.zeroFormattingBehavior = .pad
        return f
    }()

    init(totalDuration: TimeInterval, isPaused: Binding<Bool>) {
        self.totalDuration = totalDuration
        self._isPaused     = isPaused
        _remainingTime     = State(initialValue: totalDuration)
        _progress          = State(initialValue: 1.0)
    }

    var body: some View {
        ZStack {
            // 배경 원
            Circle()
                .stroke(Color(hex: "1B143F"), lineWidth: 12)
                .frame(width: 200, height: 200)

            // 진행도 원
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color(hex: "7012CE"),
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .frame(width: 200, height: 200)
                .animation(.linear(duration: 1), value: progress)

            // 남은 시간 텍스트
            Text(formatter.string(from: remainingTime) ?? "00:00")
                .font(.system(size: 40, weight: .bold, design: .monospaced))
        }
        .onReceive(timer) { _ in
            // isPaused == true 면 카운트다운을 멈춥니다
            guard !isPaused, remainingTime > 0 else { return }
            remainingTime -= 1
            progress = max(0, CGFloat(remainingTime / totalDuration))
        }
    }
}
