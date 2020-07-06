//
//  VayneJSBridgeManager.m
//  vayne
//
//  Created by 肖怡宁 on 2020/7/3.
//

#import "VayneJSBridgeManager.h"
#import "RCTBridge+Vayne.h"
#import <React/RCTBridge+Private.h>
#import <React/RCTBundleURLProvider.h>


@interface VayneJSBridgeManager ()

@property (nonatomic, strong) RCTBridge *bridge;
@property (nonatomic, strong) RCTBridge *debugBridge;
@property (nonatomic, strong) NSMutableArray *loadedBundles;
@property (nonatomic, strong) NSMutableArray *loadingBundles;
@property (nonatomic, assign) BOOL commonBundleLoaded;
@property (nonatomic, copy) void (^commonBundleLoadedCallback)(void);

@end


@implementation VayneJSBridgeManager

// 单例
+ (instancetype)sharedInstance {
  
    static VayneJSBridgeManager *instance = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        instance = [[VayneJSBridgeManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
  
  self = [super init];
  if (self) {
   [self addObservers];
    self.loadedBundles = [NSMutableArray array];
    self.loadingBundles = [NSMutableArray array];
  }
  return self;
  
}

// metro bundle
- (RCTBridge *)bridgeForMetroBundleWithBundleRoot:(NSString *)bundleRoot {
    
  NSURL *bundleURL = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:bundleRoot fallbackResource:nil];
  self.debugBridge = [[RCTBridge alloc] initWithBundleURL:bundleURL moduleProvider:nil launchOptions:nil];
  return self.debugBridge;
  
}

// 加载主bundle
- (void)loadCommonBundle:(NSDictionary *)bundleInfo onCompleted:(void (^)(void))success {
  
  NSURL *bundleURL = bundleInfo[@"bundleURL"];
  NSString *bundleName = bundleInfo[@"bundleName"];
  self.bridge = [[RCTBridge alloc] initWithBundleURL:bundleURL moduleProvider:nil launchOptions:nil];
  [self.loadedBundles addObject:bundleName];
  self.commonBundleLoadedCallback = success;
  
}

// 加载业务bundles
- (void)loadBuzBundles:(NSArray *)bundles {
  
  [self.loadingBundles addObjectsFromArray:bundles];
  [self loadBundles];
  
}


// 某个业务bundle是否已经加载
- (BOOL)buzBundleIsLoadedWithName:(NSString *)bundleName {
    
  return [self.loadedBundles containsObject:bundleName];
  
}


// 递归调用
- (void)loadBundles {
      
  if ([self.loadingBundles count] > 0) {
    NSDictionary *bundleInfo = [self.loadingBundles firstObject];
    NSURL *bundleURL = bundleInfo[@"bundleURL"];
    NSString *bundleName = bundleInfo[@"bundleName"];
    if ([self.loadedBundles containsObject:bundleName]) {
      //已经加载过了
      [self loadBundles];
      return;
    }
    //递归加载
    [RCTJavaScriptLoader loadBundleAtURL:bundleURL onProgress:nil onComplete:^(NSError *error, RCTSource *source) {
      if (!error && source.data) {
        //成功
         dispatch_async(dispatch_get_main_queue(), ^{
           [self.bridge.batchedBridge executeSourceCode:source.data sync:YES];
           [self.loadedBundles addObject:bundleName];
           [self.loadingBundles removeObject:bundleInfo];
           [self loadBundles];
        });
      }else {
         [self loadBundles];
      }
    }];
  }
  
}

- (void)addObservers {
  
  [[NSNotificationCenter defaultCenter] addObserverForName:RCTJavaScriptDidLoadNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
    if (!self.commonBundleLoaded && self.commonBundleLoadedCallback) {
      self.commonBundleLoaded = YES;
      self.commonBundleLoadedCallback();
    }
  }];
  
}

- (void)loadBuzBundle:(NSDictionary *)bundleInfo onSuccess:(void (^)(RCTBridge *bridge))success onFailed:(void (^)(NSError *error))failed {
  
  NSURL *bundleURL = bundleInfo[@"bundleURL"];
  NSString *bundleName = bundleInfo[@"bundleName"];
  if ([self.loadedBundles containsObject:bundleName]) {
    NSLog(@"已经加载过，直接返回");
    success(self.bridge);
    return;
  }
      
  NSLog(@"非预加载，现在加载");
 [RCTJavaScriptLoader loadBundleAtURL:bundleURL onProgress:nil onComplete:^(NSError *error, RCTSource *source) {
   if (!error && source.data) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [self.bridge.batchedBridge executeSourceCode:source.data sync:YES];
        [self.loadedBundles addObject:bundleName];
        success(self.bridge);
     });
   }else {
     failed(error);
   }
 }];
  
}

- (RCTBridge *)getBridge {
  
  return self.bridge;
  
}

- (RCTBridge *)getDebugBridge {
  
  return self.debugBridge;
}

@end
