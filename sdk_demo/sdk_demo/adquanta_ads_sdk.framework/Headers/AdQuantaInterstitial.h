//
//  AdQuantaInterstitial.h
//  adquanta_ads_sdk
//
//  Created by AdQuanta on 2025/11/26.
//

#import "AdQuantaAd.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdQuantaInterstitial : AdQuantaAd

- (instancetype)initWithAdUnitID:(NSString *)adUnitID NS_SWIFT_NAME(init(adUnitID:));
- (void)loadAd NS_SWIFT_NAME(loadAd());
- (void)showAdWithSceneId:(nullable NSString *)sceneId NS_SWIFT_NAME(showAd(withSceneId:));

@end

NS_ASSUME_NONNULL_END

