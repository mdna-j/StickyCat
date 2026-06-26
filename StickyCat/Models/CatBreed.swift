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

    /// Prefix used to build asset names e.g. "Black-Idle", "OrangeTabby-Run"
    var assetPrefix: String { rawValue }
}
