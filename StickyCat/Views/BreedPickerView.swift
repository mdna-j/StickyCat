import SwiftUI

struct BreedPickerView: View {
    @Binding var selectedBreed: CatBreed

    var body: some View {
        HStack(spacing: 6) {
            ForEach(CatBreed.allCases) { breed in
                Button {
                    selectedBreed = breed
                } label: {
                    HStack(spacing: 4) {
                        Text(breed.emoji)
                            .font(.system(size: 14))
                        Text(breed.displayName)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        selectedBreed == breed
                            ? Color(red: 1.0, green: 0.85, blue: 0.4).opacity(0.8)
                            : Color.white.opacity(0.4)
                    )
                    .foregroundColor(
                        selectedBreed == breed
                            ? Color(red: 0.3, green: 0.22, blue: 0.0)
                            : Color(red: 0.3, green: 0.28, blue: 0.22)
                    )
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(
                                selectedBreed == breed
                                    ? Color(red: 0.8, green: 0.65, blue: 0.1).opacity(0.6)
                                    : Color.clear,
                                lineWidth: 1
                            )
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial, in: Capsule())
    }
}
