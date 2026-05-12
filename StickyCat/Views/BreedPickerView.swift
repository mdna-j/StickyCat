import SwiftUI

struct BreedPickerView: View {
    @Binding var catBreed: CatBreed

    var body: some View {
        HStack(spacing: 8) {
            // Preset swatches
            ForEach(CatBreed.presets, id: \.color.description) { preset in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        catBreed = preset
                    }
                } label: {
                    Circle()
                        .fill(preset.color)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color.primary.opacity(0.25), lineWidth: 1)
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.primary.opacity(0.7), lineWidth: 2)
                                .opacity(catBreed.color.description == preset.color.description ? 1 : 0)
                        )
                        .scaleEffect(catBreed.color.description == preset.color.description ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.15), value: catBreed.color.description)
                }
                .buttonStyle(.plain)
            }

            Divider()
                .frame(height: 16)
                .opacity(0.4)

            // Custom color picker
            ColorPicker("", selection: Binding(
                get: { catBreed.color },
                set: { catBreed = CatBreed(color: $0) }
            ), supportsOpacity: false)
            .labelsHidden()
            .frame(width: 24, height: 24)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial, in: Capsule())
    }
}

