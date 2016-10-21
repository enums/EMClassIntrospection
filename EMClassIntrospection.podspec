Pod::Spec.new do |spec|
  spec.name         = 'EMClassIntrospection'
  spec.version      = '1.0'
  spec.license      = { :type => "MIT" }
  spec.summary      = 'A tool for runtime which can help us to explore some interesting things.'
  spec.homepage     = 'https://github.com/trmbhs/EMClassIntrospection'
  spec.author       = { "Enum" => "trmbhs@icloud.com" }
  spec.ios.deployment_target = "10.0"
  spec.source       = { :git => 'https://github.com/trmbhs/EMClassIntrospection.git', :tag => spec.version }
  spec.source_files = 'EMClassIntrospection/*'
  spec.requires_arc = true
end