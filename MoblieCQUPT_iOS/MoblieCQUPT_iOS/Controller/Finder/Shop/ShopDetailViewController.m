//
//  ShopDetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/19.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "ShopDetailViewController.h"

@interface ShopDetailViewController ()


@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_picture setImageWithURL:[NSURL URLWithString:_detailData[@"shopimg_src"]]];
    _nameLabel.text = _detailData[@"name"];
    _addressLabel.text = _detailData[@"shop_address"];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewDidAppear:(BOOL)animated{
    self.scrollView.frame = [UIScreen mainScreen].bounds;
//    [self.scrollView setContentSize:CGSizeMake(MAIN_SCREEN_W, MAIN_SCREEN_H * 1.3)];
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
