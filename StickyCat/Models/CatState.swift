import Foundation

enum CatState {
    case sit
    case walk1
    case walk2
    case jump
    case play

    /// Emoji overlay shown on top of the breed emoji to communicate state.
    var stateEmoji: String {
        switch self {
        case .sit:          return "💤"
        case .walk1, .walk2: return "🐾"
        case .jump:         return "⬆️"
        case .play:         return "🎾"
        }
    }

    /// Asset image name suffix — used when real sprites are added.
    var assetSuffix: String {
        switch self {
        case .sit:   return "sit"
        case .walk1: return "walk1"
        case .walk2: return "walk2"
        case .jump:  return "jump"
        case .play:  return "play"
        }
    }
}
