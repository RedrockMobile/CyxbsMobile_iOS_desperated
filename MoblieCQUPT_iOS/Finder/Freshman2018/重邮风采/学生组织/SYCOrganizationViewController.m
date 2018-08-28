//
//  SYCOrganizationViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/16.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCOrganizationViewController.h"
#import "SYCOrganizationTableViewController.h"
#import "SYCSegmentView.h"
#import "SYCOrganizationModel.h"
#import "SYCOrganizationManager.h"

@interface SYCOrganizationViewController ()

@property (nonatomic, strong)NSMutableArray *controllers;

@end

@implementation SYCOrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.controllers = [NSMutableArray array];
    
    int i = 0;
    for (SYCOrganizationModel *organization in [SYCOrganizationManager sharedInstance].organizationData) {
        SYCOrganizationTableViewController *controller = [[SYCOrganizationTableViewController alloc] init];
        controller.title = organization.name;
        controller.organization = organization;
        controller.index = i;
        i++;
        [self.controllers addObject:controller];
    }
//    SYCOrganizationTableViewController *hywxVC = [[SYCOrganizationTableViewController alloc] init];
//    hywxVC.title = @"团委办公室";
//    hywxVC.index = 0;
//
//    SYCOrganizationTableViewController *twbgsVC = [[SYCOrganizationTableViewController alloc] init];
//    twbgsVC.title = @"团委组织部";
//    twbgsVC.index = 1;
//
//    SYCOrganizationTableViewController *twzzbVC = [[SYCOrganizationTableViewController alloc] init];
//    twzzbVC.title = @"团委宣传部";
//    twzzbVC.index = 2;
//
//    SYCOrganizationTableViewController *twxcbVC = [[SYCOrganizationTableViewController alloc] init];
//    twxcbVC.title = @"校学生会";
//    twxcbVC.index = 3;
//
//    SYCOrganizationTableViewController *xxshVC = [[SYCOrganizationTableViewController alloc] init];
//    xxshVC.title = @"学生科技联合会";
//    xxshVC.index = 4;
//
//    SYCOrganizationTableViewController *dxsystVC = [[SYCOrganizationTableViewController alloc] init];
//    dxsystVC.title = @"社团联合会";
//    dxsystVC.index = 5;
//
//    SYCOrganizationTableViewController *qxVC = [[SYCOrganizationTableViewController alloc] init];
//    qxVC.title = @"青年志愿者协会";
//    qxVC.index = 6;
//
//    SYCOrganizationTableViewController *slVC = [[SYCOrganizationTableViewController alloc] init];
//    slVC.title = @"红岩网校工作站";
//    slVC.index = 7;
//
//    SYCOrganizationTableViewController *kxVC = [[SYCOrganizationTableViewController alloc] init];
//    kxVC.title = @"大学生艺术团";
//    kxVC.index = 8;
    
    
    NSArray *organizationsArray = self.controllers;
    SYCSegmentView *organizationsSegmentView = [[SYCSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) andControllers:organizationsArray andType:SYCSegmentViewTypeButton];
    
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
