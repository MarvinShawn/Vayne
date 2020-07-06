//
//  VayneJSBridgeManager.h
//  vayne
//
//  Created by 肖怡宁 on 2020/7/3.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>


NS_ASSUME_NONNULL_BEGIN

@interface VayneJSBridgeManager : NSObject

+ (instancetype)sharedInstance;

// metro模式
- (RCTBridge *)bridgeForMetroBundleWithBundleRoot:(NSString *)bundleRoot;

// 加载主包
- (void)loadCommonBundle:(NSDictionary *)bundleInfo onCompleted:(void (^)(void))success;

// 加载业务包
- (void)loadBuzBundles:(NSArray *)bundles;


// 加载某个bundle
- (void)loadBuzBundle:(NSDictionary *)bundleInfo onSuccess:(void (^)(RCTBridge *bridge))success onFailed:(void (^)(NSError *error))failed;

- (RCTBridge *)getBridge;

// 调试模式bridge
- (RCTBridge *)getDebugBridge;

@end


NS_ASSUME_NONNULL_END
