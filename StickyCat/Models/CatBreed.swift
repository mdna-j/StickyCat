import SwiftUI
import AppKit

enum CatBreed: String, CaseIterable, Identifiable {
    case black       = "Black"
    case brown       = "Brown"
    case orangeTabby = "OrangeTabby"
    case siamese     = "Siamese"
    case tuxedo      = "Tuxedo"
    case white       = "White"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .black:       return "Black"
        case .brown:       return "Brown"
        case .orangeTabby: return "Orange Tabby"
        case .siamese:     return "Siamese"
        case .tuxedo:      return "Tuxedo"
        case .white:       return "White"
        }
    }

    // Prefix used to build asset names e.g. "Black-Idle", "OrangeTabby-Run"
    var assetPrefix: String { rawValue }

    // Icon asset name
    var iconName: String {
        switch self {
        case .black:       return "icon-black"
        case .brown:       return "icon-brown"
        case .orangeTabby: return "icon-orangetabby"
        case .siamese:     return "icon-siamese"
        case .tuxedo:      return "icon-tuxedo"
        case .white:       return "icon-white"
        }
    }

    // Pastel background color for dock icon
    var iconBackgroundColor: NSColor {
        switch self {
        case .black:       return NSColor(red: 0.85, green: 0.85, blue: 0.95, alpha: 1)
        case .brown:       return NSColor(red: 0.95, green: 0.90, blue: 0.80, alpha: 1)
        case .orangeTabby: return NSColor(red: 1.00, green: 0.92, blue: 0.80, alpha: 1)
        case .siamese:     return NSColor(red: 0.85, green: 0.93, blue: 1.00, alpha: 1)
        case .tuxedo:      return NSColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1)
        case .white:       return NSColor(red: 1.00, green: 0.88, blue: 0.92, alpha: 1)
        }
    }

    // Each breed has its own weighted action pool giving it a distinct personality
    var actionPool: [CatAction] {
        switch self {

        case .black:
            return [
                .idle,   .idle,
                .walkRight, .walkLeft,
                .pounce, .pounce, .pounce,
                .sleep,  .sleep,
                .jump,
            ]

        case .brown:
            return [
                .idle,   .idle,   .idle,
                .sleep,  .sleep,  .sleep,
                .walkRight, .walkLeft,
                .meow,
                .pounce,
            ]

        case .orangeTabby:
            return [
                .walkRight, .walkRight, .walkRight,
                .walkLeft,  .walkLeft,  .walkLeft,
                .jump,      .jump,      .jump,
                .meow,      .meow,
                .pounce,    .pounce,
                .idle,
            ]

        case .siamese:
            return [
                .meow,   .meow,   .meow,   .meow,
                .walkRight, .walkRight,
                .walkLeft,  .walkLeft,
                .idle,   .idle,
                .jump,
                .pounce,
            ]

        case .tuxedo:
            return [
                .pounce, .pounce, .pounce,
                .jump,   .jump,   .jump,
                .idle,   .idle,
                .walkRight, .walkLeft,
                .meow,
                .sleep,
            ]

        case .white:
            return [
                .idle,   .idle,   .idle,   .idle,
                .walkRight, .walkRight,
                .walkLeft,  .walkLeft,
                .meow,   .meow,
                .sleep,
                .jump,
            ]
        }
    }
}
