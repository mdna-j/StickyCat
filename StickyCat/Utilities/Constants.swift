import SwiftUI

enum Constants {
    static let noteWidth: CGFloat = 380
    static let noteHeight: CGFloat = 420

    static let catWidth: CGFloat = 56
    static let catHeight: CGFloat = 56

    static let minX: CGFloat = 40
    static let maxX: CGFloat = 300

    // Leave room above breed picker (~44pt) + cat height
    static let floorY: CGFloat = 310
    static let jumpY: CGFloat = 250

    static let ballX: CGFloat = 300
    static let ballY: CGFloat = 318

    // Behavior loop interval range (seconds)
    static let minActionInterval: Double = 2.5
    static let maxActionInterval: Double = 4.0

    // Walk frame alternation interval
    static let walkFrameInterval: Double = 0.35

    // How far the cat moves per walk action
    static let walkStep: CGFloat = 45
}
