Pod::Spec.new do |s|
  s.name         = "SunHorizontalScrollView"
  s.version      = "0.0.5"
  s.summary      = "An easy-to-use UIView subclass that implements a scrolling effect UIView with images"
  s.homepage     = "https://github.com/pts011080/SunHorizontalScrollView"
  s.license      = "MIT"
  s.author       = { "孙博弘" => "sunbohong@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/pts011080/SunHorizontalScrollView.git", :tag => s.version.to_s }
  s.source_files  = "Classes", "SunHorizontalScrollView/SunHorizontalScrollView/Classes/*.{h,m}"
  s.requires_arc = true
  s.dependency "AFNetworking", '~> 1.0'
end
