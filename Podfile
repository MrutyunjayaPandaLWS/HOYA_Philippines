# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Hoya Phillippines' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Hoya Phillippines
pod 'SDWebImage'
pod 'Alamofire', '~> 4.4'
pod 'IQKeyboardManagerSwift'
pod 'DPOTPView'
pod 'lottie-ios'
pod 'Toast-Swift', '~> 5.0.1'
pod "ImageSlideshow/Alamofire"
pod "ImageSlideshow/SDWebImage"
pod 'Firebase/CoreOnly'
pod 'FirebaseAnalytics'
pod 'FirebaseAuth'
pod 'FirebaseFirestore'
pod 'Firebase/Messaging'

end

post_install do |installer|
  # ios deployment version
  installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      xcconfig_relative_path = "Pods/Target Support Files/#{target.name}/#{target.name}.#{config.name}.xcconfig"
      file_path = Pathname.new(File.expand_path(xcconfig_relative_path))
      next unless File.file?(file_path)
      configuration = Xcodeproj::Config.new(file_path)
      next if configuration.attributes['LIBRARY_SEARCH_PATHS'].nil?
      configuration.attributes['LIBRARY_SEARCH_PATHS'].sub! 'DT_TOOLCHAIN_DIR', 'TOOLCHAIN_DIR'
      configuration.save_as(file_path)
     end
 end
end
