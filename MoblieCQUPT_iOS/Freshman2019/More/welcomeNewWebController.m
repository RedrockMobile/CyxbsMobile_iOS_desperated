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
@interface welcomeNewWebController ()

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
    WKWebView * webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    NSURL * url = [NSURL URLWithString:@"https://web.redrock.team/welcome2019/mobile/"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];

    [webView loadRequest:request];
    [self.view addSubview:webView];
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
