//
//  AdQuantaSDK.h
//  adquanta_ads_sdk
//
//  Created by AdQuanta on 2025/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdQuantaSDK : NSObject

/// 初始化 SDK
+ (void)initializeWithAppId:(NSString *)appId completionBlock:(void (^)(NSError * _Nullable error))completionBlock NS_SWIFT_NAME(initialize(withAppId:completionBlock:));

/// 设置日志级别 (0=关闭, 1=错误, 2=警告, 3=信息, 4=调试)
+ (void)setLogLevel:(NSInteger)level NS_SWIFT_NAME(setLogLevel(_:));

/// GDPR 设置
+ (void)setGDPRDataCollection:(BOOL)canDataCollection NS_SWIFT_NAME(setGDPRDataCollection(_:));

/// CCPA 设置
+ (void)setCCPADoNotSell:(BOOL)isCCPA NS_SWIFT_NAME(setCCPADoNotSell(_:));

/// COPPA 设置
+ (void)setCOPPAIsAgeRestrictedUser:(BOOL)isAgeRestrictedUser NS_SWIFT_NAME(setCOPPAIsAgeRestrictedUser(_:));

/// LGPD 设置
+ (void)setLGPDIsConsentEnabled:(BOOL)isConsentEnabled NS_SWIFT_NAME(setLGPDIsConsentEnabled(_:));

/// 设置是否允许追踪
+ (void)setDevAllowTracking:(BOOL)allowTracking NS_SWIFT_NAME(setDevAllowTracking(_:));

/// 设置自定义用户数据
+ (void)setCustomUserData:(NSDictionary *)userData NS_SWIFT_NAME(setCustomUserData(_:));

@end

NS_ASSUME_NONNULL_END

