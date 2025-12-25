# AdQuanta Ads SDK for iOS

AdQuanta Ads SDK 是一个功能强大的移动广告聚合SDK，支持多种广告形式，帮助开发者轻松集成广告功能，实现收益最大化。

## 📦 目录结构

```
adquanta-sdk-ios/
├── sdk/                    # SDK 文件目录
│   ├── adquanta_ads_sdk.framework/  # 主 SDK 框架
│   ├── Frameworks/         # 依赖框架
│   ├── include/            # 公共头文件
│   ├── adquanta-ads-sdk.podspec  # CocoaPods 配置文件
│   └── README.md           # SDK 使用文档
├── sdk_demo/               # Demo 项目目录
│   ├── sdk_demo.xcodeproj  # Xcode 项目
│   ├── sdk_demo.xcworkspace # CocoaPods workspace
│   └── sdk_demo/           # Demo 源代码
└── LICENSE                 # 许可证文件
```

## 🚀 快速开始

### 使用 CocoaPods 安装

在您的 `Podfile` 中添加：

```ruby
pod 'adquanta-ads-sdk', '~> 0.0.1'
```

然后运行：

```bash
pod install
```

### 手动集成

请参考 `sdk/README.md` 文件了解详细的手动集成步骤。

## 📚 文档

- **SDK 文档**: 查看 `sdk/README.md`
- **Demo 项目**: 查看 `sdk_demo/` 目录

## 📞 技术支持

如有问题，请联系：support@adoptrack.com

## 📄 许可证

本 SDK 采用 GPL-3.0 许可证，详见 [LICENSE](LICENSE) 文件。
