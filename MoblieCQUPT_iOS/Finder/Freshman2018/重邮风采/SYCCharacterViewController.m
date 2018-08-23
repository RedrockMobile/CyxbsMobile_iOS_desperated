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
#import "SYCSegmentView.h"
#import "SYCOrganizationViewController.h"
#import "SYCActivityManager.h"
#import "SYCOrganizationManager.h"

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
    SYCSegmentView *segmentView = [[SYCSegmentView alloc] initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT - HEADERHEIGHT) andControllers:viewsArray andType:SYCSegmentViewTypeNormal];
    [self.view addSubview:segmentView];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"重邮风采";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
    self.callBackHandle();
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
