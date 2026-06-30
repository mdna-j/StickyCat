import SwiftUI

struct StickyNoteView: View {
    @Binding var text: String
    var color: Color

    // Must match for text to sit on lines
    private let lineHeight: CGFloat = 28
    private let topPadding: CGFloat = 36
    private let fontSize: CGFloat = 14

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Note background
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
                .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 4)

            // Ruled lines — spaced to match lineHeight
            VStack(spacing: 0) {
                ForEach(0..<20) { _ in
                    Spacer().frame(height: lineHeight - 1)
                    Divider()
                        .background(Color(red: 0.9, green: 0.85, blue: 0.6).opacity(0.6))
                }
            }
            .padding(.top, topPadding)
            .padding(.horizontal, 16)
            .clipped()

            // Text editor — line spacing tuned to sit on ruled lines
            TextEditor(text: $text)
                .font(.system(size: fontSize, weight: .regular, design: .rounded))
                .foregroundColor(Color(red: 0.25, green: 0.22, blue: 0.18))
                .lineSpacing(lineHeight - fontSize - 2)
                .scrollContentBackground(.hidden)
                .background(.clear)
                .padding(.top, topPadding - 6)
                .padding(.horizontal, 14)
                .padding(.bottom, 80)
        }
        .frame(width: Constants.noteWidth, height: Constants.noteHeight)
    }
}
