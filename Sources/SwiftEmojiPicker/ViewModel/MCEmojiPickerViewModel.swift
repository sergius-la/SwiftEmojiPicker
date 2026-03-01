// The MIT License (MIT)
//
// Copyright © 2022 Ivan Izyumkin
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation
import Combine

/// View model for `MCEmojiPickerView`.
final class MCEmojiPickerViewModel: ObservableObject {

    // MARK: - Published Properties

    /// The currently selected emoji.
    @Published var selectedEmoji: MCEmoji? = nil
    /// The index of the currently selected category in the category bar.
    @Published var selectedCategoryIndex: Int = 0

    // MARK: - Public Properties

    /// Whether the picker shows empty categories. Default false.
    var showEmptyEmojiCategories: Bool = false

    /// The filtered emoji categories (excluding empty ones if `showEmptyEmojiCategories` is false).
    var emojiCategories: [MCEmojiCategory] {
        allEmojiCategories.filter { showEmptyEmojiCategories || !$0.emojis.isEmpty }
    }

    // MARK: - Private Properties

    private var allEmojiCategories = [MCEmojiCategory]()

    // MARK: - Initializers

    init(unicodeManager: MCUnicodeManagerProtocol = MCUnicodeManager()) {
        allEmojiCategories = unicodeManager.getEmojisForCurrentIOSVersion()
    }

    // MARK: - Public Methods

    /// Returns the localized section name for the given section index.
    func sectionHeaderName(for section: Int) -> String {
        emojiCategories[section].categoryName
    }
}
