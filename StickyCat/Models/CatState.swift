import Foundation

enum CatState {
    case idle
    case run
    case sit
    case jump
    case sleep
    case meow
    case pounce

    var assetSuffix: String {
        switch self {
        case .idle:   return "Idle"
        case .run:    return "Run"
        case .sit:    return "Sit"
        case .jump:   return "Jump"
        case .sleep:  return "Sleep"
        case .meow:   return "Meow"
        case .pounce: return "Pounce"
        }
    }

    var frameCount: Int {
        switch self {
        case .idle:   return 12
        case .run:    return 6
        case .sit:    return 7
        case .jump:   return 15
        case .sleep:  return 4
        case .meow:   return 7
        case .pounce: return 13
        }
    }
}
