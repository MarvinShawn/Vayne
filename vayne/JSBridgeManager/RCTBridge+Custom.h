//
//  RCTBridge+Custom.h
//  vayne
//
//  Created by 肖怡宁 on 2020/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTBridge (Custom)  //暴露接口

- (void)executeSourceCode:(NSData *)sourceCode sync:(BOOL)sync;

@end

NS_ASSUME_NONNULL_END
