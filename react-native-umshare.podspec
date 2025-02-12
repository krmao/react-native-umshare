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
  s.frameworks = 'CoreTelephony', 'SystemConfiguration', 'WebKit', 'Photos'

  # 添加 vendored frameworks
  s.vendored_frameworks = [
    'ios/share_ios_6.10.13/SocialLibraries/Linkedin/linkedin-sdk.framework',
  ]

  # 添加 vendored 静态库（如果有）
  s.vendored_libraries = [
    'ios/share_ios_6.10.13/SocialLibraries/Linkedin/libSocialLinkedin.a',
  ]

  # React Native 依赖
  s.dependency 'React'

  # 在这里添加依赖库
  s.dependency 'UMCommon'   # 必须集成
  s.dependency 'UMDevice'   # 必须集成

  # 可选，UI模块（分享面板），由原来的UMCShare/UI变为了UMShare/UI
  s.dependency 'UMShare/UI'

  # 分享SDK 在线依赖其它平台仅支持手动集成[友盟+官网-开发者中心-sdk下载页-sdk下载]
  s.dependency 'UMShare/Social/WeChat'
  # s.dependency 'UMShare/Social/QQ'
  s.dependency 'UMShare/Social/DingDing'
  # s.dependency 'UMShare/Social/WeChatWork'
  s.dependency 'UMShare/Social/SMS'
  s.dependency 'UMShare/Social/Email'
  s.dependency 'UMShare/Social/Facebook'
  # s.dependency 'UMShare/Social/Twitter'
  # s.dependency 'UMShare/Social/WhatsApp'
  # s.dependency 'UMShare/Social/Instagram'
  # s.dependency 'UMShare/Social/Pinterest'

  # 添加 Other Linker Flags
  s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
end
