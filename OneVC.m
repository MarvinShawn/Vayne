//
//  OneVC.m
//  vayne
//
//  Created by 肖怡宁 on 2020/7/1.
//

#import "OneVC.h"
#import <React/RCTRootView.h>
#import "VayneJSBridgeManager.h"
#import "VaynePushPackage.h"
#import "VaynePush.h"

@interface OneVC ()

@end

@implementation OneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    // Do any additional setup after loading the view.
}

- (void)configUI {
  
  
  UIButton *buzABtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 30)];
  [buzABtn setTitle:@"业务a" forState:UIControlStateNormal];
  [buzABtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  buzABtn.tag = 1;
  [self.view addSubview:buzABtn];
  [buzABtn addTarget:self action:@selector(navigationAction:) forControlEvents:UIControlEventTouchUpInside];
  
  
  UIButton *buzBBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 30)];
  [buzBBtn setTitle:@"业务b" forState:UIControlStateNormal];
  [buzBBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  buzBBtn.tag = 2;
  [self.view addSubview:buzBBtn];
  [buzBBtn addTarget:self action:@selector(navigationAction:) forControlEvents:UIControlEventTouchUpInside];
  
  
  UIButton *buzCBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 100, 30)];
  [buzCBtn setTitle:@"业务c" forState:UIControlStateNormal];
  [buzCBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  buzCBtn.tag = 3;
  [self.view addSubview:buzCBtn];
  [buzCBtn addTarget:self action:@selector(navigationAction:) forControlEvents:UIControlEventTouchUpInside];
  
  
}


- (void)navigationAction:(UIButton *)btn {
  
  
  NSString *bundleName = @"buz_a";
  NSString *bundleRoot = @"src/business_a/index";
  switch (btn.tag) {
    case 1:
      bundleName = @"buz_a";
      bundleRoot = @"src/business_a/index";
      break;
    case 2:
      bundleName = @"buz_b";
      bundleRoot = @"src/business_b/index";
      break;
    case 3:
      bundleName = @"buz_c";
      bundleRoot = @"src/business_c/index";
      break;
    default:
      break;
  }
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[VaynePush bridgeForMetroBundleWithBundleRoot:bundleRoot] moduleName:bundleName initialProperties:nil];
  UIViewController *vc = [[UIViewController alloc] init];
  vc.view = rootView;
  [self.tabBarController.navigationController pushViewController:vc animated:YES];
  
  /*
  [VaynePush loadBuzWithName:bundleName onSuccess:^(RCTBridge * _Nonnull bridge) {
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:bundleName initialProperties:nil];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
  } onFailed:^(NSError * _Nonnull error) {
    
  }];
   */
  
  /*
   
   [[VayneJSBridgeManager sharedInstance] loadBuzBundleWithName:bundleName onSuccess:^(RCTBridge * _Nonnull bridge) {
      

      
    } onFailed:^(NSError * _Nonnull error) {
      NSLog(@"error = %@",error);
    }];
  NSDictionary *dict = @{
    @"url":@"https://marvinx.oss-cn-shenzhen.aliyuncs.com/topic/300x0w.jpg",
    @"md5":@"de3b7c5f47c1e88bc31cfcb09fc4b1e8",
    @"name":@"home",
    @"type":@"buz",
    @"version":@"2.0",
  };
   */

  
}



@end
