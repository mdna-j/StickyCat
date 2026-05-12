import SwiftUI

// CatBreed is now a wrapper around a user-chosen Color.
// All states use the same base sprites (cat_idle, cat_run),
// tinted at render time via .colorInvert + .colorMultiply.
// Since the sprite is black, we invert it to white first, then multiply the tint color.
// This means: white = natural white cat, bright colors = vivid tinted cats.
struct CatBreed: Equatable {
    var color: Color

    static let `default` = CatBreed(color: .white)

    static let presets: [CatBreed] = [
        CatBreed(color: .white),
        CatBreed(color: Color(red: 0.25, green: 0.25, blue: 0.28)),  // dark grey (black-ish, eyes still visible)
        CatBreed(color: Color(red: 1.0,  green: 0.55, blue: 0.15)),  // orange
        CatBreed(color: Color(red: 0.75, green: 0.75, blue: 0.75)),  // grey
    ]
}

