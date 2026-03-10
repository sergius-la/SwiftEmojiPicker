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

/// The main SwiftUI emoji picker view.
///
/// Can be embedded directly or presented as a popover via the `.emojiPicker()` modifier.
///
/// ```swift
/// EmojiPickerView(selectedEmoji: $emoji)
/// ```
public struct EmojiPickerView: View {

    @StateObject private var viewModel = EmojiPickerViewModel()
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
            searchBar

            if viewModel.isSearching {
                searchContent
            } else {
                categoryContent
            }

            Divider()

            MCEmojiCategoryBar(
                categories: viewModel.emojiCategories.map(\.type),
                selectedIndex: $viewModel.selectedCategoryIndex,
                tintColor: selectedEmojiCategoryTintColor
            )
            .disabled(viewModel.isSearching)
            .opacity(viewModel.isSearching ? 0.3 : 1)
        }
        .background(Color.pickerBackground)
    }

    // MARK: - Subviews

    private var searchBar: some View {
        HStack(spacing: 6) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .font(.system(size: 14))
            TextField("Search", text: $viewModel.searchText)
                .textFieldStyle(.plain)
                .font(.system(size: 15))
                .submitLabel(.search)
            if viewModel.isSearching {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .font(.system(size: 14))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(Color.secondary.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 12)
        .padding(.top, 10)
        .padding(.bottom, 8)
    }

    @ViewBuilder
    private var searchContent: some View {
        let results = viewModel.searchResults
        if results.isEmpty {
            emptyState
        } else {
            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 8),
                    spacing: 0
                ) {
                    ForEach(results, id: \.searchKey) { emoji in
                        MCEmojiCellView(emoji: emoji, onSelect: handleSelection)
                    }
                }
                .padding(.horizontal, 8)
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 8) {
            Text("🔍")
                .font(.system(size: 40))
                .opacity(0.4)
            Text("No Results")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.secondary)
            Text("No emoji found for \"\(viewModel.searchText)\"")
                .font(.system(size: 13))
                .foregroundColor(.secondary.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(24)
    }

    private var categoryContent: some View {
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
            .onChange(of: viewModel.selectedCategoryIndex) { _, index in
                withAnimation {
                    proxy.scrollTo(index, anchor: .top)
                }
            }
        }
    }

    private func handleSelection(_ emoji: MCEmoji) {
        emoji.incrementUsageCount()
        selectedEmoji = emoji.string
        if isDismissAfterChoosing {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State var emoji = "😀"
    var body: some View {
        EmojiPickerView(selectedEmoji: $emoji)
    }
}
