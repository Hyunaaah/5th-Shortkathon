import SwiftUI

struct NextPage: View {
    @Environment(\.dismiss) private var dismiss
    @State private var review: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // MARK: – Custom Navigation Bar
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.primary)
                }

                Spacer()

                Text("오늘의 독서 기록")
                    .font(.headline)

                Spacer()

                // 오른쪽 공간 채우기용 (백버튼과 균형 맞추려고 투명 아이콘 추가)
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .opacity(0)
            }
            .padding()
            .background(Color(.systemBackground))

            ScrollView {
                VStack(spacing: 24) {
                    // MARK: – Book Info
                    HStack(spacing: 16) {
                        Image("bookCover") // Assets에 책 커버 이름
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 140)
                            .clipped()
                            .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("금일 독서 시간")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("19:20")
                                    .font(.title2)
                                    .bold()
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text("총 독서 시간")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("46:12")
                                    .font(.title2)
                                    .bold()
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)

                    // MARK: – 한줄평
                    VStack(alignment: .leading, spacing: 8) {
                        Text("한줄평")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        TextEditor(text: $review)
                            .padding(12)
                            .frame(minHeight: 150)
                            .background(Color(.systemBackground))
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.05),
                                    radius: 4,
                                    x: 0, y: 2)
                    }
                    .padding()
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .padding(.top, 16)
            }
        }
        .edgesIgnoringSafeArea(.bottom) // 스크롤뷰 바텀 슬라이더까지 채우기
    }
}

struct NextPage_Previews: PreviewProvider {
    static var previews: some View {
        NextPage()
    }
}
