//
//  ExamTotalViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/5.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "ExamTotalViewController.h"
#import "ExamSegementView.h"
#import "ExamScheduleViewController.h"
#import "ExamGradeViewController.h"
#import "MakeUpExamViewController.h"
#import "SYCSegmentView.h"

@interface ExamTotalViewController ()

@end

@implementation ExamTotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    ExamGradeViewController *view2 = [[ExamGradeViewController alloc] init];
    view2.title = @"成绩";
    ExamScheduleViewController *view1 = [[ExamScheduleViewController alloc] init];
    view1.title = @"考试安排";
    MakeUpExamViewController *view3 = [[MakeUpExamViewController alloc] init];
    view3.title = @"补考安排";
    NSArray *viewArray = @[view1,view2,view3];
    
    SYCSegmentView *semgent = [[SYCSegmentView alloc] initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - HEADERHEIGHT) controllers:viewArray type:SYCSegmentViewTypeNormal];
    [self.view addSubview:semgent];
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
