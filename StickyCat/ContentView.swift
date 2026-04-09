//
//  ContentView.swift
//  StickyCat
//
//  Created by Jose  Medina on 4/8/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CatViewModel()
    @State private var noteText: String = ""

    var body: some View {
        ZStack {
            // 1. Sticky note background + text editor
            StickyNoteView(text: $noteText)

            // 2. Ball (fixed position)
            BallView()

            // 3. Animated cat
            CatView(cat: viewModel.cat)

            // 4. Breed picker pinned to bottom
            VStack {
                Spacer()
                BreedPickerView(selectedBreed: $viewModel.selectedBreed)
                    .padding(.bottom, 12)
            }
        }
        .frame(width: Constants.noteWidth, height: Constants.noteHeight)
    }
}

#Preview {
    ContentView()
}
