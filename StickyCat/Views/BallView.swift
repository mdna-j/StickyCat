import SwiftUI

struct BallView: View {
    var body: some View {
        Text("🎾")
            .font(.system(size: 22))
            .position(x: Constants.ballX, y: Constants.ballY)
    }
}
