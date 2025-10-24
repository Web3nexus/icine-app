# This file is used by CocoaPods to integrate Flutter dependencies.

require 'fileutils'
require 'json'

def flutter_root
  generated_xcode_build_settings_path = File.expand_path(File.join('..', 'Generated.xcconfig'), __FILE__)
  unless File.exist?(generated_xcode_build_settings_path)
    raise "#{generated_xcode_build_settings_path} must exist. If you're running pod install manually, make sure flutter pub get is executed first"
  end

  File.foreach(generated_xcode_build_settings_path) do |line|
    matches = line.match(/FLUTTER_ROOT=(.*)/)
    return matches[1].strip if matches
  end
  raise "FLUTTER_ROOT not found in #{generated_xcode_build_settings_path}"
end

def flutter_application_path
  File.expand_path(File.join('..', '..'), __FILE__)
end

def flutter_ios_engine_dir
  File.expand_path(File.join(flutter_root, 'bin', 'cache', 'artifacts', 'engine', 'ios'))
end

def flutter_podhelper(flutter_application_path)
  engine_dir = flutter_ios_engine_dir
  pod 'Flutter', :path => engine_dir
end

def flutter_ios_podfile_setup
  system('flutter', 'pub', 'get')
end

def flutter_install_all_ios_pods
  flutter_application_path = File.expand_path(File.join('..', '..'), __FILE__)
  flutter_podhelper(flutter_application_path)
end

def flutter_additional_ios_build_settings(target)
  target.build_configurations.each do |config|
    config.build_settings['ENABLE_BITCODE'] = 'NO'
  end
end

