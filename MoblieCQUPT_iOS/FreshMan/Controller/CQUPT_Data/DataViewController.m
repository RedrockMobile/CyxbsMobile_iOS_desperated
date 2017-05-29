//
//  DataViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/8/15.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "DataViewController.h"
#import "SexRatioViewController.h"
#import "MajorViewController.h"
#import "GraduateViewController.h"
#import "SegmentView.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    SexRatioViewController *sexRatioVC = [[SexRatioViewController alloc]init];
    MajorViewController *majorVC = [[MajorViewController alloc]init];
    GraduateViewController *graduateVC = [[GraduateViewController alloc]init];
    sexRatioVC.title = @"男女比例";
    majorVC.title = @"最难科目";
    graduateVC.title = @"毕业去向";
    SegmentView *segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) withTitle:@[sexRatioVC,majorVC,graduateVC]];
    [self.view addSubview:segmentView];
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
