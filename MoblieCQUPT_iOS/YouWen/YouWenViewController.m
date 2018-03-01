//
//  YouWenViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenViewController.h"
#import "YouWenTableViewCell.h"
#import "YouWenSortViewController.h"
#import "SegmentView.h"
@interface YouWenViewController ()
@property (strong, nonatomic) UIButton *askBtn;
@end

@implementation YouWenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YouWenSortViewController *emtionView = [[YouWenSortViewController alloc] initViewStyle:@"情感"];
    emtionView.title = @"情感";
    YouWenSortViewController *otherView = [[YouWenSortViewController alloc] initViewStyle:@"其他"];
    otherView.title = @"其他";
    YouWenSortViewController *learningView = [[YouWenSortViewController alloc] initViewStyle:@"学习"];
    learningView.title = @"学习";
    YouWenSortViewController *allView = [[YouWenSortViewController alloc] initViewStyle:@"全部"];
    allView.title = @"全部";
    NSArray *views = @[emtionView, otherView, learningView, allView];
    SegmentView *segView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 48) andControllers:views];
    [self.view addSubview:segView];
    _askBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_askBtn setImage:[UIImage imageNamed:@"AskQuestion"] forState:UIControlStateNormal];
    _askBtn.frame = CGRectMake(ScreenWidth - 80, segView.height - 80, 50, 50);
    [_askBtn addTarget:self action:@selector(setNewQuestion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_askBtn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"inform"] style:UIBarButtonItemStylePlain target:self action:@selector(sdf)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sort"] style:UIBarButtonItemStylePlain target:self action:@selector(sdf)];
}
- (void)setNewQuestion{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
