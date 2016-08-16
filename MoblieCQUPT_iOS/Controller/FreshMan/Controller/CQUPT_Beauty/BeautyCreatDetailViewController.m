//
//  BeautyCreatDetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/8/16.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "BeautyCreatDetailViewController.h"

@interface BeautyCreatDetailViewController () <UIWebViewDelegate>

@end

@implementation BeautyCreatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigation {
    UIView *naviBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    
    naviBack.backgroundColor = MAIN_COLOR;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLabel.text = @"原创重邮";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(ScreenWidth/2, 42);
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn sizeToFit];
    cancelBtn.center = CGPointMake(15 + cancelBtn.frame.size.width/2, 42);
    [cancelBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];

    [naviBack addSubview:cancelBtn];
    [naviBack addSubview:titleLabel];
    [self.view addSubview:naviBack];
}
- (void)clickCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setVideoUrlStr:(NSString *)videoUrlStr {
    NSURL *movieUrl = [NSURL URLWithString:videoUrlStr];
    
    UIWebView *videoView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    videoView.scalesPageToFit = YES;
    videoView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:movieUrl];
    
    [videoView loadRequest:request];
    
    [self.view addSubview:videoView];
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
