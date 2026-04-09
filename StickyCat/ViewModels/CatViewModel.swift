import SwiftUI
import Combine

enum CatAction: CaseIterable {
    case sit
    case walkRight
    case walkLeft
    case jump
    case play
}

@MainActor
class CatViewModel: ObservableObject {
    @Published var cat: CatModel = CatModel(breed: .calico)

    // Breed is mirrored here so the picker binding is clean
    @Published var selectedBreed: CatBreed = .calico {
        didSet { cat.breed = selectedBreed }
    }

    private var behaviorTimer: Timer?
    private var walkFrameTimer: Timer?
    private var jumpPhase: Int = 0  // 0 = not jumping, 1 = up, 2 = down

    init() {
        startBehaviorLoop()
    }

    // MARK: - Behavior Loop

    func startBehaviorLoop() {
        scheduleNextAction()
    }

    private func scheduleNextAction() {
        let interval = Double.random(
            in: Constants.minActionInterval...Constants.maxActionInterval
        )
        behaviorTimer?.invalidate()
        behaviorTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.performRandomAction()
                self?.scheduleNextAction()
            }
        }
    }

    private func performRandomAction() {
        // Don't interrupt a jump mid-sequence
        guard jumpPhase == 0 else { return }

        let action = CatAction.allCases.randomElement() ?? .sit
        switch action {
        case .sit:       performSit()
        case .walkRight: performWalk(direction: .right)
        case .walkLeft:  performWalk(direction: .left)
        case .jump:      performJump()
        case .play:      performPlay()
        }
    }

    // MARK: - Actions

    private func performSit() {
        stopWalkFrames()
        withAnimation(.easeOut(duration: 0.2)) {
            cat.state = .sit
        }
    }

    private enum Direction { case left, right }

    private func performWalk(direction: Direction) {
        let newX: CGFloat
        switch direction {
        case .right:
            newX = min(cat.x + Constants.walkStep, Constants.maxX)
            cat.facingRight = true
        case .left:
            newX = max(cat.x - Constants.walkStep, Constants.minX)
            cat.facingRight = false
        }

        // Start alternating walk frames
        cat.state = .walk1
        stopWalkFrames()
        walkFrameTimer = Timer.scheduledTimer(
            withTimeInterval: Constants.walkFrameInterval,
            repeats: true
        ) { [weak self] _ in
            Task { @MainActor [weak self] in
                guard let self else { return }
                self.cat.state = (self.cat.state == .walk1) ? .walk2 : .walk1
            }
        }

        withAnimation(.linear(duration: 0.5)) {
            cat.x = newX
        }

        // Stop walking after one step duration
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            self?.stopWalkFrames()
            self?.cat.state = .sit
        }
    }

    private func performJump() {
        stopWalkFrames()
        jumpPhase = 1

        withAnimation(.easeOut(duration: 0.25)) {
            cat.state = .jump
            cat.y = Constants.jumpY
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            guard let self else { return }
            withAnimation(.easeIn(duration: 0.25)) {
                self.cat.y = Constants.floorY
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.cat.state = .sit
                self?.jumpPhase = 0
            }
        }
    }

    private func performPlay() {
        stopWalkFrames()

        // Walk toward ball
        let ballX = Constants.ballX - Constants.catWidth / 2
        let moveDuration = abs(cat.x - ballX) / 120.0  // speed proportional to distance

        cat.state = .walk1
        cat.facingRight = cat.x < ballX

        withAnimation(.linear(duration: moveDuration)) {
            cat.x = ballX
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + moveDuration) { [weak self] in
            withAnimation(.easeOut(duration: 0.15)) {
                self?.cat.state = .play
            }
        }
    }

    // MARK: - Helpers

    private func stopWalkFrames() {
        walkFrameTimer?.invalidate()
        walkFrameTimer = nil
    }

    deinit {
        behaviorTimer?.invalidate()
        walkFrameTimer?.invalidate()
    }
}
