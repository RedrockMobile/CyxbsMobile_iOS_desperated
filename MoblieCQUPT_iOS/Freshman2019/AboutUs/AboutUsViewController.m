//
//  AboutUsViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/8/8.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController () <UIWebViewDelegate>

@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, weak) MBProgressHUD *hud;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"https://wx.redrock.team/aboutus/mobile.html"];
    self.request = [NSURLRequest requestWithURL:url];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:webView animated:YES];
    hud.yOffset = -64;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"努力加载中";
    self.hud = hud;
    
    [webView loadRequest:self.request];
    [self.view addSubview:webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.hud hide:YES afterDelay:1];
}



@end
