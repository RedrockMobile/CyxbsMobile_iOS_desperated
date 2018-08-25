//
//  SYCOrganizationViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/16.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCOrganizationViewController.h"
#import "SYCOrganizationTableViewController.h"
#import "SegmentView.h"

@interface SYCOrganizationViewController ()

@end

@implementation SYCOrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    SYCOrganizationTableViewController *hywxVC = [[SYCOrganizationTableViewController alloc] init];
    hywxVC.title = @"红岩网校";
    hywxVC.index = 0;
    
    SYCOrganizationTableViewController *twbgsVC = [[SYCOrganizationTableViewController alloc] init];
    twbgsVC.title = @"团委办公室";
    twbgsVC.index = 1;
    
    SYCOrganizationTableViewController *twzzbVC = [[SYCOrganizationTableViewController alloc] init];
    twzzbVC.title = @"团委组织部";
    twzzbVC.index = 2;
    
    SYCOrganizationTableViewController *twxcbVC = [[SYCOrganizationTableViewController alloc] init];
    twxcbVC.title = @"团委宣传部";
    twxcbVC.index = 3;
    
    SYCOrganizationTableViewController *xxshVC = [[SYCOrganizationTableViewController alloc] init];
    xxshVC.title = @"校学生会";
    xxshVC.index = 4;
    
    SYCOrganizationTableViewController *dxsystVC = [[SYCOrganizationTableViewController alloc] init];
    dxsystVC.title = @"大学生艺术团";
    dxsystVC.index = 5;
    
    SYCOrganizationTableViewController *qxVC = [[SYCOrganizationTableViewController alloc] init];
    qxVC.title = @"校青协";
    qxVC.index = 6;
    
    SYCOrganizationTableViewController *slVC = [[SYCOrganizationTableViewController alloc] init];
    slVC.title = @"社团联合会";
    slVC.index = 7;
    
    SYCOrganizationTableViewController *kxVC = [[SYCOrganizationTableViewController alloc] init];
    kxVC.title = @"校科协";
    kxVC.index = 8;
    
    NSArray *organizationsArray = @[hywxVC, twbgsVC, twxcbVC, twzzbVC, xxshVC, dxsystVC, qxVC, slVC, kxVC];
    SegmentView *organizationsSegmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) andControllers:organizationsArray];
    [self.view addSubview:organizationsSegmentView];
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
