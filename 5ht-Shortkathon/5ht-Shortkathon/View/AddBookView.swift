import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss

    // 입력 필드
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var totalPages: String = ""
    @State private var readingTime = Date()

    // 네비게이션 & 전달값
    @State private var showTimer = false
    @State private var timerDuration: TimeInterval = 0
    @State private var isPaused: Bool = false   // ← 이 라인 추가!

    var onAdd: (Book) -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // … 기존 UI …

                    HStack {
                        Spacer()
                        Text("책 정보 입력")
                            .font(.headline)
                        Spacer()
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding()
                        }
                    }
                    
                    // 입력 필드
                    Group {
                        CustomTextField(title: "제목", placeholder: "책의 제목을 입력해주세요", text: $title)
                        CustomTextField(title: "저자", placeholder: "책의 저자를 입력해주세요", text: $author)
                        CustomTextField(title: "총 페이지", placeholder: "책의 총 페이지를 입력해주세요", text: $totalPages, isNumber: true)
                    }
                    
                    // 독서 시간 선택
                    VStack(alignment: .leading, spacing: 8) {
                        Text("독서 시간")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        DatePicker("", selection: $readingTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    
                    Spacer()   
                    Button("책 추가하기") {
                        // 1) 페이지 수 체크 & Book 생성
                        guard Int(totalPages) != nil else { return }
                        onAdd(Book(imageName: "default-book",
                                   title: title,
                                   author: author))

                        // 2) 읽기 시간 → 초 계산
                        let comps = Calendar.current.dateComponents([.hour, .minute],
                                                                     from: readingTime)
                        timerDuration = TimeInterval(
                            (comps.hour ?? 0) * 3600 +
                            (comps.minute ?? 0) * 60
                        )

                        // 3) 타이머 화면으로 이동
                        showTimer = true
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .padding(.top, 20)
            }
            // iOS16+ 방식: NavigationStack에서 바로 destination 지정
            .navigationDestination(isPresented: $showTimer) {
                TimerCircleView(
                    totalDuration: timerDuration,
                    isPaused: $isPaused
                )
            }
            .navigationBarHidden(true)
        }
    }
}
