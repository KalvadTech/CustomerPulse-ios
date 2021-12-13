Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.name         = "CustomerPulse"
  spec.version      = "1.2.0"
  spec.summary      = "Displays CustomerPulse surveys in Swift"
  spec.description  = "CustomerPulse is a module written in Swift allowing developer to easily integrate CustomerPulse surveys in their applications."
  spec.homepage     = "https://github.com/KalvadTech/CustomerPulse-ios.git"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.license            = 'MIT'

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.author             = { "emilien" => "emilien@kalvad.com" }

  # ――― Deployment Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.swift_version = "5.0"
  spec.ios.deployment_target = "13.0"
  spec.license      = { :type => "MIT", :file => "sdk/CustomerPulseSDK/LICENSE" }

  spec.source       = { :git => "https://github.com/KalvadTech/CustomerPulse-ios.git", :tag => "#{spec.version}" }
  spec.source_files  = "sdk/CustomerPulseSDK/CustomerPulse/**/*.{h,m,swift}"

end
