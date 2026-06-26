import SwiftUI

struct BreedPickerView: View {
    @Binding var selectedBreed: CatBreed
    @State private var isExpanded: Bool = false

    var body: some View {
        Menu {
            ForEach(CatBreed.allCases) { breed in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedBreed = breed
                    }
                } label: {
                    HStack {
                        Text(breed.displayName)
                        if selectedBreed == breed {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack(spacing: 6) {
                Text(selectedBreed.displayName)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(Color(red: 0.3, green: 0.28, blue: 0.22))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(.ultraThinMaterial, in: Capsule())
        }
        .menuStyle(.borderlessButton)
        .fixedSize()
    }
}
