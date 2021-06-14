#
# Be sure to run `pod lib lint SAMineModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SAMineModule'
  s.version          = '0.1.0'
  s.summary          = 'SAMineModule for Cocoapods.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/WonderLand/SAMineModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WonderLand' => 'hotwordland@gmail.com' }
  s.source           = { :git => 'https://github.com/WonderLand/SAMineModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.prefix_header_contents = '#import "SAmsPrefixHeader.h"'

  s.source_files = 'SAMineModule/Classes/**/*.{h,m}'
  s.resources = ['SAMineModule/Classes/**/*.xib']
#  s.resource_bundles = {
#    'SAMineModule' => ['SAMineModule/Assets/*.xib']
#  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # 因为 s.dependency 不支持 :git 的操作 所以这里除了要写之外
  # 还需要在执行工程中添加 :git 相关的库 以下:
  #   pod 'WLKit',   :git => 'https://github.com/HotWordland/WLKit', :branch => 'master'
  # pod 'WYNullView',  :git => 'https://github.com/HotWordland/WYNullView', :branch => 'master'

   s.dependency 'WLKit'
   s.dependency 'WYNullView'
   s.dependency 'STPopup'
   s.dependency 'TZImagePickerController'
   s.dependency 'SpinKit'
   s.dependency 'Toast'
   s.dependency 'MJExtension'
   s.dependency 'MJRefresh'
   s.dependency 'Masonry'
   s.dependency "Qiniu", '~> 8.2.0'
end
