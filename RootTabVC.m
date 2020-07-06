//
//  RootTabVC.m
//  vayne
//
//  Created by 肖怡宁 on 2020/7/1.
//

#import "RootTabVC.h"
#import "OneVC.h"


@interface RootTabVC ()

@end

@implementation RootTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configVCs];
}

- (void)configVCs {
  
  
  
  OneVC *vcOne = [[OneVC alloc] init];
  vcOne.tabBarItem.title = @"One";
  vcOne.view.backgroundColor = [UIColor whiteColor];
  [self addChildViewController:vcOne];
  
  UIViewController *vcTwo = [[UIViewController alloc] init];
  vcTwo.tabBarItem.title = @"Two";
  vcTwo.view.backgroundColor = [UIColor whiteColor];
  [self addChildViewController:vcTwo];
  
  UIViewController *vcThree = [[UIViewController alloc] init];
  vcThree.tabBarItem.title = @"Three";
  vcThree.view.backgroundColor = [UIColor whiteColor];
  [self addChildViewController:vcThree];
  
  self.navigationItem.title = @"One";
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
      

  self.navigationItem.title = item.title;
  
}

@end
