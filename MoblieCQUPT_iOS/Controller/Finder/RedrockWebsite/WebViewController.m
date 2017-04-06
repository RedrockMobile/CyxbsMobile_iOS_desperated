//
//  WebViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/24.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.delegate = self;
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.frame = CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H);
    [_indicatorView setCenter:CGPointMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H/2)];
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://hongyan.cqupt.edu.cn/aboutus/"]]];
    
    _webView.scalesPageToFit = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"红岩门户";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:FONT_COLOR};
    self.navigationController.navigationBar.tintColor = FONT_COLOR;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_indicatorView stopAnimating];
}

@end
