import Foundation

enum CatState {
    case sit
    case walk1  // not used for frame switching anymore — ViewModel uses frameIndex instead
    case walk2
    case jump
    case play

    // The spritesheet asset name for this state
    var assetName: String {
        switch self {
        case .walk1, .walk2: return "cat_run"
        default:             return "cat_idle"
        }
    }

    // Total number of frames in this state's spritesheet
    var frameCount: Int {
        switch self {
        case .walk1, .walk2: return 6
        default:             return 12
        }
    }
}

