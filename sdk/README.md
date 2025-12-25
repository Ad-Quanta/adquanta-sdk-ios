# AdQuanta Ads SDK for iOS

AdQuanta Ads SDK 是一个功能强大的移动广告聚合SDK，支持多种广告形式，帮助开发者轻松集成广告功能，实现收益最大化。

## 功能特性

- ✅ **多种广告形式**：支持开屏、Banner、插屏、激励视频、积分墙等多种广告类型
- ✅ **统一API接口**：提供简洁统一的API，降低集成复杂度
- ✅ **多平台聚合**：集成多个主流广告平台，智能分配流量
- ✅ **高性能**：优化的加载机制，提升广告展示效率
- ✅ **完善的回调**：提供完整的广告生命周期回调，便于业务处理
- ✅ **隐私合规**：支持GDPR、CCPA等隐私合规配置

## 系统要求

- iOS 14.0 或更高版本
- Xcode 12.0 或更高版本
- Swift 5.0 或更高版本（使用 Swift 时）
- CocoaPods 1.10.0 或更高版本

## 安装

### CocoaPods

在您的 `Podfile` 中添加：

```ruby
pod 'adquanta-ads-sdk', '~> 0.0.1'
```

然后运行：

```bash
pod install
```

## 快速开始

### 1. 初始化 SDK

在 `AppDelegate.swift` 中初始化 SDK：

```swift
import adquanta_ads_sdk

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // 设置日志级别（可选，建议在初始化前设置）
    // 日志级别：30 = Info（推荐用于生产环境）
    AdQuantaSDK.setLogLevel(30)
    
    // 初始化 SDK
    AdQuantaSDK.initialize(withAppId: "YOUR_APP_ID") { error in
        // 注意：回调可能在后台线程，UI操作需要切换到主线程
        DispatchQueue.main.async {
            if let error = error {
                print("AdQuanta SDK 初始化失败: \(error.localizedDescription)")
            } else {
                print("AdQuanta SDK 初始化成功")
            }
        }
    }
    
    return true
}
```

### 2. 使用开屏广告

```swift
import adquanta_ads_sdk

class SplashViewController: UIViewController, AdQuantaAdDelegate {
    
    private var splashAd: AdQuantaSplash?
    private let SPLASH_AD_UNIT_ID = "YOUR_SPLASH_AD_UNIT_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建开屏广告实例
        splashAd = AdQuantaSplash(adUnitID: SPLASH_AD_UNIT_ID)
        splashAd?.delegate = self
        
        // 加载广告
        if let window = view.window {
            splashAd?.loadAd(with: window, bottomView: nil)
        }
    }
    
    // 广告加载成功回调
    func adQuantaAd(_ ad: AdQuantaAd, didLoadWithInfo adInfo: [AnyHashable : Any]) {
        if let splashAd = splashAd, splashAd.isReady {
            splashAd.show()
        }
    }
    
    // 广告关闭回调
    func adQuantaAd(_ ad: AdQuantaAd, didCloseWithInfo adInfo: [AnyHashable : Any]) {
        // 进入应用主界面
    }
    
    // 广告加载失败回调
    func adQuantaAd(_ ad: AdQuantaAd, didLoadFailWithError error: Error) {
        // 直接进入应用主界面
    }
    
    // 提供用于展示模态视图的控制器
    func viewController(forPresentingModalView ad: AdQuantaAd) -> UIViewController? {
        return self
    }
}
```

### 3. 使用 Banner 广告

```swift
import adquanta_ads_sdk

class HomeViewController: UIViewController, AdQuantaAdDelegate {
    
    private var bannerAd: AdQuantaBanner?
    private let BANNER_AD_UNIT_ID = "YOUR_BANNER_AD_UNIT_ID"
    
    func setupBannerAd() {
        // 创建Banner广告容器
        let bannerFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        bannerAd = AdQuantaBanner(adUnitID: BANNER_AD_UNIT_ID, frame: bannerFrame)
        bannerAd?.delegate = self
        bannerAd?.isAutoShow = true // 自动展示
        
        // 将Banner视图添加到容器中
        if let bannerView = bannerAd?.bannerView {
            view.addSubview(bannerView)
            // 设置约束...
        }
        
        // 加载广告
        bannerAd?.loadAd(withSceneId: nil)
    }
    
    // 实现 AdQuantaAdDelegate 方法...
    func viewController(forPresentingModalView ad: AdQuantaAd) -> UIViewController? {
        return self
    }
}
```

### 4. 使用激励视频广告

