Pod::Spec.new do |s|
  s.name         = "CalendarManager"
  s.version      = "0.0.1"
  s.summary      = "Native Shoutem extension used for access to Firebase SDK"

  s.homepage     = "http://www.shoutem.com"
  s.license      = { :type => "BSD" }
  s.author       = { "Vladimir Vdović" => "vlad@definitely-not-vlad.com" }

  s.source       = { :git => "https://github.com/shoutem/react-native-calendar-manager.git", :tag => "1.0" }

  s.source_files = 'CalendarManager/CalendarManager.{h,m}'
end
