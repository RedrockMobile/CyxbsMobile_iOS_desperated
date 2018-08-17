//
//  SYCCharacterViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/16.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCCharacterViewController.h"
#import "SYCActivityTableViewController.h"
#import "SYCOrganizationTableViewController.h"
#import "SegmentView.h"
#import "SYCOrganizationViewController.h"

@interface SYCCharacterViewController ()

@end

@implementation SYCCharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SYCOrganizationViewController *organVC = [[SYCOrganizationViewController alloc] init];
    organVC.title = @"学生组织";
    
    SYCActivityTableViewController *activityVC = [[SYCActivityTableViewController alloc] init];
    activityVC.title = @"大型活动";
    
    NSArray *viewsArray = @[organVC, activityVC];
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT - HEADERHEIGHT) andControllers:viewsArray];
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
