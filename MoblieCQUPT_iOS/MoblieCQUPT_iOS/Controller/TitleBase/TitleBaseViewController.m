//
//  TitleBaseViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/8/20.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "TitleBaseViewController.h"

@interface TitleBaseViewController ()

@end

@implementation TitleBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];
    // Do any additional setup after loading the view from its nib.
}

- (void)initTitleView {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    imageView.backgroundColor = MAIN_COLOR;
    [self.view addSubview:imageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:24];
    
    [self.view addSubview:_titleLabel];
    
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
