//
//  CommunityViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/28.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "CommunityViewController.h"

@interface CommunityViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _communityWebView.delegate = self;
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.frame = CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H);
    [_indicatorView setCenter:CGPointMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H/2)];
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
    [_communityWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://hongyan.cqupt.edu.cn/MagicLoop/index.php?s=/addon/WeiSite/WeiSite/index/token/gh_68f0a1ffc303/openid/ouRCyjrIXf3rI-MsXA2oDF7bzuu8.html"]]];
    
    _communityWebView.scalesPageToFit = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_indicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
