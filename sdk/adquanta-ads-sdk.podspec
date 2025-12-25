Pod::Spec.new do |s|
  s.name             = 'adquanta-ads-sdk'
  s.version          = '0.0.1'
  s.summary          = 'AdQuanta Ads SDK for iOS - 专业的移动广告聚合SDK'
  s.description      = <<-DESC
AdQuanta Ads SDK 是一个功能强大的移动广告聚合SDK，支持多种广告形式，包括：
- 开屏广告（Splash Ad）
- Banner 广告
- 插屏广告（Interstitial Ad）
- 激励视频广告（Rewarded Ad）
- 积分墙广告（Offerwall）

SDK 集成了多个主流广告平台，提供统一的API接口，简化广告集成流程。
                        DESC

  s.homepage         = 'https://github.com/Ad-Quanta/adquanta-sdk-ios'
  s.license          = { :type => 'GPL-3.0', :file => 'LICENSE' }
  s.author           = { 'adquanta' => '15828011064@163.com' }
  s.source           = { :git => 'https://github.com/Ad-Quanta/adquanta-sdk-ios.git', :tag => s.version.to_s }

  s.platform         = :ios, '14.0'
  s.requires_arc     = true

  # 主框架和核心依赖框架
  # 注意：主框架仅支持真机（arm64），使用 framework 格式
  # 依赖框架使用 xcframework 格式
  # 只包含核心依赖：TradPlusAdSDK, Google-Mobile-Ads-SDK, GoogleAds-IMA-iOS-SDK
  s.vendored_frameworks = [
    'sdk/adquanta_ads_sdk.framework',
    'sdk/Frameworks/TradPlusAds.xcframework',
    'sdk/Frameworks/TPCrossAdapter.xcframework',
    'sdk/Frameworks/GoogleMobileAds.xcframework',
    'sdk/Frameworks/GoogleInteractiveMediaAds.xcframework'
  ]

  # 关键配置：保护 Framework 结构，避免资源复制脚本处理内部 bundle
  # preserve_paths 确保 CocoaPods 不会尝试复制或处理这些路径下的资源
  s.preserve_paths = [
    'sdk/adquanta_ads_sdk.framework',
    'sdk/Frameworks/*.xcframework',
    'sdk/Frameworks/*.framework',
    'sdk/Frameworks/*.bundle'
  ]

  # 重要：明确不设置 resources，因为所有资源都已嵌入在 framework 内部
  # 这样可以避免 CocoaPods 的资源复制脚本尝试访问 framework 内部的 bundle
  # 不设置 s.resources 或 s.resource_bundles，让 framework 内部的资源自然嵌入
  # framework 内部已包含：
  # - TradPlusAds.bundle
  # - TradPlusADX.bundle
  # - GoogleMobileAdsResources.bundle (来自 GoogleMobileAds.xcframework)
  # - UserMessagingPlatformResources.bundle (来自 GoogleMobileAds.xcframework)

  s.frameworks = [
    'Foundation',
    'UIKit',
    'CoreGraphics',
    'SystemConfiguration',
    'CoreTelephony',
    'AdSupport',
    'CoreLocation',
    'StoreKit',
    'AVFoundation',
    'WebKit',
    'MediaPlayer',
    'SafariServices',
    'AppTrackingTransparency',
    'JavaScriptCore'
  ]

  # 链接器配置
  # 注意：主框架仅支持真机（arm64），不支持模拟器
  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC',
    'VALID_ARCHS' => 'arm64',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 x86_64 i386',
    # 确保 framework 搜索路径正确
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/adquanta-ads-sdk/sdk $(PODS_ROOT)/adquanta-ads-sdk/sdk/Frameworks'
  }

  s.documentation_url = 'https://github.com/Ad-Quanta/adquanta-sdk-ios'
end
