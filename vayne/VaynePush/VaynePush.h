//
//  VaynePush.h
//  vayne
//
//  Created by 肖怡宁 on 2020/7/1.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>

NS_ASSUME_NONNULL_BEGIN

@interface VaynePush : NSObject

+ (void)startPush;

+ (RCTBridge *)getBridge;

+ (RCTBridge *)getDebugBridge;

+ (void)loadBuzWithName:(NSString *)name onSuccess:(void (^)(RCTBridge *bridge))success onFailed:(void (^)(NSError *error))failed;

+ (RCTBridge *)bridgeForMetroBundleWithBundleRoot:(NSString *)bundleRoot;

@end

NS_ASSUME_NONNULL_END
