Pod::Spec.new do |s|
  s.name         = "KMZDrawView"
  s.version      = "0.0.1"
  s.summary      = "KMZDrawView is a simple drawing view for iOS."
  s.homepage     = "https://github.com/kenmaz/KMZDrawView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Kentaro Matsumae" => "kentaro.matsumae@gmail.com" }
  s.platform     = :ios, '6.0'
  s.requires_arc = true
  s.source       = { :git => "https://github.com/kenmaz/KMZDrawView.git", :tag => "0.0.1" }
  s.source_files = "KMZDrawView"
end
