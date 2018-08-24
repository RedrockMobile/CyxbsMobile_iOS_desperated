//
//  MainViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/20.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavigationController.h"
@interface MainViewController ()
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titles = @[@"课表",@"社区",@"迎新",@"发现",@"我的"];
    NSArray *images = @[@"tabbar_image_timetable",@"tabbar_image_community",@"freshman_button",@"tabbar_image_find",@"tabbar_image_mine"];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor colorWithHexString:@"788EFA"];
    
    
    for (int i = 0; i<self.viewControllers.count; i++) {
        BaseNavigationController *nvc = self.viewControllers[i];
        nvc.topViewController.title = titles[i];
        UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
        backItem.title=@"";
        nvc.topViewController.navigationItem.backBarButtonItem = backItem;
        nvc.tabBarItem.image = [UIImage imageNamed:images[i]];
        
        if (i == 2) {
            nvc.tabBarItem.selectedImage = [[UIImage imageNamed:@"freshman_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nvc.tabBarItem.image = [[UIImage imageNamed:@"freshman_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nvc.tabBarItem.imageInsets = UIEdgeInsetsMake(-10, 0, 10, 0);
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchSplash:) name:@"touchSplash" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchSplash:(NSNotification *)notification{
    NSString *target_url = notification.object;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:target_url]]];
    BaseViewController *vc = [[BaseViewController alloc]init];
    [vc.view addSubview:webView];
    vc.hidesBottomBarWhenPushed = YES;
    BaseNavigationController *nvc = [self.viewControllers firstObject];
    [nvc pushViewController:vc animated:YES];
}

@end
