//
//  BeautyOrganizationViewController.m
//  FreshManFeature
//
//  Created by hzl on 16/8/11.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "BeautyOrganizationViewController.h"
#import "BeautyOrganizationView.h"

@interface BeautyOrganizationViewController ()

@end

@implementation BeautyOrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BeautyOrganizationView *bov = [[BeautyOrganizationView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) withTitle:@[@"团委直属部门",@"红岩网校工作站",@"校学生会",@"科技联合会",@"社团联合会",@"青年志愿者协会",@"大学生艺术团"]];
    
    [self.view addSubview:bov];
    
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
