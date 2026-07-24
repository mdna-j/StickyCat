import SwiftUI

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

    // Each breed has its own weighted action pool giving it a distinct personality
    var actionPool: [CatAction] {
        switch self {

        case .black:
            // Mysterious — lurks, pounces, sleeps a lot. Rarely meows.
            return [
                .idle,   .idle,
                .walkRight, .walkLeft,
                .pounce, .pounce, .pounce,
                .sleep,  .sleep,
                .jump,
            ]

        case .brown:
            // Lazy and chill — mostly idles and sleeps, slow walks, rarely jumps
            return [
                .idle,   .idle,   .idle,
                .sleep,  .sleep,  .sleep,
                .walkRight, .walkLeft,
                .meow,
                .pounce,
            ]

        case .orangeTabby:
            // Chaotic gremlin — constantly moving, jumps everywhere, barely sleeps
            return [
                .walkRight, .walkRight, .walkRight,
                .walkLeft,  .walkLeft,  .walkLeft,
                .jump,      .jump,      .jump,
                .meow,      .meow,
                .pounce,    .pounce,
                .idle,
            ]

        case .siamese:
            // Vocal and dramatic — meows constantly, walks around announcing itself
            return [
                .meow,   .meow,   .meow,   .meow,
                .walkRight, .walkRight,
                .walkLeft,  .walkLeft,
                .idle,   .idle,
                .jump,
                .pounce,
            ]

        case .tuxedo:
            // Dramatic and fancy — lots of posing, pouncing, jumping
            return [
                .pounce, .pounce, .pounce,
                .jump,   .jump,   .jump,
                .idle,   .idle,
                .walkRight, .walkLeft,
                .meow,
                .sleep,
            ]

        case .white:
            // Calm and elegant — mostly sits still, gentle walks, occasional meow
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
