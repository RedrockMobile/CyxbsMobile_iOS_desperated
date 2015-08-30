//
//  FinderViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/25.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "FinderViewController.h"
#import "ShopViewController.h"
#import "WebViewController.h"
#import "IntroductionViewController.h"

@interface FinderViewController ()

@end

@implementation FinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shopButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [_shopButton setTitle:@"周边商店" forState:UIControlStateNormal];
    [_shopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _shopButton.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [_shopButton addTarget:self
                    action:@selector(enterShop)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shopButton];
    
    _webButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 30)];
    [_webButton setTitle:@"红岩门户" forState:UIControlStateNormal];
    [_webButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _webButton.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [_webButton addTarget:self
                    action:@selector(enterWeb)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_webButton];
    
    _introductionButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 30)];
    [_introductionButton setTitle:@"新生专题" forState:UIControlStateNormal];
    [_introductionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _introductionButton.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    
    [_introductionButton addTarget:self
                            action:@selector(enterIntroduction)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_introductionButton];
    // Do any additional setup after loading the view from its nib.
}

- (void)enterShop{
    ShopViewController *svc = [[ShopViewController alloc] init];
    [self.navigationController pushViewController:svc
                                         animated:YES];
}

- (void)enterWeb{
    WebViewController *wvc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    [self.navigationController pushViewController:wvc
                                         animated:YES];
}

- (void)enterIntroduction{
    IntroductionViewController *ivc = [[IntroductionViewController alloc] init];
    [self.navigationController pushViewController:ivc
                                         animated:YES];
}

@end