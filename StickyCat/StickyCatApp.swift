import SwiftUI
import AppKit

@main
struct StickyCatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    guard let window = NSApplication.shared.windows.first else { return }
                    window.isOpaque = false
                    window.backgroundColor = .clear
                    window.hasShadow = false
                    window.isMovableByWindowBackground = true
                    // Hide traffic light buttons
                    window.standardWindowButton(.closeButton)?.isHidden = true
                    window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                    window.standardWindowButton(.zoomButton)?.isHidden = true
                }
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
    }
}
