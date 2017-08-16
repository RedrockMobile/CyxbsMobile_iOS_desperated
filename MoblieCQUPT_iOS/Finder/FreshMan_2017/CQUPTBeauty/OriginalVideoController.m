//
//  OriginalControllerViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/10.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "OriginalVideoController.h"
#import "PrefixHeader.pch"
@interface OriginalVideoController ()<UIWebViewDelegate>

@end

@implementation OriginalVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setVideoView];
    // Do any additional setup after loading the view.
}

- (void)setVideoView{
    UIImageView *back =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    back.image = [UIImage imageNamed:@"all_image_background"];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn sizeToFit];
    cancelBtn.center = CGPointMake(15 + cancelBtn.frame.size.width/2, 42);
    [cancelBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    [self.view addSubview:cancelBtn];
}

-(void)clickCancel{
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
