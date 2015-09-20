//
//  CommunityViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/28.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "CommunityViewController.h"

@interface CommunityViewController ()

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_communityWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://hongyan.cqupt.edu.cn/MagicLoop/index.php?s=/addon/WeiSite/WeiSite/index/token/gh_68f0a1ffc303/openid/ouRCyjrIXf3rI-MsXA2oDF7bzuu8.html"]]];
    
    _communityWebView.scalesPageToFit = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"重邮社区";
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

@end
