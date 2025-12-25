//
//  AdQuantaAdDelegate.h
//  adquanta_ads_sdk
//
//  Created by AdQuanta on 2025/11/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AdQuantaAd;

@protocol AdQuantaAdDelegate <NSObject>

@optional
/// 广告加载成功
- (void)adQuantaAd:(AdQuantaAd *)ad didLoadWithInfo:(NSDictionary *)adInfo NS_SWIFT_NAME(adQuantaAd(_:didLoadWithInfo:));

/// 广告加载失败
- (void)adQuantaAd:(AdQuantaAd *)ad didLoadFailWithError:(NSError *)error NS_SWIFT_NAME(adQuantaAd(_:didLoadFailWithError:));

/// 广告展示成功
- (void)adQuantaAd:(AdQuantaAd *)ad didShowWithInfo:(NSDictionary *)adInfo NS_SWIFT_NAME(adQuantaAd(_:didShowWithInfo:));

/// 广告展示失败
- (void)adQuantaAd:(AdQuantaAd *)ad didShowFailWithInfo:(NSDictionary *)adInfo error:(NSError *)error NS_SWIFT_NAME(adQuantaAd(_:didShowFailWithInfo:error:));

/// 广告被点击
- (void)adQuantaAd:(AdQuantaAd *)ad didClickWithInfo:(NSDictionary *)adInfo NS_SWIFT_NAME(adQuantaAd(_:didClickWithInfo:));

/// 广告关闭
- (void)adQuantaAd:(AdQuantaAd *)ad didCloseWithInfo:(NSDictionary *)adInfo NS_SWIFT_NAME(adQuantaAd(_:didCloseWithInfo:));

/// 激励视频奖励完成
- (void)adQuantaAd:(AdQuantaAd *)ad didRewardWithInfo:(NSDictionary *)adInfo NS_SWIFT_NAME(adQuantaAd(_:didRewardWithInfo:));

/// 竞价相关事件
- (void)adQuantaAd:(AdQuantaAd *)ad didBiddingStartWithInfo:(NSDictionary *)adInfo NS_SWIFT_NAME(adQuantaAd(_:didBiddingStartWithInfo:));
- (void)adQuantaAd:(AdQuantaAd *)ad didBiddingEndWithInfo:(NSDictionary *)adInfo NS_SWIFT_NAME(adQuantaAd(_:didBiddingEndWithInfo:));
- (void)adQuantaAd:(AdQuantaAd *)ad didBiddingFailWithError:(NSError *)error NS_SWIFT_NAME(adQuantaAd(_:didBiddingFailWithError:));

/// 提供用于展示模态视图的 ViewController
- (nullable UIViewController *)viewControllerForPresentingModalView:(AdQuantaAd *)ad NS_SWIFT_NAME(viewController(forPresentingModalView:));

@end

