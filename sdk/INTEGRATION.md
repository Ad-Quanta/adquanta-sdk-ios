# AdQuanta Ads SDK 集成指南

## 📦 SDK 包结构

本目录包含完整的 AdQuanta Ads SDK 包，包括主框架和所有依赖：

```
adquanta-ads-sdk/
├── adquanta_ads_sdk.framework/       # 主 SDK 框架（仅支持真机 arm64）
├── Frameworks/                        # 依赖框架目录
│   ├── TradPlusAds.xcframework/      # TradPlus Ads 核心框架
│   ├── TPCrossAdapter.xcframework/   # TradPlus 交叉适配器
│   ├── TPAdMobAdapter.xcframework/   # AdMob 适配器框架
│   ├── TPGoogleIMAAdapter.xcframework/ # Google IMA 适配器框架
│   └── GoogleInteractiveMediaAds.xcframework/ # Google IMA 核心框架
├── include/                           # 公共头文件目录
│   └── adquanta_ads_sdk/             # SDK 头文件
└── INTEGRATION.md                    # 本集成指南
```

**注意**：
- 主框架 `adquanta_ads_sdk.framework` 仅支持真机（arm64），不支持模拟器
- 所有资源 Bundle 已嵌入在 framework 内部，无需单独添加

## 🚀 集成步骤

### 1. 添加主框架

1. 在 Xcode 中打开你的项目
2. 选择项目 Target
3. 进入 `General > Frameworks, Libraries, and Embedded Content`
4. 点击 `+` 按钮，选择 `Add Other... > Add Files...`
5. 导航到项目目录，选择 `adquanta_ads_sdk.framework`
6. **重要**：确保设置为 `Embed & Sign`（不是 `Do Not Embed`）
7. **注意**：SDK 仅支持真机（arm64），不支持模拟器。如需测试，请使用真机

### 2. 添加依赖框架

在 `Frameworks, Libraries, and Embedded Content` 中，继续添加以下框架（**全部设置为 `Embed & Sign`**）：

1. `TradPlusAds.xcframework`
   - 路径：`Frameworks/TradPlusAds.xcframework`

2. `TPCrossAdapter.xcframework`
   - 路径：`Frameworks/TPCrossAdapter.xcframework`

3. `TPAdMobAdapter.xcframework`
   - 路径：`Frameworks/TPAdMobAdapter.xcframework`

4. `TPGoogleIMAAdapter.xcframework`
   - 路径：`Frameworks/TPGoogleIMAAdapter.xcframework`

5. `GoogleInteractiveMediaAds.xcframework`
   - 路径：`Frameworks/GoogleInteractiveMediaAds.xcframework`

### 3. 资源 Bundle（已自动嵌入）

**重要**：`adquanta_ads_sdk.framework` 内部已经包含了所有必需的资源 Bundle（`TradPlusAds.bundle`、`TradPlusADX.bundle` 等），无需手动添加。框架会自动处理资源加载。

### 4. 配置 Build Settings

确保以下设置正确：

1. **Framework Search Paths**：
   - 添加框架所在目录（如果使用相对路径）
   - 例如：`$(PROJECT_DIR)/DaFit/Frameworks/adquanta-ads-sdk`
   - 确保勾选 `recursive`（递归搜索）

2. **Other Linker Flags**：
   - 添加 `-ObjC`

3. **LD_RUNPATH_SEARCH_PATHS**：
   - 包含 `@executable_path/Frameworks`

### 5. 配置 Info.plist（AdMob）

如果使用 AdMob 广告，需要在 `Info.plist` 中添加 AdMob Application Identifier：

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-xxxxxxxxxxxxxxxx~xxxxxxxxxx</string>
```

### 6. 初始化 SDK（Swift）

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

**日志级别说明**：
- `10` = Trace（跟踪日志）
- `20` = Debug（调试日志）
- `30` = Info（信息日志，推荐用于生产环境）
- `40` = Warn（警告日志）
- `50` = Error（错误日志）
- `60` = Fatal（致命错误日志）
- `70` = Off（关闭所有日志）

### 7. 使用广告

#### 开屏广告（Splash Ad）

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
        // 检查广告是否就绪
        if let splashAd = splashAd, splashAd.isReady {
            // 展示广告
            splashAd.show()
        }
    }
    
    // 广告展示成功回调
    func adQuantaAd(_ ad: AdQuantaAd, didShowWithInfo adInfo: [AnyHashable : Any]) {
        print("开屏广告已展示")
    }
    
    // 广告关闭回调
    func adQuantaAd(_ ad: AdQuantaAd, didCloseWithInfo adInfo: [AnyHashable : Any]) {
        print("开屏广告已关闭")
        // 进入应用主界面
    }
    
    // 广告加载失败回调
    func adQuantaAd(_ ad: AdQuantaAd, didFailToLoadWithError error: Error) {
        print("开屏广告加载失败: \(error.localizedDescription)")
        // 直接进入应用主界面
    }
}
```

