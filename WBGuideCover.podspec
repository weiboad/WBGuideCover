#
# Be sure to run `pod lib lint WBGuideCover.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WBGuideCover'
  s.version          = '0.1.0'
  s.summary          = '对于项目新功能的使用通常会给予用户蒙版引导提示，demo方便我们的开发使用'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/huipengo/WBGuideCover'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '彭辉' => 'penghui_only@163.com' }
  s.source           = { :git => 'https://github.com/huipengo/WBGuideCover.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.frameworks = "UIKit", "Foundation"

  s.source_files = 'Pod/Classes/*.{h,m}'
  s.resource = 'Pod/Classes/*.bundle'
  
  # s.resource_bundles = {
  #   'WBGuideCover' => ['WBGuideCover/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
