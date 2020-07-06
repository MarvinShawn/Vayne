//
//  VaynePushPackage.m
//  vayne
//
//  Created by 肖怡宁 on 2020/7/2.
//

#import "VaynePushPackage.h"
#import "VaynePushDownloader.h"
#import "VaynePushUtils.h"

@implementation VaynePushPackage

#pragma mark - constants

static NSString *const PackageInfoPlistName = @"packageInfo.plist";
static NSString *const VayneDirName = @"VaynePush";
static NSString *const CommonBundleName = @"common.bundle";

+ (void)downloadPackage:(NSDictionary *)packageInfo {
  
  NSString *md5 = packageInfo[@"md5"];
  NSString *url = packageInfo[@"url"];
  NSString *name = packageInfo[@"name"];
  NSString *type = packageInfo[@"type"];
  NSString *version = packageInfo[@"version"];
  /*
   md5 bundle的md5
   url 下载地址
   name bundle名
   type common buz
   version(patch 版本)
  */
  VaynePushDownloader *downloader = [[VaynePushDownloader alloc] init];
  [downloader downloadBundleWithURL:[NSURL URLWithString:url] onSuccess:^(NSURL * _Nonnull location) {
    
    NSString *fileMD5 = [VaynePushUtils fileMD5:location.path];
    // 比对md5
    if (fileMD5 && [fileMD5 isEqualToString:md5]) {
      //
      NSString *workspaceDir = [[VaynePushUtils DocumentsPath] stringByAppendingPathComponent:VayneDirName];
      NSFileManager *manager = [NSFileManager defaultManager];
      BOOL isDirectory = YES;
      if (![manager fileExistsAtPath:workspaceDir isDirectory:&isDirectory]) {
        [manager createDirectoryAtPath:workspaceDir withIntermediateDirectories:YES attributes:nil error:nil];
      }
      // 以版本号为目录
      NSString *versionDir = [workspaceDir stringByAppendingPathComponent:[VaynePushUtils getAppVersion]];
      if (![manager fileExistsAtPath:versionDir isDirectory:&isDirectory]) {
        [manager createDirectoryAtPath:versionDir withIntermediateDirectories:YES attributes:nil error:nil];
      }
      NSString *bunderPath = @"";
      if ([type isEqualToString:@"common"]) {
        bunderPath = [versionDir stringByAppendingPathComponent:[NSString stringWithFormat:@"common%@.bundle",version]];
      }else {
        bunderPath = [versionDir stringByAppendingPathComponent:[NSString stringWithFormat:@"buz_%@_%@.bundle",name,version]];
      }
      NSError *err = nil;
      if ([manager fileExistsAtPath:bunderPath isDirectory:nil]) {
        [manager removeItemAtPath:bunderPath error:&err];
      }
      [manager moveItemAtPath:location.path toPath:bunderPath error:&err];
    }
  } onProgress:^(float progress) {
    
  } onFailed:^(NSError * _Nonnull error) {
    
  }];

}

+ (NSString *)getPackageInfoPlistPath {
  
  NSString *workspaceDir = [[VaynePushUtils DocumentsPath] stringByAppendingPathComponent:VayneDirName];
  return [workspaceDir stringByAppendingPathComponent:PackageInfoPlistName];
  
}

