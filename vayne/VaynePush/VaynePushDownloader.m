//
//  VaynePushDownloader.m
//  vayne
//
//  Created by 肖怡宁 on 2020/7/1.
//

#import "VaynePushDownloader.h"


@interface VaynePushDownloader()<NSURLSessionDownloadDelegate>

@property (nonatomic,copy) DownloaderSuccessBlock successCallback;
@property (nonatomic,copy) DownloaderFailedBlock failCallback;
@property (nonatomic,copy) DownloaderProgressBlock progressCallback;

@end


@implementation VaynePushDownloader


- (void)downloadBundleWithURL:(NSURL *)url onSuccess:(DownloaderSuccessBlock)success onProgress:(DownloaderProgressBlock)progress onFailed:(DownloaderFailedBlock)failed {
  
  if (success) {
    self.successCallback = success;
  }
  if (progress) {
    self.progressCallback = progress;
  }
  if (failed) {
    self.failCallback = failed;
  }
      
  NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
  NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url];
  [task resume];
  
}

//下载成功
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
  
  if (location) {
    self.successCallback(location);
  }
  
}


//进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
             didWriteData:(int64_t)bytesWritten
        totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
  
  float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
  self.progressCallback(progress);
  
}

// 下载失败
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
  
  if (error) {
    self.failCallback(error);
  }
  
}


@end
