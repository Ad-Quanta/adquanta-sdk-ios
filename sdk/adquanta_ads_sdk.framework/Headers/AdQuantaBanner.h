//
//  AdQuantaBanner.h
//  adquanta_ads_sdk
//
//  Created by AdQuanta on 2025/11/26.
//

#import "AdQuantaAd.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdQuantaBanner : AdQuantaAd

@property (nonatomic, strong, readonly) UIView *bannerView;
@property (nonatomic, assign) BOOL autoShow;

- (instancetype)initWithAdUnitID:(NSString *)adUnitID frame:(CGRect)frame NS_SWIFT_NAME(init(adUnitID:frame:));
- (void)loadAdWithSceneId:(nullable NSString *)sceneId NS_SWIFT_NAME(loadAd(withSceneId:));
- (void)showWithSceneId:(nullable NSString *)sceneId NS_SWIFT_NAME(show(withSceneId:));
- (void)setBannerSize:(CGSize)size NS_SWIFT_NAME(setBannerSize(_:));

@end

NS_ASSUME_NONNULL_END

