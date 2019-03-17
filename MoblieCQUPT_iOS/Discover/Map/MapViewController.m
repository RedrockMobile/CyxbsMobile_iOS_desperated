//
//  MapViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/9/2.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"重邮地图";
    [_mapWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://720yun.com/t/0e929mp6utn?pano_id=473004"]]];
}


@end
