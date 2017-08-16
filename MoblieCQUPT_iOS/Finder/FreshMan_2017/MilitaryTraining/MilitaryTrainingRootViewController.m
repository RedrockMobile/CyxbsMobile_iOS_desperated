//
//  MilitaryTrainingRootViewController.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2017/8/13.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "SegmentView.h"
#import "MilitaryTrainingRootViewController.h"
#import "MilitaryTrainingTipsViewController.h"
#import "MilitaryTrainingVideoViewController.h"

@interface MilitaryTrainingRootViewController ()

@end

@implementation MilitaryTrainingRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"------------------> = %lf", [UIScreen mainScreen].bounds.size.width);
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    MilitaryTrainingTipsViewController *VC1 = [[MilitaryTrainingTipsViewController alloc] init];
    VC1.title = @"军训贴士";
    
    MilitaryTrainingVideoViewController *VC2 = [[MilitaryTrainingVideoViewController alloc] init];
    VC2.title = @"军训风采";
    
    NSArray *VCArray = [[NSArray alloc] initWithObjects:VC1, VC2, nil];
    
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.bounds.size.height - 20) andControllers:VCArray];
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
