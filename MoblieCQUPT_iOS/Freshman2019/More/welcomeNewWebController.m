//
//  welcomeNewWebController.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/23.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "welcomeNewWebController.h"
#import <WebKit/WebKit.h>
#import "LQQwantMoreViewController.h"
@interface welcomeNewWebController () <UIWebViewDelegate>

@property (nonatomic, weak) MBProgressHUD *hud;

@end

@implementation welcomeNewWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildNavagationBar];
    [self addWebView];
    
}
-(void)buildNavagationBar{

    //添加返回按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(clickLeftButton)];
    [self.navigationItem setLeftBarButtonItem:leftButton];

    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"迎新网";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:19];
    [titleView addSubview:titleLabel];
    self.navigationItem.titleView = titleView;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerX.equalTo(titleView);
        make.centerY.equalTo(titleView);
    }];

}
-(void)addWebView{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.backgroundColor = [UIColor whiteColor];
    NSURL * url = [NSURL URLWithString:@"https://wx.idsbllp.cn/game/welcome2019/mobile/#/home"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];

    [webView loadRequest:request];
    [self.view addSubview:webView];
    webView.delegate = self;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"努力加载中";
    self.hud = hud;

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.hud hide:YES];
}

- (void)clickLeftButton{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
