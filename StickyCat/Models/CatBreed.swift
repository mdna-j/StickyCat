import Foundation

enum CatBreed: String, CaseIterable, Identifiable {
    case calico
    case ragdoll

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .calico:  return "Calico"
        case .ragdoll: return "Ragdoll"
        }
    }

    /// SF Symbol + color used as placeholder sprite for each breed+state combo.
    /// Replace with real image names once assets are added.
    var emoji: String {
        switch self {
        case .calico:  return "🐱"
        case .ragdoll: return "😸"
        }
    }
}
