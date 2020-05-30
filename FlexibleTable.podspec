
Pod::Spec.new do |s|
  s.name             = 'FlexibleTable'
  s.version          = '0.1.0'
  s.summary          = 'A stretchy, sticky table header view.'

  s.description      = <<-DESC
The FlexibleTable is a stretchable header view for UITableView. Can be configured witha custom view and initial-minimum height.
                       DESC

  s.homepage         = 'https://github.com/demirciy/FlexibleTable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yusuf Demirci' => 'demirciy94@gmail.com' }
  s.source           = { :git => 'https://github.com/demirciy/FlexibleTable.git', :tag => s.version.to_s }
  s.social_media_url = 'https://yusufdemirci.dev'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'FlexibleTable/Classes/**/*'
end
