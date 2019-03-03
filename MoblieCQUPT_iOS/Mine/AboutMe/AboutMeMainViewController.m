//
//  AboutMeMainViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/7.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "AboutMeMainViewController.h"
#import "SYCSegmentView.h"
#import "AboutMeViewController.h"
@interface AboutMeMainViewController ()

@end

@implementation AboutMeMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    AboutMeViewController *allView = [[AboutMeViewController alloc] initViewType:@"3"];
    allView.title = @"全部";
    AboutMeViewController *evaluateView = [[AboutMeViewController alloc] initViewType:@"1"];
    evaluateView.title = @"评论";
    AboutMeViewController *clickView = [[AboutMeViewController alloc] initViewType:@"2"];
    clickView.title = @"点赞";
    NSArray *views = @[allView, evaluateView, clickView];
    for (AboutMeViewController *view in views) {
        view.superController = self;
    }
    SYCSegmentView *segView = [[SYCSegmentView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, SCREENHEIGHT - HEADERHEIGHT) controllers:views type:SYCSegmentViewTypeNormal];
    [self.view addSubview:segView];
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
