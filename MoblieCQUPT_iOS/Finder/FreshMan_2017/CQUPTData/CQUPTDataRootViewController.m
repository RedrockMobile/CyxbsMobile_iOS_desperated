//
//  CQUPTDataRootViewController.m
//  TestLayoutButton
//
//  Created by helloworld on 2017/8/5.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "CQUPTDataRootViewController.h"

#import "PrefixHeader.pch"

#import "SegmentView.h"

//3个VC
#import "MaleToFemaleRatioViewController.h"
#import "MostDifficultSubjectsViewController.h"
#import "EmploymentRateViewController.h"

@interface CQUPTDataRootViewController ()<SegmentViewScrollerViewDelegate>

@property (strong, nonatomic) NSArray *VCArray;

@end

@implementation CQUPTDataRootViewController

- (void)viewDidLoad {

    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    MaleToFemaleRatioViewController *VC1 = [[MaleToFemaleRatioViewController alloc] init];
    VC1.title = @"男女比例";
    
    MostDifficultSubjectsViewController *VC2 = [[MostDifficultSubjectsViewController alloc] init];
    VC2.title = @"最难科目";
    
    EmploymentRateViewController *VC3 = [[EmploymentRateViewController alloc] init];
    VC3.title = @"就业率";
    
    NSArray *VCArray = [[NSArray alloc] initWithObjects:VC1, VC2, VC3, nil];
    self.VCArray = VCArray;
    
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.bounds.size.height - 20) andControllers:VCArray];
    segmentView.eventDelegate = self;
    [self.view addSubview:segmentView];
}

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index{
    if (index == 2) {
        [self.VCArray[index] getData];
    }
    
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
