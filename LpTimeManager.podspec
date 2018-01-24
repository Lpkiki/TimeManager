
Pod::Spec.new do |s|

  s.name         = "LpTimeManager"
  s.version      = "1.0.1"
  s.summary      = "A short description of LpTimeManager."
  s.homepage     = "https://github.com/Lpkiki"
  s.license      = "MIT"
  s.author             = { "Lpkiki" => "545655797@qq.com" }
  s.source       = { :git => "https://github.com/Lpkiki/TimeManager.git", :tag => "1.0.1" }
  s.source_files  = "LpTimeManager/*.{h,m}"
  s.platform     =  :ios, "8.0"
  s.framework  = "Foundation"
  s.requires_arc = true

end
