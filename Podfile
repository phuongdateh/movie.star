# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'core' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Logging
  pod 'CocoaLumberjack/Swift'

  # UI
  pod 'Hero'

  # Network
  pod 'Moya'

  # Autolayout
  pod 'SnapKit'
  
  # Loading
  pod 'NVActivityIndicatorView'

  # Cache media file while play media using AVPlayerr.
  pod 'VIMediaCache'

  # Youtube https://github.com/0xced/XCDYouTubeKit/pull/526#issuecomment-868208997
  pod 'XCDYouTubeKit', :git => 'https://github.com/dpwilhelmsen/XCDYouTubeKit', :branch => 'hotfix/fix-get-video-info-error'
  
#  pod 'MBVideoPlayer', :git => 'https://github.com/mwaqasbhati/MBVideoPlayer.git'
  
  pod 'SDWebImage'
  pod 'FSPagerView'

  #Firebase
  pod 'Firebase/Analytics'
  pod 'Firebase/RemoteConfig'
  pod 'Firebase/Auth'

  pod 'Cosmos'
  
  pod 'DisplaySwitcher'
  pod 'MJRefresh'
  pod 'RealmSwift'
  pod 'SkyFloatingLabelTextField', '~> 3.0'
  pod 'IQKeyboardManagerSwift', '6.3.0'

end

post_install do |installer|
    # Cocoapods optimization, always clean project after pod updating
    Dir.glob(installer.sandbox.target_support_files_root + "Pods-*/*.sh").each do |script|
        flag_name = File.basename(script, ".sh") + "-Installation-Flag"
        folder = "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
        file = File.join(folder, flag_name)
        content = File.read(script)
        content.gsub!(/set -e/, "set -e\nKG_FILE=\"#{file}\"\nif [ -f \"$KG_FILE\" ]; then exit 0; fi\nmkdir -p \"#{folder}\"\ntouch \"$KG_FILE\"")
        File.write(script, content)
    end
end
