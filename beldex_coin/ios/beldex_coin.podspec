#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint beldex_coin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'beldex_coin'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.exclude_files = ['Classes/beldex_api.cpp', 'Classes/BeldexWalletListenerWrapper.mm']
  s.public_header_files = 'Classes/**/*.h, Classes/*.h, External/ios/beldex/include/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.swift_version = '5.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS' => 'arm64 x86_64' }
  s.xcconfig = {
      'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/#{s.name}/Classes/*.h",
      'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17',
      'CLANG_CXX_LIBRARY' => 'libc++'
      }

  s.subspec 'Beldex' do |beldex|
    beldex.preserve_paths = 'External/ios/beldex/include/*.h'
    beldex.vendored_libraries = 'External/ios/beldex/lib/*.a'
    beldex.libraries = 'wallet_api'
    beldex.xcconfig = {}
  end

end
