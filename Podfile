platform :ios, '10.0'

nodeModules = './node_modules'

require_relative nodeModules + '/@react-native-community/cli-platform-ios/native_modules'

def add_flipper_pods!(versions = {})
  versions['Flipper'] ||= '~> 0.33.1'
  versions['DoubleConversion'] ||= '1.1.7'
  versions['Flipper-Folly'] ||= '~> 2.1'
  versions['Flipper-Glog'] ||= '0.3.6'
  versions['Flipper-PeerTalk'] ||= '~> 0.0.4'
  versions['Flipper-RSocket'] ||= '~> 1.0'

  pod 'FlipperKit', versions['Flipper'], :configuration => 'Debug'
  pod 'FlipperKit/FlipperKitLayoutPlugin', versions['Flipper'], :configuration => 'Debug'
  pod 'FlipperKit/SKIOSNetworkPlugin', versions['Flipper'], :configuration => 'Debug'
  pod 'FlipperKit/FlipperKitUserDefaultsPlugin', versions['Flipper'], :configuration => 'Debug'
  pod 'FlipperKit/FlipperKitReactPlugin', versions['Flipper'], :configuration => 'Debug'

  # List all transitive dependencies for FlipperKit pods
  # to avoid them being linked in Release builds
  pod 'Flipper', versions['Flipper'], :configuration => 'Debug'
  pod 'Flipper-DoubleConversion', versions['DoubleConversion'], :configuration => 'Debug'
  pod 'Flipper-Folly', versions['Flipper-Folly'], :configuration => 'Debug'
  pod 'Flipper-Glog', versions['Flipper-Glog'], :configuration => 'Debug'
  pod 'Flipper-PeerTalk', versions['Flipper-PeerTalk'], :configuration => 'Debug'
  pod 'Flipper-RSocket', versions['Flipper-RSocket'], :configuration => 'Debug'
  pod 'FlipperKit/Core', versions['Flipper'], :configuration => 'Debug'
  pod 'FlipperKit/CppBridge', versions['Flipper'], :configuration => 'Debug'
  pod 'FlipperKit/FBCxxFollyDynamicConvert', versions['Flipper'], :configuration => 'Debug'
  pod 'FlipperKit/FBDefines', versions['Flipper'], :configuration => 'Debug'
  pod 'FlipperKit/FKPortForwarding', versions['Flipper'], :configuration => 'Debug'
  pod 'FlipperKit/FlipperKitHighlightOverlay', versions['Flipper'], :configuration => 'Debug'
  pod 'FlipperKit/FlipperKitLayoutTextSearchable', versions['Flipper'], :configuration => 'Debug'
  pod 'FlipperKit/FlipperKitNetworkPlugin', versions['Flipper'], :configuration => 'Debug'
end

# Post Install processing for Flipper
def flipper_post_install(installer)
  installer.pods_project.targets.each do |target|
    if target.name == 'YogaKit'
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.1'
      end
    end
  end
end

target 'vayne' do
  # Pods for vayne
  pod 'FBLazyVector', :path => nodeModules + '/react-native/Libraries/FBLazyVector'
  pod 'FBReactNativeSpec', :path => nodeModules + '/react-native/Libraries/FBReactNativeSpec'
  pod 'RCTRequired', :path => nodeModules + '/react-native/Libraries/RCTRequired'
  pod 'RCTTypeSafety', :path => nodeModules + '/react-native/Libraries/TypeSafety'
  pod 'React', :path => nodeModules + '/react-native/'
  pod 'React-Core', :path => nodeModules + '/react-native/'
  pod 'React-CoreModules', :path => nodeModules + '/react-native/React/CoreModules'
  pod 'React-Core/DevSupport', :path => nodeModules + '/react-native/'
  pod 'React-RCTActionSheet', :path => nodeModules + '/react-native/Libraries/ActionSheetIOS'
  pod 'React-RCTAnimation', :path => nodeModules + '/react-native/Libraries/NativeAnimation'
  pod 'React-RCTBlob', :path => nodeModules + '/react-native/Libraries/Blob'
  pod 'React-RCTImage', :path => nodeModules + '/react-native/Libraries/Image'
  pod 'React-RCTLinking', :path => nodeModules + '/react-native/Libraries/LinkingIOS'
  pod 'React-RCTNetwork', :path => nodeModules + '/react-native/Libraries/Network'
  pod 'React-RCTSettings', :path => nodeModules + '/react-native/Libraries/Settings'
  pod 'React-RCTText', :path => nodeModules + '/react-native/Libraries/Text'
  pod 'React-RCTVibration', :path => nodeModules + '/react-native/Libraries/Vibration'
  pod 'React-Core/RCTWebSocket', :path => nodeModules + '/react-native/'

  pod 'React-cxxreact', :path => nodeModules + '/react-native/ReactCommon/cxxreact'
  pod 'React-jsi', :path => nodeModules + '/react-native/ReactCommon/jsi'
  pod 'React-jsiexecutor', :path => nodeModules + '/react-native/ReactCommon/jsiexecutor'
  pod 'React-jsinspector', :path => nodeModules + '/react-native/ReactCommon/jsinspector'
  pod 'ReactCommon/callinvoker', :path => nodeModules + '/react-native/ReactCommon'
  pod 'ReactCommon/turbomodule/core', :path => nodeModules + '/react-native/ReactCommon'
  pod 'Yoga', :path => nodeModules + '/react-native/ReactCommon/yoga', :modular_headers => true

  pod 'DoubleConversion', :podspec => nodeModules + '/react-native/third-party-podspecs/DoubleConversion.podspec'
  pod 'glog', :podspec => nodeModules + '/react-native/third-party-podspecs/glog.podspec'
  pod 'Folly', :podspec => nodeModules + '/react-native/third-party-podspecs/Folly.podspec'
  pod 'SSZipArchive', '~> 2.2.3'

  use_native_modules!

  # Enables Flipper.
  #
  # Note that if you have use_frameworks! enabled, Flipper will not work and
  # you should disable these next few lines.
  add_flipper_pods!
  post_install do |installer|
    flipper_post_install(installer)
  end
end
