
import SwiftUI

struct CustomTextField: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    var isNumber: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)

            HStack {
                TextField(placeholder, text: $text)
                    .keyboardType(isNumber ? .numberPad : .default)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)

                if !text.isEmpty {
                    Button(action: { text = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                }
            }
        }
        .padding(.horizontal)
    }
}
