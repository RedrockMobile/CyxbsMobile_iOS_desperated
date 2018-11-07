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
    
    NSArray *organizationsArray = self.controllers;
    SYCSegmentView *organizationsSegmentView = [[SYCSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) controllers:organizationsArray type:SYCSegmentViewTypeButton];
    
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
