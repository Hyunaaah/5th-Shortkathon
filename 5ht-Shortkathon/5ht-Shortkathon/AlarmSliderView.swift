import SwiftUI

struct AlarmSliderView: View {
    // 선택된 시·분 상태
    @State private var selectedHour: Int = Calendar.current.component(.hour, from: Date())
    @State private var selectedMinute: Int = Calendar.current.component(.minute, from: Date())
    
    // 피커 데이터 소스
    private let hours = Array(0...23)
    private let minutes = Array(0...59)
    
    var body: some View {
        HStack(spacing: 0) {
            // 시 피커
            Picker("", selection: $selectedHour) {
                ForEach(hours, id: \.self) { hour in
                    Text(String(format: "%02d시", hour))
                        .tag(hour)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 100, height: 150)   // 원하는 크기로 조정
            .clipped()
            
            // 분 피커
            Picker("", selection: $selectedMinute) {
                ForEach(minutes, id: \.self) { minute in
                    Text(String(format: "%02d분", minute))
                        .tag(minute)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 100, height: 150)
            .clipped()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
        
        // 예시: 선택된 시간 확인 버튼
        Button("알람 설정: \(String(format: "%02d:%02d", selectedHour, selectedMinute))") {
            // 여기에 scheduleAlarm(hour: selectedHour, minute: selectedMinute) 호출
        }
        .padding(.top, 20)
    }
}

struct AlarmSliderView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmSliderView()
    }
}

