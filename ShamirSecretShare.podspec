Pod::Spec.new do |spec|
  spec.name                  = "ShamirSecretShare"
  spec.version               = "1.0.0"
  spec.summary               = "."
  spec.homepage              = "https://github.com/airgap-it/SecretShare.swift"
  spec.license               = { :type => "MIT", :file => "LICENSE" }
  spec.author                = { "krypt.co" => "https://krypt.co" }
  spec.ios.deployment_target = '13.0'
  spec.swift_version         = '5.0'
  spec.source                = { :git => "https://github.com/airgap-it/SecretShare.swift", :tag => "#{spec.version}" }
  spec.source_files          = "Sources/**/*.{swift}"
end

