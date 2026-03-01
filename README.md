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

#### Limitations
- Does not support two-part emojis. For example:
  - [x] Supported: 🤝🏻 🤝🏿
  - [ ] Not supported: 🫱🏿‍🫲🏻 🫱🏼‍🫲🏿

## Apps Using

<p float="left">
    <a href="https://apps.apple.com/app/id1500111859"><img src="https://github.com/user-attachments/assets/bc8b8235-b848-43ef-a143-fbce80c195d3" height="65"></a>
    <a href="https://apps.apple.com/app/id6450279059"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/270146ff-d3e7-4c46-97c2-2c796e6bd78d" height="65"></a>
    <a href="https://apps.apple.com/app/id6444636956"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/ecae445c-1683-422b-a0e7-8dbaeac2eb18" height="65"></a>
    <a href="https://github.com/Housemates-Mobile-App/housemates_mobileapp"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/05a8651a-c6fb-419e-9bdc-aa7d68b53af7" height="65"></a>
    <a href="https://github.com/RedEagle-dh/Quantify"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/bfa48cc4-c901-4235-8bfc-f5fb0fa22279" height="65"></a>
    <a href="https://github.com/norbusonam/routine"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/97a5b6ee-0cff-4839-894e-5c2d08daca3a" height="65"></a>
    <a href="https://github.com/bapaws/clock"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/7a615b02-43a2-4557-bfbd-7f40841ac508" height="65"></a>
    <a href="https://github.com/fn1y/Habitrack"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/0b634a00-257f-4e9d-93b0-8f8a2c0d335d" height="65"></a>
    <a href="https://github.com/honzachalupa/SymptomsTracker"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/836c08c8-7e60-4403-ad0a-fffaed926d15" height="65"></a>
    <a href="https://github.com/savoirfairelinux/jami-client-ios"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/b2e00327-7c13-407b-8c43-3c189504c3c5" height="65"></a>
    <a href="https://github.com/deltachat/deltachat-ios"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/6322e6cf-71d4-4f37-893c-44277b277517" height="65"></a>
    <a href="https://apps.apple.com/app/id6465843931"><img src="https://github.com/user-attachments/assets/efc4408b-f716-4773-b255-d267c2fb5bf7" height="65"></a>
    <a href="https://apps.apple.com/app/id6499061841"><img src="https://github.com/user-attachments/assets/13bab9ec-7c73-4a3b-bf52-c5c5d3ce14b0" height="65"></a>
    <a href="https://apps.apple.com/app/id6476229386"><img src="https://github.com/user-attachments/assets/fefc767e-5d07-4bb7-b83a-b190e2188ddb" height="65"></a>
</p>

If you use `SwiftEmojiPicker`, add your application via Pull Request.

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
