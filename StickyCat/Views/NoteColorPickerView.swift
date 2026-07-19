import SwiftUI

struct NoteColorPickerView: View {
    @Binding var selectedIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(Constants.noteColors.indices, id: \.self) { index in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedIndex = index
                    }
                } label: {
                    Circle()
                        .fill(Constants.noteColors[index])
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color.primary.opacity(0.25), lineWidth: 1)
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.primary.opacity(0.6), lineWidth: 2)
                                .opacity(selectedIndex == index ? 1 : 0)
                        )
                        .scaleEffect(selectedIndex == index ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.15), value: selectedIndex)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial, in: Capsule())
    }
}
