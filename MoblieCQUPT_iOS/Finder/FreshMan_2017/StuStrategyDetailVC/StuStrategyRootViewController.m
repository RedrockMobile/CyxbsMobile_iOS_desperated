//
//  StuStrategyRootViewController.m
//  TestLayoutButton
//
//  Created by helloworld on 2017/8/4.
//  Copyright © 2017年 topkid. All rights reserved.
//
#import "SegmentView.h"

#import "StuStrategyRootViewController.h"

//8个VC
#import "CampusEnvironmentViewController.h"
#import "StuBedroomViewController.h"
#import "CanteenViewController.h"
#import "IntroductionViewController.h"
#import "QQGroupViewController.h"
#import "DailyLifeViewController.h"
#import "FoodViewController.h"
#import "BeautyViewController.h"

@interface StuStrategyRootViewController ()<SegmentViewScrollerViewDelegate>
@property NSArray *VCArray;
@end

@implementation StuStrategyRootViewController
bool array[8];

- (void)viewDidLoad {
    for (int i = 1; i<8; i++){
        array[i] = false;
    }
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    CampusEnvironmentViewController *VC1 = [[CampusEnvironmentViewController alloc] init];
    VC1.title = @"校园环境";
    StuBedroomViewController *VC2 = [[StuBedroomViewController alloc] init];
    VC2.title = @"学生寝室";
    CanteenViewController *VC3 = [[CanteenViewController alloc] init];
    VC3.title = @"学校食堂";
    IntroductionViewController *VC4 = [[IntroductionViewController alloc] init];
    VC4.title = @"入学须知";
    QQGroupViewController *VC5 = [[QQGroupViewController alloc] init];
    VC5.title = @"QQ群";
    DailyLifeViewController *VC6 = [[DailyLifeViewController alloc] init];
    VC6.title = @"日常生活";
    FoodViewController *VC7 = [[FoodViewController alloc] init];
    VC7.title = @"周边美食";
    BeautyViewController *VC8 = [[BeautyViewController alloc] init];
    VC8.title = @"周边美景";

     self.VCArray = [[NSArray alloc] initWithObjects:VC1, VC2, VC3, VC4, VC5, VC6, VC7, VC8, nil];
    
//    TopTabView *topTabView = [[TopTabView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) withTitle:VCArray];
//    
//    [self.view addSubview:topTabView];
    
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.bounds.size.height - 20) andControllers:self.VCArray];
    segmentView.eventDelegate = self;
    [self.VCArray[0] getData];
    array[0] = true;
    [self.view addSubview:segmentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.VCArray[index] viewWillAppear:YES];
    if (!array[index]) {
        if ([self.VCArray[index] respondsToSelector:@selector(getData)]) {
            [self.VCArray[index] getData];
        }
        array[index] = true;
    }
    
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
