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

import SwiftUI

/// The main SwiftUI emoji picker view.
///
/// Can be embedded directly or presented as a popover via the `.emojiPicker()` modifier.
///
/// ```swift
/// EmojiPickerView(selectedEmoji: $emoji)
/// ```
public struct EmojiPickerView: View {

    @StateObject private var viewModel = MCEmojiPickerViewModel()
    @Binding public var selectedEmoji: String

    public var selectedEmojiCategoryTintColor: Color
    public var isDismissAfterChoosing: Bool

    @Environment(\.presentationMode) private var presentationMode

    public init(
        selectedEmoji: Binding<String>,
        selectedEmojiCategoryTintColor: Color = .blue,
        isDismissAfterChoosing: Bool = true
    ) {
        _selectedEmoji = selectedEmoji
        self.selectedEmojiCategoryTintColor = selectedEmojiCategoryTintColor
        self.isDismissAfterChoosing = isDismissAfterChoosing
    }

    public var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
                        ForEach(viewModel.emojiCategories.indices, id: \.self) { s in
                            Section {
                                LazyVGrid(
                                    columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 8),
                                    spacing: 0
                                ) {
                                    ForEach(viewModel.emojiCategories[s].emojis, id: \.searchKey) { emoji in
                                        MCEmojiCellView(emoji: emoji, onSelect: handleSelection)
                                    }
                                }
                                .padding(.horizontal, 8)
                            } header: {
                                Text(viewModel.sectionHeaderName(for: s))
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.secondary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 16)
                                    .padding(.top, 8)
                                    .padding(.bottom, 4)
                                    .background(Color.pickerBackground)
                            }
                            .id(s)
                        }
                    }
                }
                .onChange(of: viewModel.selectedCategoryIndex) { index in
                    withAnimation {
                        proxy.scrollTo(index, anchor: .top)
                    }
                }
            }

            Divider()

            MCEmojiCategoryBar(
                categories: viewModel.emojiCategories.map(\.type),
                selectedIndex: $viewModel.selectedCategoryIndex,
                tintColor: selectedEmojiCategoryTintColor
            )
        }
        .background(Color.pickerBackground)
        .frame(width: 340, height: 380)
    }

    private func handleSelection(_ emoji: MCEmoji) {
        emoji.incrementUsageCount()
        selectedEmoji = emoji.string
        if isDismissAfterChoosing {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
