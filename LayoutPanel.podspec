Pod::Spec.new do |s|
  s.name         = "LayoutPanel"
  s.version      = "0.0.2"
  s.summary      = "This is a autolayout panel, you can use it to place your elemets on the it, then the panel will layout the elements for you. easy to use!"
  s.homepage     = "https://github.com/Nekle/LayoutPanel"
	s.license      = { :type => "MIT", :file => "./LayoutPanel/LICENSE.txt" }
  s.author       = { "Fuxian Ding" => "nekleding@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/Nekle/LayoutPanel.git", :tag => "0.0.2" }
  s.source_files = "LayoutPanel/Panel/*.{h,m}"
end
