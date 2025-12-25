//
//  AdQuantaSplash.h
//  adquanta_ads_sdk
//
//  Created by AdQuanta on 2025/11/26.
//

#import "AdQuantaAd.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdQuantaSplash : AdQuantaAd

- (instancetype)initWithAdUnitID:(NSString *)adUnitID NS_SWIFT_NAME(init(adUnitID:));
- (void)loadAdWithWindow:(UIWindow *)window bottomView:(nullable UIView *)bottomView NS_SWIFT_NAME(loadAd(with:bottomView:));
- (void)show;

@end

NS_ASSUME_NONNULL_END

