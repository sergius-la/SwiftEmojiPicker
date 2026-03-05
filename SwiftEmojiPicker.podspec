Pod::Spec.new do |s|
  s.name = 'SwiftEmojiPicker'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'SwiftUI emoji picker for iOS and macOS'
  s.homepage = 'https://github.com/sergius-la/SwiftEmojiPicker'
  s.authors = { 'Sergey Likhanov' => 'sergius.la@gmail.com' }

  s.source = { :git => 'https://github.com/sergius-la/SwiftEmojiPicker.git', :tag => s.version.to_s }
  s.source_files = 'Sources/SwiftEmojiPicker/**/*.swift'
  s.resource_bundle = { "SwiftEmojiPicker" => [
    "Sources/SwiftEmojiPicker/Resources/EmojiDefinitions/*.json",
    "Sources/SwiftEmojiPicker/Resources/Localization/**/*.strings"
  ] }
  s.swift_version = '5.9'
  s.ios.deployment_target = '14.0'
  s.osx.deployment_target = '11.0'
end
