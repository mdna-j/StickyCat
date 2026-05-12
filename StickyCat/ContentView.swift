import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CatViewModel()
    @State private var noteText: String = ""
    @State private var noteColor: Color = Constants.noteColors[0]

    var body: some View {
        ZStack {
            // 1. Sticky note background + text editor
            StickyNoteView(text: $noteText, color: noteColor)

            // 2. Ball (fixed position)
            BallView()

            // 3. Animated cat
            CatView(cat: viewModel.cat, frameIndex: viewModel.frameIndex)

            // 4. Color picker (bottom-left) + breed picker (bottom-right)
            VStack {
                Spacer()
                HStack {
                    NoteColorPickerView(selectedColor: $noteColor)
                    Spacer()
                    BreedPickerView(catBreed: $viewModel.catBreed)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
        }
        .frame(width: Constants.noteWidth, height: Constants.noteHeight)
    }
}

#Preview {
    ContentView()
}

