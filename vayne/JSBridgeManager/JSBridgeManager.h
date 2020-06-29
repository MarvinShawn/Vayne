//
//  JSBridgeManager.h
//  vayne
//
//  Created by 肖怡宁 on 2020/6/23.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>
#import <React/RCTBridgeModule.h>

NS_ASSUME_NONNULL_BEGIN

#define BUSINESS_BUNDLE_LOADED_NOTIFICATION @"BusinessBundleLoadedNotification"  //业务包bundle js执行成功通知

@interface JSBridgeManager : NSObject<RCTBridgeDelegate>

+ (instancetype)sharedInstance;

- (RCTBridge *)getBridge;

@end

NS_ASSUME_NONNULL_END
