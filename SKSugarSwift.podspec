#
#  Be sure to run `pod spec lint SKSugarSwift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#


Pod::Spec.new do |s|
  s.name             = 'SKSugarSwift'
  s.version          = '0.2.29'
  s.summary          = 'A short description of SKSugarSwift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
        包含一些extension和自己封装的常用视图、框架、工具类
        不断更新中……
                       DESC

  s.homepage         = 'https://github.com/tonysky/SKSugarSwift'
  s.license          = 'MIT'
  # s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tonycgao@sina.com' => 'tonycgao@sina.com' }
  s.source           = { :git => 'https://github.com/tonysky/SKSugarSwift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  # s.ios.platform = :ios, '8.0'
  s.ios.deployment_target = '8.0'

  s.source_files = 'Classes/*', 'Classes/**/*'
  
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'SKSugarSwift' => ['SKSugarSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end



#1. 提交版本
#   修改 .podspec 文件版本号，push工程
#
#2. 打tag，提交tag
#    //为git打tag, 第一次需要在前面加一个v (跟文件版本号一致)
#    git tag "v1.0.0" 
#    //将tag推送到远程仓库
#    git push --tags 
#
#3. 验证 .podspec文件
#    // --verbose 如果验证失败会报错误信息
#    pod spec lint --verbose --allow-warnings
#
#4. 发布
#    pod trunk push --allow-warnings






