Pod::Spec.new do |s|

  s.name         = "Baiji-iOS"
  s.version      = "0.1.1"
  s.author       = 'Ctriposs'
  s.summary      = "A Generic client for iOS to access and consume baiji web services"

  s.platform     = :ios, "6.0"
  s.homepage     = "https://github.com/bjrara/baiji-ios/tree/develop"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.source       = { :git => "https://github.com/bjrara/baiji-ios.git",
                     :tag => "dev-0.1.1" }

  s.requires_arc = false
  s.source_files  = "BaijiCore/BaijiCore/**/*.{h,m}"
  s.exclude_files = "BaijiCore/BaijiCore/Supporting Files/*.{h,m}"

  s.dependency 'AFNetworking', '~> 2.0'

end