Pod::Spec.new do |s|
  s.name         = "SPMediaKeys"
  s.version      = "0.0.1"
  s.summary      = "A global event tap for the media keys."
  s.homepage     = "http://overooped.com/post/2593597587/mediakeys"
  s.license      = "MIT"
  s.author       = { "Nevyn Bengtsson" => "joachimb@gmail.com" }

  s.platform     = :osx, '10.9'
  s.source       = { :git => "https://github.com/neonichu/SPMediaKeyTap.git",
                     :tag => s.version }

  s.source_files  = "SPMediaKeyTap{.h,.m}", "SPMediaKeys.swift"
  s.frameworks    = "AppKit"
  s.requires_arc  = false
end
