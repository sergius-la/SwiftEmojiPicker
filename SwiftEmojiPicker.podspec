Pod::Spec.new do |s|
  s.name = 'SwiftEmojiPicker'
  s.version = '2.1.0'
  s.license = 'MIT'
  s.summary = 'SwiftUI emoji picker for iOS and macOS'
  s.homepage = 'https://github.com/sergius-la/SwiftEmojiPicker'
  s.authors = { 'Sergey Likhanov' => 'sergius.la@gmail.com' }

  s.source = { :git => 'https://github.com/sergius-la/SwiftEmojiPicker.git', :tag => s.version.to_s }
  s.source_files = 'Sources/SwiftEmojiPicker/**/*.swift'
  s.resource_bundle = { "SwiftEmojiPicker" => [
    "Sources/SwiftEmojiPicker/Resources/EmojiDefinitions/*.json",
    "Sources/SwiftEmojiPicker/Resources/Localization/**/SwiftEmojiPickerLocalizable.strings"
  ] }
  s.swift_version = '5.9'
  s.ios.deployment_target = '26.0'
  s.osx.deployment_target = '26.0'
end
