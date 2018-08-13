//
//  SYCSubjectViewController.m
//  CQUPTDataAnalyse
//
//  Created by 施昱丞 on 2018/8/10.
//  Copyright © 2018年 shiyucheng. All rights reserved.
//

#import "SYCSubjectViewController.h"
#import "AAChartKit.h"
#import "SYCCollageDataManager.h"

@interface SYCSubjectViewController ()

@end

@implementation SYCSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat columnViewWidth = self.view.frame.size.width - 50;
    CGFloat columnViewHeight = self.view.frame.size.height - 400;
    
    AAChartView *columnView = [[AAChartView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - columnViewWidth) / 2.0, 60, columnViewWidth, columnViewHeight)];
    [self.view addSubview:columnView];
    
    AAChartModel *columnModel = AAObject(AAChartModel).chartTypeSet(AAChartTypeColumn)//设置图表的类型
    .titleSet(@"65分以下人数")
    .titleFontSizeSet(@20.0)
    .animationTypeSet(AAChartAnimationEaseInOutCubic)
    .animationDurationSet(@1200)
    .dataLabelEnabledSet(YES)
    .dataLabelFontSizeSet(@12)
    .yAxisTitleSet(@"")
    .legendEnabledSet(NO)
    .categoriesSet(@[@"高等数学", @"大学物理", @"英语"])
    .seriesSet(@[
            AAObject(AASeriesElement)
                .nameSet(@"65分以下人数")
                .dataSet(@[@85.0, @100, @340]),
                ]);
    [columnView aa_drawChartWithChartModel:columnModel];
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
