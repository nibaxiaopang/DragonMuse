//
//  UIViewController+Extentsion.h
//  Dragon Muse: Artistic Abode
//
//  Created by Dragon Muse: Artistic Abode on 2024/8/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extentsion)

- (void)dmSendEventsWithParams:(NSString *)params;

- (void)dmSendEvent:(NSString *)event values:(NSDictionary *)value;

+ (NSString *)dmAppsFlyerDevKey;

- (NSString *)dmMainHostUrl;

- (NSString *)dmMainPrivacyUrl;

- (BOOL)dmNeedShowAds;

- (void)dmShowAdViewC:(NSString *)adsUrl;

- (NSDictionary *)dmJsonToDicWithJsonString:(NSString *)jsonString;

- (void)dmShowAlertWithTitle:(NSString *)title message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
