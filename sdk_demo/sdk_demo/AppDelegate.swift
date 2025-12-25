//
//  AppDelegate.swift
//  sdk_demo
//
//  Created by tomlu on 2025/12/25.
//

import UIKit
import adquanta_ads_sdk
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 设置日志级别（3 = Info，4 = Debug）
        AdQuantaSDK.setLogLevel(4)
        
        // 配置隐私合规设置（在初始化前设置）
        configurePrivacyCompliance()
        
        // 请求追踪权限（iOS 14+）
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { [weak self] status in
                DispatchQueue.main.async {
                    self?.handleTrackingAuthorizationStatus(status)
                }
            }
        } else {
            // iOS 14 以下版本，默认允许追踪
            AdQuantaSDK.setDevAllowTracking(true)
        }
        
        // 初始化 SDK
        // AppID
        AdQuantaSDK.initialize(withAppId: "75AA158112F1EFA29169E26AC63AFF94") { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("❌ AdQuanta SDK 初始化失败: \(error.localizedDescription)")
                } else {
                    print("✅ AdQuanta SDK 初始化成功")
                }
            }
        }
        
        return true
    }
    
    // MARK: - Privacy Compliance Configuration
    
    /// 配置隐私合规设置
    /// 注意：这些设置应该根据你的应用的实际隐私政策和用户选择来配置
    private func configurePrivacyCompliance() {
        // GDPR 设置
        // true = 允许数据收集，false = 不允许数据收集
        // 根据你的应用是否面向欧盟用户以及用户的同意状态来设置
        // 示例：默认允许（实际应用中应该根据用户同意状态设置）
        AdQuantaSDK.setGDPRDataCollection(true)
        
        // CCPA 设置（加州消费者隐私法案）
        // true = 用户选择不出售个人信息，false = 用户未选择不出售
        // 根据用户的 CCPA 选择来设置
        // 示例：默认 false（实际应用中应该根据用户选择设置）
        AdQuantaSDK.setCCPADoNotSell(false)
        
        // COPPA 设置（儿童在线隐私保护法案）
        // true = 用户是受年龄限制的用户（13岁以下），false = 不是
        // 根据你的应用是否面向儿童来设置
        // 示例：默认 false（实际应用中应该根据应用类型设置）
        AdQuantaSDK.setCOPPAIsAgeRestrictedUser(false)
        
        // LGPD 设置（巴西通用数据保护法）
        // true = 用户同意数据收集，false = 用户未同意
        // 根据你的应用是否面向巴西用户以及用户的同意状态来设置
        // 示例：默认 true（实际应用中应该根据用户同意状态设置）
        AdQuantaSDK.setLGPDIsConsentEnabled(true)
    }
    
    /// 处理 App Tracking Transparency 授权状态
    @available(iOS 14.0, *)
    private func handleTrackingAuthorizationStatus(_ status: ATTrackingManager.AuthorizationStatus) {
        switch status {
        case .authorized:
            print("✅ ATT: 用户已授权追踪")
            AdQuantaSDK.setDevAllowTracking(true)
            
        case .denied:
            print("❌ ATT: 用户拒绝追踪")
            AdQuantaSDK.setDevAllowTracking(false)
            // 用户拒绝追踪时，通常也应该限制数据收集
            AdQuantaSDK.setGDPRDataCollection(false)
            
        case .notDetermined:
            print("⚠️ ATT: 用户尚未做出选择")
            // 可以设置默认值，或者等待用户做出选择
            AdQuantaSDK.setDevAllowTracking(false)
            
        case .restricted:
            print("🚫 ATT: 追踪受限（可能是家长控制等）")
            AdQuantaSDK.setDevAllowTracking(false)
            AdQuantaSDK.setGDPRDataCollection(false)
            AdQuantaSDK.setCOPPAIsAgeRestrictedUser(true)
            
        @unknown default:
            print("❓ ATT: 未知状态")
            AdQuantaSDK.setDevAllowTracking(false)
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