#### Banner 广告

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
        
        // 加载广告（Swift API 已优化，方法名更友好）
        bannerAd?.loadAd(withSceneId: nil)
    }
    
    // 实现 AdQuantaAdDelegate 方法...
}
```

#### 激励视频广告（Rewarded Ad）

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
}
```

## ✅ 验证集成

1. **编译项目**：
   - 按 `Cmd + B` 编译项目
   - 确保没有链接错误

2. **检查导入**：
   - 确保所有文件都能正确导入 `adquanta_ads_sdk` 模块
   - 如果出现导入错误，检查框架是否正确添加

3. **运行测试**：
   - 运行应用，检查控制台是否有 SDK 初始化成功的日志
   - 测试加载和展示各种类型的广告

## 📝 注意事项

1. **所有框架必须设置为 `Embed & Sign`**，不能使用 `Do Not Embed`
2. **Bundle 必须使用文件夹引用**（蓝色文件夹图标），不能使用 group（黄色文件夹图标）
3. **确保 iOS 部署目标 >= 13.0**
4. **SDK 初始化回调可能在后台线程**，UI 操作需要切换到主线程
5. **广告加载是异步的**，需要在 `AdQuantaAdDelegate` 回调中处理加载结果
6. **广告实例需要保持强引用**，否则可能被提前释放

## 🐛 常见问题

### 问题 1: 运行时找不到框架

**解决方案**: 
- 检查所有框架是否都设置为 `Embed & Sign`
- 检查 `LD_RUNPATH_SEARCH_PATHS` 是否包含 `@executable_path/Frameworks`
- 检查 `Framework Search Paths` 是否正确配置

### 问题 2: 找不到资源文件

**解决方案**:
- 确保 Bundle 使用文件夹引用（蓝色文件夹图标），而不是 group（黄色文件夹图标）
- 检查 Bundle 是否已添加到 Target 的 `Copy Bundle Resources` 构建阶段
- 注意 `adquanta_ads_sdk.xcframework` 内部已包含 Bundle，但建议同时添加 `Bundles` 目录下的 Bundle

### 问题 3: 链接错误

**解决方案**:
- 检查 `Other Linker Flags` 是否包含 `-ObjC`
- 确保所有依赖框架都已正确添加
- **注意**：主框架仅支持 arm64（真机），不支持模拟器架构

### 问题 4: Main Thread Checker 警告

**解决方案**:
- SDK 初始化回调可能在后台线程，确保 UI 操作和日志输出切换到主线程：
  ```swift
  DispatchQueue.main.async {
      // UI 操作或日志输出
  }
  ```

### 问题 5: 广告无法加载或展示

**解决方案**:
- 检查 App ID 和 Ad Unit ID 是否正确
- 检查网络连接是否正常
- 检查 Info.plist 中的 AdMob Application Identifier（如果使用 AdMob）
- 查看控制台日志，SDK 会输出详细的错误信息
- 确保在广告加载成功回调中检查 `isReady` 状态后再调用 `show()`

## 📞 技术支持

如有问题，请查看主 README.md 或联系技术支持。

## 📚 相关文档

- SDK 头文件位于：`include/adquanta_ads_sdk/` 或 `adquanta_ads_sdk.framework/Headers/`
- 主要类：
  - `AdQuantaSDK` - SDK 核心类
  - `AdQuantaSplash` - 开屏广告
  - `AdQuantaBanner` - Banner 广告
  - `AdQuantaRewarded` - 激励视频广告
  - `AdQuantaInterstitial` - 插屏广告
  - `AdQuantaAdDelegate` - 广告代理协议

## ⚠️ 重要提示

1. **架构支持**：SDK 仅支持真机（arm64），不支持模拟器。如需测试，请使用真机设备。
2. **Swift API**：v1.0.1 已修复 Swift API 命名问题，所有方法在 Swift 中都有正确的命名。
3. **AdMob 支持**：SDK 已完整集成 AdMob，如需使用 AdMob 广告，请在 Info.plist 中配置 `GADApplicationIdentifier`。
