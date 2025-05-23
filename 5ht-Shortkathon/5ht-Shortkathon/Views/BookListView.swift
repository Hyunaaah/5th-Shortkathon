import SwiftUI

struct BookListView: View {
    @State private var books: [Book] = [
        Book(imageName: "book1", title: "구의 증명", author: "최진영"),
        Book(imageName: "book2", title: "이처럼 사소한 것들", author: "클레어 키건"),
        Book(imageName: "book3", title: "도둑맞은 집중력", author: "요한 하리"),
        Book(imageName: "book4", title: "퓨처 셀프", author: "벤저민 하디")
    ]
    @State private var showAddBookSheet = false
    @State private var remainingTime: TimeInterval = 0

    // 그리드 2열 구성
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            VStack {
                Text("도서 목록")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(hex: "#000000"))
                    .padding(.top, 16)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(books) { book in
                            VStack(alignment: .leading, spacing: 5) {
                                Image(book.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 160)
                                    .cornerRadius(8)
                                
                                Text(book.title)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                Text(book.author)
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
            }
            .padding(.bottom, 60) // 탭바와 겹치지 않도록
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showAddBookSheet = true
                        }) {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding()
                    }
                }
            )
            .sheet(isPresented: $showAddBookSheet) {
                AddBookView(remainingTime: $remainingTime) { newBook in
                    books.append(newBook)
                    showAddBookSheet = false
                }
            }
        }
    }
}
