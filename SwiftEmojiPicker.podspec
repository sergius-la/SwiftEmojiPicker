Pod::Spec.new do |s|
  s.name = 'SwiftEmojiPicker'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'SwiftUI emoji picker for iOS and macOS'
  s.homepage = 'https://github.com/izyumkin/SwiftEmojiPicker'
  s.authors = { 'Ivan Izyumkin' => 'izzyumkin@gmail.com' }

  s.source = { :git => 'https://github.com/izyumkin/SwiftEmojiPicker.git', :tag => s.version.to_s }
  s.source_files = 'Sources/SwiftEmojiPicker/**/*.swift'
  s.resource_bundle = { "SwiftEmojiPicker" => ["Sources/SwiftEmojiPicker/**/*.lproj/*.strings"] }
  s.swift_version = '5.9'
  s.ios.deployment_target = '14.0'
  s.osx.deployment_target = '11.0'
end
