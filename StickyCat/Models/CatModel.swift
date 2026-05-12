import SwiftUI

struct CatModel {
    var x: CGFloat
    var y: CGFloat
    var state: CatState
    var breed: CatBreed
    var facingRight: Bool

    init(breed: CatBreed = .default) {
        self.x = Constants.minX + 20
        self.y = Constants.floorY
        self.state = .sit
        self.breed = breed
        self.facingRight = true
    }
}

