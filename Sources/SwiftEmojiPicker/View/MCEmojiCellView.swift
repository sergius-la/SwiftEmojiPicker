// The MIT License (MIT)
//
// Copyright © 2026 Sergey Likhanov
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

import SwiftUI

/// A single emoji cell supporting tap to select and long-press for preview or skin tone picker.
struct MCEmojiCellView: View {
    let emoji: MCEmoji
    let onSelect: (MCEmoji) -> Void

    /// Tracks the displayed emoji string so it updates after skin tone selection.
    @State private var emojiString: String
    /// Controls which long-press overlay to show.
    @State private var longPressAction: LongPressAction? = nil

    init(emoji: MCEmoji, onSelect: @escaping (MCEmoji) -> Void) {
        self.emoji = emoji
        self.onSelect = onSelect
        _emojiString = State(initialValue: emoji.string)
    }

    var body: some View {
        Text(emojiString)
            .font(.system(size: 29))
            .frame(maxWidth: .infinity, minHeight: 40)
            .contentShape(Rectangle())
            .onTapGesture {
                onSelect(emoji)
            }
            .onLongPressGesture(minimumDuration: 0.3) {
                longPressAction = emoji.isSkinToneSupport ? .skinTone : .preview
            }
            .popover(item: $longPressAction) { action in
                switch action {
                case .preview:
                    MCEmojiPreviewPopup(emoji: emoji)
                case .skinTone:
                    MCEmojiSkinTonePicker(emoji: emoji) { skinToneRawValue in
                        emoji.set(skinToneRawValue: skinToneRawValue)
                        emojiString = emoji.string
                        longPressAction = nil
                        onSelect(emoji)
                    }
                }
            }
    }
}

// MARK: - LongPressAction

private extension MCEmojiCellView {
    enum LongPressAction: String, Identifiable {
        case preview
        case skinTone
        var id: String { rawValue }
    }
}
