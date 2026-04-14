import SwiftUI

struct CatView: View {
    let cat: CatModel

    var body: some View {
        ZStack {
            // Breed emoji (body)
            Text(cat.breed.emoji)
                .font(.system(size: 40))

            // State indicator (top-right badge)
            Text(cat.state.stateEmoji)
                .font(.system(size: 16))
                .offset(x: 20, y: -18)
        }
        .frame(width: Constants.catWidth, height: Constants.catHeight)
        .scaleEffect(x: cat.facingRight ? 1 : -1, y: 1)
        .position(x: cat.x, y: cat.y)
    }
}
