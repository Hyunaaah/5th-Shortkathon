import SwiftUI

struct MainPage: View {
    @State private var isPaused: Bool = false
    @State private var navigateNext: Bool = false      // ← ①

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                TimerCircleView(totalDuration: 300, isPaused: $isPaused)
                    .padding()

                Spacer()  // push buttons toward bottom if you like

                HStack(spacing: 20) {
                    // ■ StopButton 클릭 시 navigateNext = true
                    StopButton {
                        navigateNext = true      // ← ②
                    }

                    // ▶️ pause/play
                    PausePlayButton(isPaused: isPaused) {
                        isPaused.toggle()
                    }
                }
                .padding(.bottom, 40)
            }
            .padding()
            // ③ 숨겨진 link: navigateNext 가 true 되면 NextPage 로 푸시
            .background(
                NavigationLink(
                    destination: NextPage(),
                    isActive: $navigateNext
                ) {
                    EmptyView()
                }
                .hidden()
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: BookListView()) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }
                }
            }
        }
    }
}

// ■ StopButton – 이제 순수 label + action only
struct StopButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color(hex: "292639"))
                    .frame(width: 60, height: 60)
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 24, height: 24)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// ▶️ PausePlayButton (unchanged)
struct PausePlayButton: View {
    let isPaused: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color(hex: "292639"))
                    .frame(width: 60, height: 60)
                Image(systemName: isPaused ? "play.fill" : "pause.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// HEX extension (unchanged)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (r,g,b,a) = ((int>>8)*17, (int>>4&0xF)*17, (int&0xF)*17, 255)
        case 6: (r,g,b,a) = (int>>16, int>>8&0xFF, int&0xFF, 255)
        case 8: (a,r,g,b) = (int>>24, int>>16&0xFF, int>>8&0xFF, int&0xFF)
        default: (r,g,b,a) = (0,0,0,255)
        }
        self.init(.sRGB,
                  red: Double(r)/255,
                  green: Double(g)/255,
                  blue: Double(b)/255,
                  opacity: Double(a)/255)
    }
}
