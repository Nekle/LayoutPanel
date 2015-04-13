Pod::Spec.new do |s|
  s.name         = "LayoutPanel"
  s.version      = "0.0.1"
  s.summary      = "这是一个元素排布器, 你可以很方便的使用排布器构造出统一风格的排布."
  s.homepage     = "https://github.com/Nekle/LayoutPanel"
	s.license      = { :type => "MIT", :file => "./LayoutPanel/LICENSE.txt" }
  s.author       = { "Fuxian Ding" => "nekleding@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/Nekle/LayoutPanel.git", :tag => "0.0.1" }
  s.source_files = "LayoutPanel/Panel/*.{h,m}"
end
