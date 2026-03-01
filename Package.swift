// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "SwiftEmojiPicker",
    defaultLocalization: "en",
    platforms: [.iOS("14.0"), .macOS("11.0")],
    products: [
        .executable(name: "SwiftEmojiPickerJSON", targets: ["SwiftEmojiPickerJSON"]),
        .library(name: "SwiftEmojiPicker", targets: ["SwiftEmojiPicker"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftEmojiPicker",
            dependencies: [],
            path: "Sources/SwiftEmojiPicker",
            resources: [
                .copy("Resources/EmojiDefinitions/travellingAndPlaces.json"),
                .copy("Resources/EmojiDefinitions/symbols.json"),
                .copy("Resources/EmojiDefinitions/items.json"),
                .copy("Resources/EmojiDefinitions/foodAndDrinks.json"),
                .copy("Resources/EmojiDefinitions/flags.json"),
                .copy("Resources/EmojiDefinitions/emotionsAndPeople.json"),
                .copy("Resources/EmojiDefinitions/animalsAndNature.json"),
                .copy("Resources/EmojiDefinitions/activities.json"),
            ]
        ),
        .executableTarget(name: "SwiftEmojiPickerJSON", dependencies: ["SwiftEmojiPicker"])
    ],
    swiftLanguageVersions: [.v4_2]
)
