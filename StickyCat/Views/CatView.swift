import SwiftUI

struct CatView: View {
    let cat: CatModel
    let frameIndex: Int
    let scale: Double
    var onTap: (() -> Void)? = nil

    var body: some View {
        SpriteSheetView(
            imageName: cat.assetName,
            frameCount: cat.state.frameCount,
            currentFrame: frameIndex
        )
        .frame(width: Constants.catWidth * CGFloat(scale), height: Constants.catHeight * CGFloat(scale))
        .scaleEffect(x: cat.facingRight ? 1 : -1, y: 1)
        .position(x: cat.x, y: cat.y)
        .onTapGesture {
            onTap?()
        }
    }
}
