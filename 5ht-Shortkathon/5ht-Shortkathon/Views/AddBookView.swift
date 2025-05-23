import SwiftUI
import PhotosUI
import UserNotifications

struct AddBookView: View {
    //    @Environment(\.dismiss) var dismiss
    @State private var selectedImage: UIImage? = nil
           @State private var photoItem: PhotosPickerItem? = nil

    @State private var wakeUp = Date()
    
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var totalPages: String = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    @State private var isImagePickerTapped = false
    var onAdd: (Book) -> Void
    
    // MARK: - 알림 권한 요청 및 카테고리 등록
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        
        // 버튼 액션 정의
        let startAction = UNNotificationAction(identifier: "START_ACTION",
                                               title: "시작하기",
                                               options: [.foreground])
        let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION",
                                                title: "미루기",
                                                options: [])
        
        // 카테고리 정의
        let category = UNNotificationCategory(identifier: "WAKEUP_CATEGORY",
                                              actions: [startAction, snoozeAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        // 카테고리 등록
        center.setNotificationCategories([category])
        
        // 권한 요청
        center.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if success {
                print("✅ 알림 권한 승인됨")
            } else if let error = error {
                print("❌ 알림 권한 오류: \(error.localizedDescription)")
            } else {
                print("❌ 알림 권한 거부됨")
            }
        }
    }
    
    // MARK: - 알림 예약
    func scheduleNotification(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "⏰ 알림!"
        content.body = "매일 같은 시간에 울리는 알림입니다."
        content.sound = .default
        content.categoryIdentifier = "WAKEUP_CATEGORY" // 📌 카테고리 지정
        
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.hour, .minute], from: date)
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ 알림 예약 실패: \(error.localizedDescription)")
            } else {
                print("✅ 매일 알림 예약 완료: \(dateComponents)")
            }
        }
    }
    
    
    
    var body: some View {
        ScrollView{
            VStack(spacing: 24) {
                
                // 상단 바
                HStack {
                    Spacer()
                    Text("책 정보 입력")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 16)
                    Spacer()
                    //                Button(action: { dismiss() }) {
                    //                    Image(systemName: "xmark")
                    //                        .foregroundColor(.black)
                    //                        .padding()
                    //                }
                }
                
                // 입력 필드
                Group {
                    CustomTextField(title: "제목", placeholder: "책의 제목을 입력해주세요", text: $title)
                    CustomTextField(title: "저자", placeholder: "책의 저자를 입력해주세요", text: $author)
                    CustomTextField(title: "총 페이지", placeholder: "책의 총 페이지를 입력해주세요", text: $totalPages, isNumber: true)
                }
                
                // 독서 시간 선택
                VStack(alignment: .leading, spacing: 8) {
                    Text("시작 시간")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(16)
                }
                .padding(.horizontal)
                .onAppear(perform: requestNotificationPermission)
                
                //종료시간
                VStack(alignment: .leading, spacing: 8) {
                    Text("종료 시간")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(16)
                    
                    
                    
                }
                .padding(.horizontal)
                // ✅ 표지 추가 버튼
                VStack(alignment: .leading, spacing: 8) {
                    Text("표지")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    
                    
                    
                    PhotosPicker(
                               selection: $photoItem,
                               matching: .images,
                               photoLibrary: .shared()
                    ) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                                .shadow(radius: 3)
                        } else {
                            Image(systemName: "photo.on.rectangle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    
                    
//                    Button(action: {
//                        isImagePickerTapped.toggle()
//                        print("표지 버튼 클릭됨!")
//                    }) {
//                        VStack(spacing: 8) {
//                            Image(systemName: "photo.on.rectangle.angled")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 40, height: 40)
//                                .foregroundColor(.gray)
//                            
//                            Text("표지를 선택해주세요")
//                                .font(.footnote)
//                                .foregroundColor(.gray)
//                        }
//                        .frame(maxWidth: .infinity, minHeight: 120)
//                        .background(Color.gray.opacity(0.1))
//                        .cornerRadius(16)
//                    }//vstack
                    
                }
                .padding(.horizontal)
                
                // 추가 버튼
                Button(action: {
                    guard let pages = Int(totalPages) else { return }
                    let newBook = Book(imageName: "default-book", title: title, author: author)
                    onAdd(newBook)
                    //dismiss()
                    scheduleNotification(at: wakeUp)
                }) {
                    Text("완료하기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 20)
        }//vstack
    }
}
