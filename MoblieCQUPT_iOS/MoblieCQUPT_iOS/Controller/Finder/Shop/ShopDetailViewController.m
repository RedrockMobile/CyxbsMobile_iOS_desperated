//
//  ShopDetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/19.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"
#import "WebViewController.h"
#import "NetWork.h"
#import "ProgressHUD.h"
#import "MenuViewController.h"

@interface ShopDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *detailDishButton;
@property (strong, nonatomic) NSMutableArray *menu;

@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_picture setImageWithURL:[NSURL URLWithString:_detailData[@"shopimg_src"]]];
    _nameLabel.text = _detailData[@"name"];
    _addressLabel.text = _detailData[@"shop_address"];
    _menu = [[NSMutableArray alloc] init];
    
    if (_detailData) {
        [_detailDishButton addTarget:self
                              action:@selector(displayDetailDish) forControlEvents:UIControlEventTouchUpInside];
    }
}

//显示详细菜单
- (void)displayDetailDish{
    if (_detailData) {
        MenuViewController *mvc = [[MenuViewController alloc] init];
        mvc.shopId = _detailData[@"id"] ;
        [self presentViewController:mvc
                           animated:YES
                         completion:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scrollView.frame = [UIScreen mainScreen].bounds;
//    [self.scrollView setContentSize:CGSizeMake(MAIN_SCREEN_W, MAIN_SCREEN_H * 1.3)];
}

@end
