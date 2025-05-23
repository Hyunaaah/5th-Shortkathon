import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var author: String = ""
    @State private var totalPages: String = ""
    @State private var readingTime = Date()

    var onAdd: (Book) -> Void

    var body: some View {
        ScrollView{
        VStack(spacing: 24) {
            
            // 상단 바
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
            
            // 추가 버튼
            Button(action: {
                guard let pages = Int(totalPages) else { return }
                let newBook = Book(imageName: "default-book", title: title, author: author)
                onAdd(newBook)
                dismiss()
            }) {
                Text("책 추가하기")
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
    }
    }
}
