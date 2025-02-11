require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name          = 'react-native-umshare'
  s.version       = package['version']
  s.summary       = package['description']
  s.description   = package['description']
  s.homepage      = package['homepage']
  s.license       = package['license']
  s.author        = package['author']
  s.platform      = :ios, "9.0"
  s.source        = { :git => "https://github.com/krmao/react-native-umshare.git", :tag => "master" }

  # 源文件
  s.source_files  = "ios/**/**/**/*.{h,m}"

  # 资源文件
  s.resources     = [
    'ios/**/**/*.{bundle,strings}', # 添加资源文件夹
  ]

  # 需要 ARC 支持
  s.requires_arc  = true

  # 链接的库
  s.libraries = 'c++', 'z', 'sqlite3'

  # 链接的其他系统库
  s.frameworks = 'CoreTelephony', 'SystemConfiguration', 'ImageIO', 'Photos'

  # 添加 vendored frameworks
  s.vendored_frameworks = [
    'ios/SocialLibraries/DingDing/DTShareKit.framework',
    'ios/SocialLibraries/Facebook/Bolts.framework',
    'ios/SocialLibraries/Facebook/FBSDKCoreKit.framework',
    'ios/SocialLibraries/Facebook/FBSDKLoginKit.framework',
    'ios/SocialLibraries/Facebook/FBSDKMessengerShareKit.framework',
    'ios/SocialLibraries/Facebook/FBSDKShareKit.framework',
    'ios/SocialLibraries/Linkedin/linkedin-sdk.framework',
    'ios/SocialLibraries/QQ/QQSDK/TencentOpenAPI.framework',
    'ios/SocialLibraries/Twitter/TwitterCore.framework',
    'ios/SocialLibraries/Twitter/TwitterKit.framework',
    'ios/UMCommon.framework',
    'ios/UMShare.framework',
    'ios/UMShareUI/UShareUI.framework',
  ]

  # 添加 vendored 静态库（如果有）
  s.vendored_libraries = [
    'ios/SocialLibraries/DingDing/libSocialDingDing.a',
    'ios/SocialLibraries/Email/libSocialEmail.a',
    'ios/SocialLibraries/Facebook/libSocialFacebook.a',
    'ios/SocialLibraries/Instagram/libSocialInstagram.a',
    'ios/SocialLibraries/Linkedin/libSocialLinkedin.a',
    'ios/SocialLibraries/Pinterest/libSocialPinterest.a',
    'ios/SocialLibraries/QQ/libSocialQQ.a',
    'ios/SocialLibraries/SMS/libSocialSMS.a',
    'ios/SocialLibraries/Twitter/libSocialTwitter.a',
    'ios/SocialLibraries/WeChat/libSocialWeChat.a',
    'ios/SocialLibraries/WeChat/WechatSDK/libSocialOfficialWeChat.a',
    'ios/SocialLibraries/WeChat/WechatSDK/libWeChatSDK.a',
    'ios/SocialLibraries/WhatsApp/libSocialWhatsApp.a'
    'ios/UMSocialSDKPlugin/libUMSocialCloudShare.a'
  ]

  # React Native 依赖
  s.dependency 'React'

  # 添加 Other Linker Flags
  s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }

  s.prefix_header_file = 'ios/SocialLibraries/Facebook/facebook_ios_sdk_Prefix.pch'
end
