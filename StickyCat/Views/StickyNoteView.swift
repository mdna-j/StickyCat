import SwiftUI

struct StickyNoteView: View {
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Note background
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 1.0, green: 0.98, blue: 0.75))  // warm sticky yellow
                .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 4)

            // Ruled lines
            VStack(spacing: 0) {
                ForEach(0..<14) { _ in
                    Divider()
                        .background(Color(red: 0.9, green: 0.85, blue: 0.6).opacity(0.5))
                    Spacer().frame(height: 23)
                }
            }
            .padding(.top, 36)
            .padding(.horizontal, 16)
            .clipped()

            // Text editor
            TextEditor(text: $text)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(Color(red: 0.25, green: 0.22, blue: 0.18))
                .scrollContentBackground(.hidden)
                .background(.clear)
                .padding(.top, 30)
                .padding(.horizontal, 14)
                .padding(.bottom, 80)  // leave room for cat area
        }
        .frame(width: Constants.noteWidth, height: Constants.noteHeight)
    }
}
