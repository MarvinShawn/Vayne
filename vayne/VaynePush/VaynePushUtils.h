//
//  VaynePushUtils.h
//  vayne
//
//  Created by 肖怡宁 on 2020/7/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VaynePushUtils : NSObject

+ (NSString *)getAppVersion;
+ (NSString *)fileMD5:(NSString*)path;
+ (NSString *)DocumentsPath;

@end

NS_ASSUME_NONNULL_END