```swift
import adquanta_ads_sdk

class RewardViewController: UIViewController, AdQuantaAdDelegate {
    
    private var rewardAd: AdQuantaRewarded?
    private let REWARD_AD_UNIT_ID = "YOUR_REWARD_AD_UNIT_ID"
    
    func loadRewardAd() {
        // 创建激励视频广告实例
        rewardAd = AdQuantaRewarded(adUnitID: REWARD_AD_UNIT_ID)
        rewardAd?.delegate = self
        
        // 加载广告
        rewardAd?.load()
    }
    
    func showRewardAd() {
        // 检查广告是否就绪
        guard let rewardAd = rewardAd, rewardAd.isReady else {
            print("激励视频广告未就绪")
            return
        }
        
        // 展示广告
        rewardAd.show(from: self)
    }
    
    // 广告奖励回调（仅适用于激励视频广告）
    func adQuantaAd(_ ad: AdQuantaAd, didRewardWithInfo rewardInfo: [AnyHashable : Any]) {
        print("用户完成观看，获得奖励")
        // 发放奖励给用户
    }
    
    // 实现其他 AdQuantaAdDelegate 方法...
    func viewController(forPresentingModalView ad: AdQuantaAd) -> UIViewController? {
        return self
    }
}
```

## 日志级别

SDK 支持多种日志级别，可以通过 `AdQuantaSDK.setLogLevel(_:)` 方法设置：

- `10` = Trace（跟踪日志）
- `20` = Debug（调试日志）
- `30` = Info（信息日志，推荐用于生产环境）
- `40` = Warn（警告日志）
- `50` = Error（错误日志）
- `60` = Fatal（致命错误日志）
- `70` = Off（关闭所有日志）

## AdQuantaAdDelegate 协议

所有广告类型都遵循 `AdQuantaAdDelegate` 协议，提供完整的广告生命周期回调：

```swift
protocol AdQuantaAdDelegate: NSObjectProtocol {
    // 广告加载成功
    func adQuantaAd(_ ad: AdQuantaAd, didLoadWithInfo adInfo: [AnyHashable : Any])
    
    // 广告加载失败
    func adQuantaAd(_ ad: AdQuantaAd, didLoadFailWithError error: Error)
    
    // 广告展示成功
    func adQuantaAd(_ ad: AdQuantaAd, didShowWithInfo adInfo: [AnyHashable : Any])
    
    // 广告展示失败
    func adQuantaAd(_ ad: AdQuantaAd, didShowFailWithInfo adInfo: [AnyHashable : Any], error: Error)
    
    // 广告被点击
    func adQuantaAd(_ ad: AdQuantaAd, didClickWithInfo adInfo: [AnyHashable : Any])
    
    // 广告关闭
    func adQuantaAd(_ ad: AdQuantaAd, didCloseWithInfo adInfo: [AnyHashable : Any])
    
    // 激励视频奖励回调（仅适用于激励视频广告）
    func adQuantaAd(_ ad: AdQuantaAd, didRewardWithInfo adInfo: [AnyHashable : Any])
    
    // 提供用于展示模态视图的控制器
    func viewController(forPresentingModalView ad: AdQuantaAd) -> UIViewController?
}
```

## 主要类

- `AdQuantaSDK` - SDK 核心类，提供初始化和配置功能
- `AdQuantaSplash` - 开屏广告
- `AdQuantaBanner` - Banner 广告
- `AdQuantaInterstitial` - 插屏广告
- `AdQuantaRewarded` - 激励视频广告
- `AdQuantaOfferwall` - 积分墙广告
- `AdQuantaAdDelegate` - 广告代理协议

## 配置 Info.plist

如果使用 AdMob 广告，需要在 `Info.plist` 中添加 AdMob Application Identifier：

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-xxxxxxxxxxxxxxxx~xxxxxxxxxx</string>
```

## 常见问题

### 1. 运行时找不到框架

**解决方案**：
- 确保使用 CocoaPods 安装，CocoaPods 会自动处理框架链接
- 检查 `Podfile` 中是否包含 `use_frameworks!`

### 2. 广告无法加载

**解决方案**：
- 检查 App ID 和 Ad Unit ID 是否正确
- 检查网络连接是否正常
- 查看控制台日志，SDK 会输出详细的错误信息
- 确保在广告加载成功回调中检查 `isReady` 状态后再调用展示方法

### 3. Main Thread Checker 警告

**解决方案**：
- SDK 初始化回调可能在后台线程，确保 UI 操作切换到主线程：
  ```swift
  DispatchQueue.main.async {
      // UI 操作
  }
  ```

## 技术支持

如有问题，请通过以下方式联系：

- GitHub Issues: [https://github.com/Ad-Quanta/adquanta-sdk-ios/issues](https://github.com/Ad-Quanta/adquanta-sdk-ios/issues)
- 邮箱: support@adoptrack.com

## 许可证

本项目采用 GPL-3.0 许可证。详情请参阅 [LICENSE](LICENSE) 文件。

## 更新日志

### 1.0.0 (2025-01-XX)

- 首次发布
- 支持开屏、Banner、插屏、激励视频、积分墙广告
- 集成多个主流广告平台
- 提供完整的广告生命周期回调

