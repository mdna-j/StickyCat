import SwiftUI

// Renders a single frame from a horizontal spritesheet.
// The sheet is assumed to have `frameCount` equally-sized frames in one row.
struct SpriteSheetView: View {
    let imageName: String
    let frameCount: Int
    let currentFrame: Int
    let tint: Color

    var body: some View {
        GeometryReader { geo in
            let frameWidth = geo.size.width
            let frameHeight = geo.size.height
            let totalWidth = frameWidth * CGFloat(frameCount)

            spriteFrame(totalWidth: totalWidth, frameWidth: frameWidth, frameHeight: frameHeight)
        }
    }

    private func spriteFrame(totalWidth: CGFloat, frameWidth: CGFloat, frameHeight: CGFloat) -> some View {
        Image(imageName)
            .resizable()
            .interpolation(.none)
            .frame(width: totalWidth, height: frameHeight)
            .offset(x: -frameWidth * CGFloat(currentFrame))
            .frame(width: frameWidth, height: frameHeight, alignment: .leading)
            .clipped()
            // Invert to make black → white so colorMultiply has light pixels to tint,
            // then screen-blend the tint color so transparent areas stay transparent
            .saturation(0)           // strip original color first
            .colorInvert()           // black cat → white cat
            .colorMultiply(tint)     // white cat → tinted cat
    }
}

