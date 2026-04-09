# StickyCat MVP

A macOS SwiftUI sticky note app with an animated virtual cat.

---

## Project Setup

1. **Create a new Xcode project**
   - macOS → App
   - Interface: SwiftUI
   - Language: Swift
   - Product Name: `StickyCat`

2. **Replace generated files** with the files in this folder, matching the directory structure:

```
StickyCat/
├── StickyCatApp.swift
├── ContentView.swift
├── Models/
│   ├── CatBreed.swift
│   ├── CatState.swift
│   └── CatModel.swift
├── ViewModels/
│   └── CatViewModel.swift
├── Views/
│   ├── StickyNoteView.swift
│   ├── CatView.swift
│   ├── BallView.swift
│   └── BreedPickerView.swift
└── Utilities/
    └── Constants.swift
```

3. **Create the Groups in Xcode** — right-click the project navigator → New Group — to match the structure above. Drag each file into its group.

4. **Run** on macOS (not iOS simulator). You should see the sticky note with an animated cat immediately.

---

## Swapping in Real Sprites

When you have real assets, open `CatView.swift` and replace the emoji ZStack with:

```swift
Image("\(cat.breed.rawValue)_\(cat.state.assetSuffix)")
    .resizable()
    .frame(width: Constants.catWidth, height: Constants.catHeight)
```

Asset names expected in `Assets.xcassets`:
- `calico_sit`, `calico_walk1`, `calico_walk2`, `calico_jump`, `calico_play`
- `ragdoll_sit`, `ragdoll_walk1`, `ragdoll_walk2`, `ragdoll_jump`, `ragdoll_play`
- `ball`

---

## Behavior Loop

The cat picks a random action every 2.5–4 seconds:
- **sit** — stays still
- **walkRight / walkLeft** — moves + alternates walk frames
- **jump** — two-phase (up then down)
- **play** — walks toward the ball, switches to play pose

Direction is tracked via `facingRight` — the emoji/sprite is flipped automatically.

---

## Tuning

All sizes, speeds, and positions live in `Utilities/Constants.swift`. No magic numbers elsewhere.

