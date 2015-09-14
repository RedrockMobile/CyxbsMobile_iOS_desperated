//
//  ChuangyeViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/28.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "ChuangyeViewController.h"

@interface ChuangyeViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation ChuangyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _chuangyeWebView.delegate = self;
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.frame = CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H);
    [_indicatorView setCenter:CGPointMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H/2)];
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];

    [_chuangyeWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://hongyan.cqupt.edu.cn/microstore/index.php/home/view/index.html?goods_id=5"]]];
    
    _chuangyeWebView.scalesPageToFit = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"我要创业";
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_indicatorView stopAnimating];
}

@end
