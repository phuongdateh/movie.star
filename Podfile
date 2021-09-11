# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'core' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for core
  pod 'RxSwift'
  pod 'RxCocoa'
  
  # Rx Extensions
  pod 'RxDataSources'
  
  # Logging
  pod 'CocoaLumberjack/Swift'
  
  # UI
  pod 'Hero'
  
  # Network
  pod 'Moya/RxSwift'


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
    
    # Enable tracing resources
    installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
        target.build_configurations.each do |config|
          if config.name == 'Debug'
            config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
          end
        end
      end
    end
end
