Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.name         = "HMSDK"
  spec.version      = "1.0.0"
  spec.summary      = "Displays HappinessMeter surveys in Swift"
  spec.description  = "HMSDK is a module written in Swift allowing developer to easily integrate HappinessMeter surveys in their applications."
  spec.homepage     = "https://github.com/KalvadTech/hm-ios-sdk.git"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.license            = 'MIT'

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.author             = { "emilien" => "emilien@kalvad.com" }

  # ――― Deployment Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.swift_version = "5.0"
  spec.ios.deployment_target = "12.5"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.source       = { :git => "https://github.com/KalvadTech/hm-ios-sdk.git", :tag => "#{spec.version}" }
  spec.source_files  = "hm.ios.sdk/**/*.{h,m,swift}"

end