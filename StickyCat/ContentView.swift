import SwiftUI
import AppKit

struct ContentView: View {
    @StateObject private var viewModel = CatViewModel()

    // Persisted state — survives app restarts
    @AppStorage("noteText")       private var noteText: String = ""
    @AppStorage("noteColorIndex") private var noteColorIndex: Int = 0
    @AppStorage("catBreed")       private var savedBreed: String = CatBreed.black.rawValue

    @State private var showClearConfirmation: Bool = false
    @State private var keystrokeCount: Int = 0

    private var noteColor: Color {
        Constants.noteColors[min(noteColorIndex, Constants.noteColors.count - 1)]
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // 1. Sticky note background + text editor
                StickyNoteView(text: $noteText, color: noteColor)

                // 2. Animated cat
                CatView(cat: viewModel.cat, frameIndex: viewModel.frameIndex) {
                    viewModel.triggerTap()
                }

                // 3. Note color picker (bottom-left) + clear button + breed picker (bottom-right)
                VStack {
                    Spacer()
                    HStack {
                        NoteColorPickerView(selectedIndex: $noteColorIndex)
                        Spacer()
                        Button {
                            showClearConfirmation = true
                        } label: {
                            Image(systemName: "trash")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.primary)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.ultraThinMaterial, in: Capsule())
                        }
                        .buttonStyle(.plain)
                        .confirmationDialog("Clear note?", isPresented: $showClearConfirmation) {
                            Button("Clear", role: .destructive) { noteText = "" }
                            Button("Cancel", role: .cancel) {}
                        } message: {
                            Text("This will permanently delete everything on the note.")
                        }
                        Spacer()
                        BreedPickerView(selectedBreed: $viewModel.selectedBreed)
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                }
            }
            .onAppear {
                viewModel.updateNoteSize(proxy.size)
            }
            .onChange(of: proxy.size) {
                viewModel.updateNoteSize(proxy.size)
            }
        }
        .frame(
            minWidth: Constants.minNoteWidth,
            idealWidth: Constants.noteWidth,
            maxWidth: .infinity,
            minHeight: Constants.minNoteHeight,
            idealHeight: Constants.noteHeight,
            maxHeight: .infinity
        )
        .ignoresSafeArea()
        .onAppear {
            if let breed = CatBreed(rawValue: savedBreed) {
                viewModel.selectedBreed = breed
            }
            updateDockIcon(for: viewModel.selectedBreed)
        }
        .onChange(of: viewModel.selectedBreed) {
            savedBreed = viewModel.selectedBreed.rawValue
            updateDockIcon(for: viewModel.selectedBreed)
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

    private func updateDockIcon(for breed: CatBreed) {
        guard let catImage = NSImage(named: breed.iconName),
              let cgCat = catImage.cgImage(forProposedRect: nil, context: nil, hints: nil)
        else { return }

        let size = 1024
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let ctx = CGContext(
            data: nil,
            width: size, height: size,
            bitsPerComponent: 8,
            bytesPerRow: size * 4,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else { return }

        let rect = CGRect(origin: .zero, size: CGSize(width: size, height: size))
        let radius = CGFloat(size) * 0.225  // macOS icon corner radius

        // Clip to rounded rect first
        ctx.beginPath()
        ctx.move(to: CGPoint(x: radius, y: 0))
        ctx.addLine(to: CGPoint(x: CGFloat(size) - radius, y: 0))
        ctx.addArc(center: CGPoint(x: CGFloat(size) - radius, y: radius), radius: radius, startAngle: -.pi/2, endAngle: 0, clockwise: false)
        ctx.addLine(to: CGPoint(x: CGFloat(size), y: CGFloat(size) - radius))
        ctx.addArc(center: CGPoint(x: CGFloat(size) - radius, y: CGFloat(size) - radius), radius: radius, startAngle: 0, endAngle: .pi/2, clockwise: false)
        ctx.addLine(to: CGPoint(x: radius, y: CGFloat(size)))
        ctx.addArc(center: CGPoint(x: radius, y: CGFloat(size) - radius), radius: radius, startAngle: .pi/2, endAngle: .pi, clockwise: false)
        ctx.addLine(to: CGPoint(x: 0, y: radius))
        ctx.addArc(center: CGPoint(x: radius, y: radius), radius: radius, startAngle: .pi, endAngle: .pi*3/2, clockwise: false)
        ctx.closePath()
        ctx.clip()

        // Fill background with pastel color
        let bg = breed.iconBackgroundColor
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        bg.getRed(&r, green: &g, blue: &b, alpha: &a)
        ctx.setFillColor(red: r, green: g, blue: b, alpha: a)
        ctx.fill(rect)

        // Draw cat filling the whole icon
        ctx.draw(cgCat, in: rect)

        guard let cgFinal = ctx.makeImage() else { return }
        let finalImage = NSImage(cgImage: cgFinal, size: NSSize(width: size, height: size))

        NSApplication.shared.applicationIconImage = nil
        NSApplication.shared.applicationIconImage = finalImage
    }
}

#Preview {
    ContentView()
}
