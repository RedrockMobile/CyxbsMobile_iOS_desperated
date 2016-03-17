//
//  AnnexViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/3/16.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "AnnexViewController.h"

@interface AnnexViewController ()

@end

@implementation AnnexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_AnnexWebView loadRequest:urlRequest];
    
    _AnnexWebView.scalesPageToFit = YES;
}

@end
