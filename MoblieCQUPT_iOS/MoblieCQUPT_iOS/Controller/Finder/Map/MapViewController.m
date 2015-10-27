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
    
    [_mapWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://map.baidu.com/mobile/webapp/place/detail/qt=ninf&wd=%E9%87%8D%E5%BA%86%E9%82%AE%E7%94%B5%E5%A4%A7%E5%AD%A6&c=132&searchFlag=bigBox&version=5&exptype=dep&src_from=webapp_all_bigbox&nb_x=11868605&nb_y=3422975&center_rank=1&uid=844a750e01b56cba626858cd&industry=education&qid=9839006734857167438/showall=1&pos=0&da_ref=listclk&da_qrtp=11&detail_from=list&third_party=webapp-aladdin&vt=map"]]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"重邮地图";
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

@end
