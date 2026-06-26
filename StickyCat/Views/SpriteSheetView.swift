import SwiftUI

/// Renders a single frame from a horizontal spritesheet.
struct SpriteSheetView: View {
    let imageName: String
    let frameCount: Int
    let currentFrame: Int

    var body: some View {
        GeometryReader { geo in
            let frameWidth = geo.size.width
            let frameHeight = geo.size.height
            let totalWidth = frameWidth * CGFloat(frameCount)

            Image(imageName)
                .resizable()
                .interpolation(.none)
                .frame(width: totalWidth, height: frameHeight)
                .offset(x: -frameWidth * CGFloat(currentFrame))
                .frame(width: frameWidth, height: frameHeight, alignment: .leading)
                .clipped()
        }
    }
}
