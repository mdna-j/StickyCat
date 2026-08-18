# StickyCat 🐱

A macOS sticky note app with an animated virtual cat built in SwiftUI.

## Stack

- macOS + SwiftUI
- Swift

## Features

**Note**
- Editable sticky note with persistent text across launches
- 5 pastel background color options
- Clear note button with confirmation dialog

**Cat**
- 6 breeds: Black, Brown, Orange Tabby, Siamese, Tuxedo, White
- 7 animated states per breed: idle, run, sit, jump, sleep, meow, pounce
- Spritesheet animation system with per-state frame counts
- Each breed has a unique personality and weighted behavior pool
- Cat jumps occasionally when you type
- Tap the cat to trigger a reaction
- Cat bounces off edges and stays within bounds
- Dynamic dock icon that changes to match the selected breed

**UI**
- Breed selector dropdown
- Pastel note color picker
- Hidden title bar for a clean floating note look
- All settings persist across launches
