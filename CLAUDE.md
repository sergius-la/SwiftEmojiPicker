# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
# Build the library (macOS)
swift build --triple arm64-apple-macosx11.0

# Build the library (iOS via CLI is limited; use Xcode for iOS)
swift build

# Regenerate JSON emoji definition files after editing MCEmojiDefinitions.swift
swift run SwiftEmojiPickerJSON
```

There are no automated tests in this package.

## Architecture

This is **SwiftEmojiPicker**, a pure SwiftUI emoji picker library targeting iOS 14+ and macOS 11+. It is a fork of MCEmojiPicker, rewritten with no UIKit dependency.

### Two SPM targets

- **`SwiftEmojiPicker`** — the library consumers import
- **`SwiftEmojiPickerJSON`** — an executable that regenerates the JSON emoji data files in `Sources/SwiftEmojiPicker/Resources/EmojiDefinitions/`. Run this whenever `MCEmojiDefinitions.swift` is updated.

### Data flow

1. `MCEmojiDefinitions.swift` (in `SwiftEmojiPickerJSON`) is the source of truth for all emoji unicode data — edit here, then run `swift run SwiftEmojiPickerJSON` to regenerate the JSON files.
2. At runtime, `MCUnicodeManager` loads JSON files from the bundle via `Bundle.module`, filters out emojis newer than the device's OS supports, and prepends a "frequently used" category built from `UserDefaults` usage history.
3. `MCEmojiPickerViewModel` (ObservableObject) holds the filtered `[MCEmojiCategory]` and `selectedCategoryIndex`.
4. `EmojiPickerView` renders a `LazyVGrid` per category inside a `ScrollViewReader`, with sticky section headers. Selecting an emoji calls `MCEmoji.incrementUsageCount()` (writes to UserDefaults) then updates the `selectedEmoji: Binding<String>`.

### Skin tone persistence

`MCEmoji` is a value type. Skin tone and usage timestamps are stored in `UserDefaults` keyed by the base emoji unicode sequence. `emoji.string` always reads the current skin tone from UserDefaults on access.

### Public API surface

```swift
// Modifier — sheet popover anchored to any view
someView.emojiPicker(isPresented: $show, selectedEmoji: $emoji)

// Direct embed
EmojiPickerView(selectedEmoji: $emoji)

// Optional parameters (both API surfaces)
selectedEmojiCategoryTintColor: Color  // default .blue
isDismissAfterChoosing: Bool           // default true
```

### Localization

Category names and search keys are localized via `MCEmojiPickerLocalizable.strings` (in `Sources/SwiftEmojiPicker/Resources/Localization/`). `NSLocalizedString` uses `bundle: .module` and `tableName: "MCEmojiPickerLocalizable"`.

### OS version emoji filtering

`MCUnicodeManager` uses `ProcessInfo.processInfo.operatingSystemVersion` (not UIDevice) so it works on both iOS and macOS. On macOS it always returns emoji version 15.0 (full set). On iOS it maps major.minor OS version to emoji spec version.
