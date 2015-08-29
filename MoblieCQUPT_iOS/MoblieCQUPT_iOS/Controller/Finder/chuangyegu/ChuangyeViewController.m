//
//  ChuangyeViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/28.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "ChuangyeViewController.h"

@interface ChuangyeViewController ()

@end

@implementation ChuangyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_chuangyeWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://hongyan.cqupt.edu.cn/microstore/index.php/home/view/index.html?goods_id=5"]]];
    
    _chuangyeWebView.scalesPageToFit = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
