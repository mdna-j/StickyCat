import SwiftUI

struct CatModel {
    var x: CGFloat
    var y: CGFloat
    var state: CatState
    var breed: CatBreed
    var facingRight: Bool

    init(breed: CatBreed = .black) {
        self.x = Constants.minX + 20
        self.y = Constants.floorY
        self.state = .idle
        self.breed = breed
        self.facingRight = true
    }

    /// Full asset name e.g. "Black-Idle"
    var assetName: String {
        "\(breed.assetPrefix)-\(state.assetSuffix)"
    }
}
