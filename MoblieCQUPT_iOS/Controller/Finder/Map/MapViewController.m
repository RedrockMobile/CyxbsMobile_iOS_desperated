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
    
    [_mapWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://720yun.com/t/0e929mp6utn?pano_id=473004"]]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"重邮地图";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:FONT_COLOR};
    self.navigationController.navigationBar.tintColor = FONT_COLOR;
    self.tabBarController.tabBar.hidden = YES;
}

@end
