//
//  VaynePush.m
//  vayne
//
//  Created by 肖怡宁 on 2020/7/1.
//

#import "VaynePush.h"
#import "VaynePushPackage.h"
#import "VayneJSBridgeManager.h"


/*
 
  VaynePush  暴露接口类
  
  Downloader 下载bundle类
 
  Package bundle下载和存储
 
  Utils 工具类
 */

@implementation VaynePush

+ (void)startPush {
  
  [VaynePushPackage checkPushPackage];
  [self loadAllBuzBundles];
  
}


+ (void)loadAllBuzBundles {
  
  VayneJSBridgeManager * manager = [VayneJSBridgeManager sharedInstance];
  NSDictionary *commonBundleInfo = [VaynePushPackage getCommonBundleInfo];
  if (commonBundleInfo) {
    [manager loadCommonBundle:commonBundleInfo onCompleted:^{
      NSArray *buzBundleInfos = [VaynePushPackage getBuzBundlesInfo];
      [manager loadBuzBundles:buzBundleInfos];
    }];
  }
  
}

+ (void)loadBuzWithName:(NSString *)name onSuccess:(void (^)(RCTBridge *bridge))success onFailed:(void (^)(NSError *error))failed {
  
  NSDictionary *bundleInfo = [VaynePushPackage getBuzBundleInfoWithName:name];
  if (bundleInfo) {
    [[VayneJSBridgeManager sharedInstance] loadBuzBundle:bundleInfo onSuccess:success onFailed:failed];
  }else {
    failed([NSError errorWithDomain:@"no such buz" code:400 userInfo:nil]);
  }
  
}

+ (RCTBridge *)bridgeForMetroBundleWithBundleRoot:(NSString *)bundleRoot {
      
  return [[VayneJSBridgeManager sharedInstance] bridgeForMetroBundleWithBundleRoot:bundleRoot];
  
}

+ (RCTBridge *)getBridge {

  return [[VayneJSBridgeManager sharedInstance] getBridge];
  
}

+ (RCTBridge *)getDebugBridge {

  return [[VayneJSBridgeManager sharedInstance] getDebugBridge];
  
}

@end
