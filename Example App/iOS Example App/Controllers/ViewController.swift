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
import SwiftEmojiPicker

struct ContentView: View {
    @State private var selectedEmoji = "🙋🏻‍♂️"
    @State private var showPicker = false
    @State private var tintColor: Color = .blue
    @State private var dismissAfterChoosing = true

    var body: some View {
        NavigationView {
            List {
                // MARK: Picker trigger
                Section {
                    HStack {
                        Spacer()
                        Button {
                            showPicker = true
                        } label: {
                            Text(selectedEmoji)
                                .font(.system(size: 72))
                                .frame(width: 100, height: 100)
                                .background(Color(.systemGray5))
                                .cornerRadius(16)
                        }
                        .buttonStyle(.plain)
                        .emojiPicker(
                            isPresented: $showPicker,
                            selectedEmoji: $selectedEmoji,
                            selectedEmojiCategoryTintColor: tintColor,
                            isDismissAfterChoosing: dismissAfterChoosing
                        )
                        Spacer()
                    }
                    .padding(.vertical, 8)
                } header: {
                    Text("Tap to pick an emoji")
                } footer: {
                    Text("Selected: \(selectedEmoji)")
                }

                // MARK: Options
                Section("Options") {
                    Toggle("Dismiss after choosing", isOn: $dismissAfterChoosing)

                    HStack {
                        Text("Tint color")
                        Spacer()
                        ColorPicker("", selection: $tintColor)
                            .labelsHidden()
                    }
                }

                // MARK: Embedded picker
                Section("Embedded (no popover)") {
                    EmojiPickerView(
                        selectedEmoji: $selectedEmoji,
                        selectedEmojiCategoryTintColor: tintColor,
                        isDismissAfterChoosing: false
                    )
                    .frame(height: 320)
                }
            }
            .navigationTitle("SwiftEmojiPicker")
            .navigationViewStyle(.stack)
        }
    }
}

#Preview {
    ContentView()
}
