//
//  ZJWebViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 周杰 on 2018/3/26.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ZJWebViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKUIDelegate.h>
#import <WebKit/WKNavigationDelegate.h>
#define STATUSBARHEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define HEADERHEIGHT (STATUSBARHEIGHT+NVGBARHEIGHT)
#define NVGBARHEIGHT (44)
@interface ZJWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (strong, nonatomic) UIActivityIndicatorView *teleView;
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation ZJWebViewController

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT-HEADERHEIGHT)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
           [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://eini.cqupt.edu.cn"]]];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _teleView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _teleView.frame = CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H);
    [_teleView setCenter:CGPointMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H/2)];
    [_teleView startAnimating];
    [self.webView addSubview:_teleView];
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [_teleView stopAnimating];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
