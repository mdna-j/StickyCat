import SwiftUI

struct NoteColorPickerView: View {
    @Binding var selectedColor: Color

    var body: some View {
        HStack(spacing: 8) {
            ForEach(Constants.noteColors, id: \.self) { color in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedColor = color
                    }
                } label: {
                    Circle()
                        .fill(color)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color.primary.opacity(0.25), lineWidth: 1)
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.primary.opacity(0.6), lineWidth: 2)
                                .opacity(selectedColor == color ? 1 : 0)
                        )
                        .scaleEffect(selectedColor == color ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.15), value: selectedColor)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial, in: Capsule())
    }
}
