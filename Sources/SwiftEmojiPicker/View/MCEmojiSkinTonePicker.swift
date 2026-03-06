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

/// A popover that presents all available skin tone variants for an emoji.
struct MCEmojiSkinTonePicker: View {
    let emoji: MCEmoji
    let onSelect: (Int) -> Void

    var body: some View {
        HStack(spacing: 0) {
            ForEach(MCEmojiSkinTone.allCases, id: \.rawValue) { skinTone in
                Button {
                    onSelect(skinTone.rawValue)
                } label: {
                    Text(emojiString(for: skinTone))
                        .font(.system(size: 29))
                        .padding(10)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(Color.previewBackground)
    }

    private func emojiString(for skinTone: MCEmojiSkinTone) -> String {
        guard skinTone != .none, let skinKey = skinTone.skinKey else {
            return emoji.emojiKeys.emoji()
        }
        var keys = emoji.emojiKeys
        keys.insert(skinKey, at: 1)
        return keys.emoji()
    }
}
