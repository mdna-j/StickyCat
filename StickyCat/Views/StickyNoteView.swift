import SwiftUI
import AppKit

struct StickyNoteView: View {
    @Binding var text: String
    var color: Color

    private let fontSize: CGFloat = 14

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Note background
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
                .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 4)

            // Text editor
            NativeTextEditor(text: $text, fontSize: fontSize)
                .padding(.top, 16)
                .padding(.horizontal, 14)
                .padding(.bottom, 80)
        }
        .frame(width: Constants.noteWidth, height: Constants.noteHeight)
    }
}

struct NativeTextEditor: NSViewRepresentable {
    @Binding var text: String
    let fontSize: CGFloat

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSTextView.scrollableTextView()
        guard let textView = scrollView.documentView as? NSTextView else { return scrollView }

        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isSelectable = true
        textView.isRichText = false
        textView.font = NSFont.systemFont(ofSize: fontSize)
        textView.textColor = NSColor(white: 0.15, alpha: 1.0)
        textView.backgroundColor = .clear
        textView.drawsBackground = false
        textView.textContainerInset = NSSize(width: 0, height: 4)

        scrollView.backgroundColor = .clear
        scrollView.drawsBackground = false
        scrollView.hasVerticalScroller = false
        scrollView.hasHorizontalScroller = false

        return scrollView
    }

    func updateNSView(_ scrollView: NSScrollView, context: Context) {
        guard let textView = scrollView.documentView as? NSTextView else { return }
        if textView.string != text {
            textView.string = text
        }
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: NativeTextEditor
        init(_ parent: NativeTextEditor) { self.parent = parent }
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            parent.text = textView.string
        }
    }
}
