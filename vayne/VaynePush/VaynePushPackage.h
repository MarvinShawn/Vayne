//
//  VaynePushPackage.h
//  vayne
//
//  Created by 肖怡宁 on 2020/7/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VaynePushPackage : NSObject

+ (void)downloadPackage:(NSDictionary *)packageInfo;
+ (void)checkPushPackage;
+ (NSDictionary *)getCommonBundleInfo;
+ (NSDictionary *)getBuzBundleInfoWithName:(NSString *)bundleName;
+ (NSArray *)getBuzBundlesInfo;

@end

NS_ASSUME_NONNULL_END
