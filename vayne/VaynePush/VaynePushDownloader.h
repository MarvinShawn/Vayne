//
//  VaynePushDownloader.h
//  vayne
//
//  Created by 肖怡宁 on 2020/7/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DownloaderSuccessBlock)(NSURL *location);
typedef void (^DownloaderFailedBlock)(NSError *error);
typedef void (^DownloaderProgressBlock)(float progress);

@interface VaynePushDownloader : NSObject
- (void)downloadBundleWithURL:(NSURL *)url onSuccess:(DownloaderSuccessBlock)success onProgress:(DownloaderProgressBlock)progress onFailed:(DownloaderFailedBlock)failed;
@end

NS_ASSUME_NONNULL_END
