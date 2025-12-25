//
//  AdQuantaAd.h
//  adquanta_ads_sdk
//
//  Created by AdQuanta on 2025/11/26.
//

#import <Foundation/Foundation.h>
#import "AdQuantaAdDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class AdQuantaAd;

@interface AdQuantaAd : NSObject

@property (nonatomic, copy) NSString *adUnitID;
@property (nonatomic, weak, nullable) id<AdQuantaAdDelegate> delegate;
@property (nonatomic, strong, nullable) NSDictionary *customAdInfo;
@property (nonatomic, assign, readonly) BOOL isReady;
@property (nonatomic, copy, nullable) NSString *segmentTag;
@property (nonatomic, strong, nullable) NSDictionary *dicCustomValue;
@property (nonatomic, strong, nullable) NSDictionary *localParams;

- (void)loadAd NS_SWIFT_NAME(loadAd());
- (void)showAdWithSceneId:(nullable NSString *)sceneId NS_SWIFT_NAME(showAd(withSceneId:));
- (void)entryAdScenario:(nullable NSString *)scenarioId;
- (nullable NSDictionary *)getReadyAdInfo;
- (nullable NSDictionary *)getCurrentAdInfo;
- (nullable id)getAdObject;

@end

NS_ASSUME_NONNULL_END

