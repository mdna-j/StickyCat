import SwiftUI

struct CatView: View {
    let cat: CatModel
    let frameIndex: Int

    var body: some View {
        SpriteSheetView(
            imageName: cat.state.assetName,
            frameCount: cat.state.frameCount,
            currentFrame: frameIndex,
            tint: cat.breed.color
        )
        .frame(width: Constants.catWidth, height: Constants.catHeight)
        .scaleEffect(x: cat.facingRight ? 1 : -1, y: 1)
        .position(x: cat.x, y: cat.y)
    }
}

