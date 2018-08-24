//
//  WantToSayController.m
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "WantToSayController.h"

#define width [UIScreen mainScreen].bounds.size.width//宽
#define height [UIScreen mainScreen].bounds.size.height//高

@interface WantToSayController ()

@end

@implementation WantToSayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我想对你说";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timg"]];    
    [self viewInit];
}

- (void)viewInit
{
 
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height - 65)];
    _scrollView.bounces = YES;
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景"]];
    _imageView.frame = CGRectMake(0, 0, width, width * 2.568);
    _scrollView.contentSize = CGSizeMake(width, width * 2.5);
    
    [_scrollView addSubview:_imageView];
    
    [self.view addSubview:_scrollView];
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
