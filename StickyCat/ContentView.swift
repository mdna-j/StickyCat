import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CatViewModel()

    // Persisted state — survives app restarts
    @AppStorage("noteText")       private var noteText: String = ""
    @AppStorage("noteColorIndex") private var noteColorIndex: Int = 0
    @AppStorage("catBreed")       private var savedBreed: String = CatBreed.black.rawValue

    @State private var keystrokeCount: Int = 0

    private var noteColor: Color {
        Constants.noteColors[min(noteColorIndex, Constants.noteColors.count - 1)]
    }

    var body: some View {
        ZStack {
            // 1. Sticky note background + text editor
            StickyNoteView(text: $noteText, color: noteColor)

            // 2. Animated cat — no hit testing so text editor stays clickable
            CatView(cat: viewModel.cat, frameIndex: viewModel.frameIndex)
                .allowsHitTesting(false)

            // 3. Note color picker (bottom-left) + breed picker (bottom-right)
            VStack {
                Spacer()
                HStack {
                    NoteColorPickerView(selectedIndex: $noteColorIndex)
                    Spacer()
                    BreedPickerView(selectedBreed: $viewModel.selectedBreed)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
        }
        .frame(width: Constants.noteWidth, height: Constants.noteHeight)
        .onAppear {
            // Restore saved breed on launch
            if let breed = CatBreed(rawValue: savedBreed) {
                viewModel.selectedBreed = breed
            }
        }
        .onChange(of: viewModel.selectedBreed) {
            savedBreed = viewModel.selectedBreed.rawValue
        }
        .onChange(of: noteText) {
            keystrokeCount += 1
            let threshold = Int.random(in: 8...12)
            if keystrokeCount >= threshold {
                keystrokeCount = 0
                viewModel.triggerTypingJump()
            }
        }
    }
}

#Preview {
    ContentView()
}
