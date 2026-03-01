# SwiftEmojiPicker

[![Version](https://img.shields.io/cocoapods/v/SwiftEmojiPicker.svg?style=flat)](https://cocoapods.org/pods/SwiftEmojiPicker)
[![License](https://img.shields.io/cocoapods/l/SwiftEmojiPicker.svg?style=flat)](https://cocoapods.org/pods/SwiftEmojiPicker)
[![Platform](https://img.shields.io/cocoapods/p/SwiftEmojiPicker.svg?style=flat)](https://cocoapods.org/pods/SwiftEmojiPicker)

<p float="left">
<img src="https://user-images.githubusercontent.com/50948518/216799717-25b3e4ed-b4c5-4166-91a2-72374b0564f9.gif" width="280">
</p>

## About

**A native SwiftUI emoji picker for iOS and macOS — macOS-style popover, zero UIKit dependencies.**

Works on **iOS 14+** and **macOS 11+** with a single `.emojiPicker()` modifier.

Fork of [MCEmojiPicker](https://github.com/izyumkin/MCEmojiPicker), rewritten from the ground up in pure SwiftUI to resolve the lack of macOS support.

#### Limitations
- Does not support two-part emojis. For example:
  - [x] Supported: 🤝🏻 🤝🏿
  - [ ] Not supported: 🫱🏿‍🫲🏻 🫱🏼‍🫲🏿

## Navigation

- [Requirements](#requirements)
- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
    - [Manually](#manually)
- [Quick Start](#quick-start)
- [Usage](#usage)
    - [Tint color](#tint-color)
    - [Dismiss after choosing](#dismiss-after-choosing)
    - [Embed directly](#embed-directly)
- [Localization](#localization)
- [TODO](#todo)

## Requirements

- Swift 5.9+
- iOS 14.0+
- macOS 11.0+

## Installation

### Swift Package Manager

In Xcode go to `File → Add Package Dependencies` and enter:

```
https://github.com/izyumkin/SwiftEmojiPicker
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/izyumkin/SwiftEmojiPicker", from: "1.0.0")
]
```

### CocoaPods

```ruby
pod 'SwiftEmojiPicker'
```

### Manually

Copy the `Sources/SwiftEmojiPicker` folder into your Xcode project. Enable `Copy items if needed` and `Create groups`.

## Quick Start

```swift
import SwiftEmojiPicker

struct ContentView: View {
    @State private var selectedEmoji = "😀"
    @State private var showPicker = false

    var body: some View {
        Button(selectedEmoji) {
            showPicker = true
        }
        .emojiPicker(isPresented: $showPicker, selectedEmoji: $selectedEmoji)
    }
}
```

## Usage

### Tint color

Color for the active category icon. Default is `.blue`.

```swift
.emojiPicker(
    isPresented: $showPicker,
    selectedEmoji: $selectedEmoji,
    selectedEmojiCategoryTintColor: .pink
)
```

### Dismiss after choosing

Whether the picker closes after an emoji is selected. Default is `true`.

```swift
.emojiPicker(
    isPresented: $showPicker,
    selectedEmoji: $selectedEmoji,
    isDismissAfterChoosing: false
)
```

### Embed directly

`EmojiPickerView` can be placed anywhere in your view hierarchy without a popover:

```swift
EmojiPickerView(selectedEmoji: $selectedEmoji)
```

## Localization

🌍 This library supports all existing localizations.

## TODO

- [x] Core emoji selection
- [x] Dark mode
- [x] Category tab bar with SF Symbols
- [x] Automatic filtering of emojis by OS version
- [x] Skin tone picker
- [x] Frequently used
- [x] iOS 14+ and macOS 11+ via pure SwiftUI
- [ ] Search bar
