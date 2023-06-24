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
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
            if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 11.0
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
            end
         end
     end
  end
