import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CatViewModel()
    @State private var noteText: String = ""
    @State private var noteColor: Color = Constants.noteColors[0]
    @State private var keystrokeCount: Int = 0

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
                    NoteColorPickerView(selectedColor: $noteColor)
                    Spacer()
                    BreedPickerView(selectedBreed: $viewModel.selectedBreed)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
        }
        .frame(width: Constants.noteWidth, height: Constants.noteHeight)
        .onChange(of: noteText) {
            keystrokeCount += 1
            // Jump roughly every 8-12 keystrokes
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
