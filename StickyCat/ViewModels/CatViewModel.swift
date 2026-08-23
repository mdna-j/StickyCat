import SwiftUI
import Combine

enum CatAction: CaseIterable {
    case idle
    case walkRight
    case walkLeft
    case jump
    case sleep
    case meow
    case pounce
}

@MainActor
class CatViewModel: ObservableObject {
    @Published var cat: CatModel = CatModel(breed: .black)
    @Published var frameIndex: Int = 0

    private var noteSize = CGSize(width: Constants.noteWidth, height: Constants.noteHeight)

    @Published var selectedBreed: CatBreed = .black {
        didSet { cat.breed = selectedBreed }
    }

    private var behaviorTimer: Timer?
    private var spriteTimer: Timer?
    private var jumpPhase: Int = 0

    init() {
        startBehaviorLoop()
        startSpriteLoop()
    }

    // MARK: - Sprite Frame Loop

    func startSpriteLoop() {
        spriteTimer?.invalidate()
        spriteTimer = Timer.scheduledTimer(withTimeInterval: Constants.spriteFrameInterval, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                guard let self else { return }
                self.frameIndex = (self.frameIndex + 1) % self.cat.state.frameCount
            }
        }
    }

    // MARK: - Behavior Loop

    func startBehaviorLoop() {
        scheduleNextAction()
    }

    private func scheduleNextAction() {
        let interval = Double.random(in: Constants.minActionInterval...Constants.maxActionInterval)
        behaviorTimer?.invalidate()
        behaviorTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.performRandomAction()
                self?.scheduleNextAction()
            }
        }
    }

    private func performRandomAction() {
        guard jumpPhase == 0 else { return }

        // Use the breed's personality pool
        var pool = cat.breed.actionPool

        // Still apply edge bias on top of personality
        if cat.x <= minX + Constants.walkStep {
            pool = pool.filter { $0 != .walkLeft }
            pool += [.walkRight, .walkRight]
        }
        if cat.x >= maxX - Constants.walkStep {
            pool = pool.filter { $0 != .walkRight }
            pool += [.walkLeft, .walkLeft]
        }

        let action = pool.randomElement() ?? .idle
        switch action {
        case .idle:      performIdle()
        case .walkRight: performWalk(direction: .right)
        case .walkLeft:  performWalk(direction: .left)
        case .jump:      performJump()
        case .sleep:     performSleep()
        case .meow:      performMeow()
        case .pounce:    performPounce()
        }
    }

    // MARK: - External Triggers

    func triggerTypingJump() {
        guard jumpPhase == 0 else { return }
        performJump()
    }

    /// Called when the user taps the cat — reacts with meow or pounce
    func triggerTap() {
        guard jumpPhase == 0 else { return }
        let reaction: CatAction = [.meow, .pounce, .jump].randomElement() ?? .meow
        switch reaction {
        case .meow:   performMeow()
        case .pounce: performPounce()
        case .jump:   performJump()
        default:      performMeow()
        }
    }

    // MARK: - Actions

    private func performIdle() {
        setState(.idle)
    }

    private enum Direction { case left, right }

    private func performWalk(direction: Direction) {
        let newX: CGFloat
        switch direction {
        case .right:
            newX = min(cat.x + Constants.walkStep, maxX)
            cat.facingRight = true
        case .left:
            newX = max(cat.x - Constants.walkStep, minX)
            cat.facingRight = false
        }

        setState(.run)
        withAnimation(.linear(duration: 0.5)) { cat.x = newX }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            self?.setState(.idle)
        }
    }

    private func performJump() {
        jumpPhase = 1
        setState(.jump)

        withAnimation(.easeOut(duration: 0.25)) { cat.y = jumpY }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            guard let self else { return }
            withAnimation(.easeIn(duration: 0.25)) { self.cat.y = self.floorY }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.setState(.idle)
                self?.jumpPhase = 0
            }
        }
    }

    private func performSleep() {
        setState(.sleep)
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) { [weak self] in
            self?.setState(.idle)
        }
    }

    private func performMeow() {
        setState(.meow)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.setState(.idle)
        }
    }

    private func performPounce() {
        setState(.pounce)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.setState(.idle)
        }
    }

    // MARK: - Note Size

    func updateNoteSize(_ size: CGSize) {
        guard size.width > 0, size.height > 0, size != noteSize else { return }

        noteSize = size
        cat.x = min(max(cat.x, minX), maxX)
        cat.y = floorY
    }

    // MARK: - Helpers

    private var minX: CGFloat {
        Constants.noteHorizontalInset
    }

    private var maxX: CGFloat {
        max(minX, noteSize.width - Constants.noteHorizontalInset)
    }

    private var floorY: CGFloat {
        max(Constants.catHeight, noteSize.height - Constants.noteBottomControlHeight)
    }

    private var jumpY: CGFloat {
        max(Constants.catHeight, floorY - 60)
    }

    private func setState(_ state: CatState) {
        frameIndex = 0
        cat.state = state
    }

    deinit {
        behaviorTimer?.invalidate()
        spriteTimer?.invalidate()
    }
}