// 根据当前版本号检查
+ (void)checkPushPackage {
  // 工作目录
  NSString *workspaceDir = [[VaynePushUtils DocumentsPath] stringByAppendingPathComponent:VayneDirName];
  NSFileManager *manager = [NSFileManager defaultManager];
  BOOL isDirectory = YES;
  if (![manager fileExistsAtPath:workspaceDir isDirectory:&isDirectory]) {
    [manager createDirectoryAtPath:workspaceDir withIntermediateDirectories:YES attributes:nil error:nil];
  }
  
  // 版本号目录
  NSString *versionDir = [workspaceDir stringByAppendingPathComponent:[VaynePushUtils getAppVersion]];
  if (![manager fileExistsAtPath:versionDir isDirectory:&isDirectory]) {
    //创建当前版本号目录 删除上一个版本号的目录
    [manager createDirectoryAtPath:versionDir withIntermediateDirectories:YES attributes:nil error:nil];
    //移动 mainBundle里的common bundle到工作目录里
    NSString *commonBundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:CommonBundleName];
    NSString *workspaceCommonBundlePath = [versionDir stringByAppendingPathComponent:CommonBundleName];
    [manager copyItemAtPath:commonBundlePath toPath:workspaceCommonBundlePath error:nil];
    //创建plist文件
    if (![manager fileExistsAtPath:[self getPackageInfoPlistPath] isDirectory:nil]) {
       NSDictionary *packageInfoDict = @{
         @"version":[VaynePushUtils getAppVersion],
         @"common":@{
             @"name":@"common",
             @"version":@"",
         },
         @"buz":@[
                  @{
                    @"name":@"buz_a",
                    @"version":@"1.0.0",
                    @"preLoad":@(YES),
                  },
                  @{
                    @"name":@"buz_b",
                    @"version":@"1.0.0",
                    @"preLoad":@(YES),
                  },
                  @{
                    @"name":@"buz_c",
                    @"version":@"1.0.0",
                    @"preLoad":@(NO),
                  }
         ]
       };
       [packageInfoDict writeToFile:[self getPackageInfoPlistPath] atomically:YES];
     }
  }
  
}

+ (NSString *)getVersionPath {
  
  NSString *workspaceDir = [[VaynePushUtils DocumentsPath] stringByAppendingPathComponent:VayneDirName];
  NSString *versionDir = [workspaceDir stringByAppendingPathComponent:[VaynePushUtils getAppVersion]];
  return versionDir;
  
}

+ (NSDictionary *)getCommonBundleInfo {
    
  NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:[self getPackageInfoPlistPath]];
  if (plistDict[@"common"]) {
    NSString *name = plistDict[@"common"][@"name"];
    NSString *version = plistDict[@"common"][@"version"];
    NSString *bundlePath = [[self getVersionPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.bundle",name,version]];
    return @{
      @"bundleURL": [NSURL URLWithString:bundlePath],
      @"bundleName":name
    };
  }
  return nil;
  
}

// 所有的业务包信息
+ (NSArray *)getBuzBundlesInfo {
    
  NSMutableArray *mArr = [NSMutableArray array];
  NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:[self getPackageInfoPlistPath]];
  if (plistDict[@"buz"]) {
    NSArray *buzs = plistDict[@"buz"];
    for (NSDictionary *dict in buzs) {
      NSString *name = dict[@"name"];
      NSString *version = dict[@"version"];
      NSString *bundlePath = [[self getVersionPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"buz_%@_%@.bundle",name,version]];
      if ([dict[@"preLoad"] boolValue]) {
        NSDictionary *bundleInfo =  @{
                @"bundleURL": [NSURL URLWithString:bundlePath],
                @"bundleName":name,
                @"preLoad": dict[@"preLoad"]
              };
           [mArr addObject:bundleInfo];
      }
    }
  }
  return [mArr copy];
  
}


+ (NSDictionary *)getBuzBundleInfoWithName:(NSString *)bundleName {
  
    NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:[self getPackageInfoPlistPath]];
    NSDictionary *bundleInfo = nil;
    if (plistDict[@"buz"]) {
      NSArray *buzs = plistDict[@"buz"];
      for (NSDictionary *dict in buzs) {
        NSString *name = dict[@"name"];
        NSString *version = dict[@"version"];
        NSString *bundlePath = [[self getVersionPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"buz_%@_%@.bundle",name,version]];
        if ([name isEqualToString:bundleName]) {
          bundleInfo =  @{
            @"bundleURL": [NSURL URLWithString:bundlePath],
            @"bundleName":name,
            @"preLoad": dict[@"preLoad"]
          };
          break;
        }
      }
    }
    return bundleInfo;
  
}



+ (void)updatePackageInfoPlistWithDict:(NSDictionary *)dict {
  
  NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:[self getPackageInfoPlistPath]];
  
  NSString *type = dict[@"type"];
  if ([type isEqualToString:@"common"]) {
    // 主包
    
  }else if ([type isEqualToString:@"buz"]){
    // 业务包
    
  }
  
  
  [plistDict writeToFile:[self getPackageInfoPlistPath] atomically:YES];
  
}


@end
