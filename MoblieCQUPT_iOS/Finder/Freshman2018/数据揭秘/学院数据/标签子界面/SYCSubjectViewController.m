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

@property (nonatomic, strong)AAChartView *columnView;
@property (nonatomic, strong)AAChartModel *columnModel;

@end

@implementation SYCSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat columnViewWidth = self.view.frame.size.width * 0.9;
    CGFloat columnViewHeight = self.view.frame.size.height * 0.4;
    
    CGFloat columnViewBackgroudWidth = columnViewWidth * 1.05;
    CGFloat columnViewBackgroudHeight = columnViewHeight * 1.2;
    
    self.view.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    
    UIView *columnViewBackgroud = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - columnViewBackgroudWidth) / 2.0, 10, columnViewWidth * 1.05, columnViewHeight * 1.05)];
    columnViewBackgroud.backgroundColor = [UIColor whiteColor];
    columnViewBackgroud.layer.cornerRadius = 16;
    columnViewBackgroud.layer.masksToBounds = YES;
    columnViewBackgroud.layer.shadowOffset = CGSizeMake(2, 5);
    columnViewBackgroud.layer.shadowOpacity = 0.1;
    columnViewBackgroud.layer.shadowColor = [UIColor grayColor].CGColor;
    [self.view addSubview:columnViewBackgroud];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(columnViewBackgroudWidth * 0.07, columnViewBackgroudHeight * 0.02, columnViewBackgroudWidth, columnViewBackgroudHeight * 0.08)];
    nameLabel.text = [NSString stringWithFormat:@"2017-2018学年第二学期挂科率"];
    nameLabel.textColor = [UIColor colorWithRed:80.0/255.0 green:161.0/255.0 blue:250.0/255.0 alpha:1.0];
    nameLabel.font = [UIFont systemFontOfSize:16];
    [columnViewBackgroud addSubview:nameLabel];
    
    UIView *labelImage = [[UIImageView alloc] initWithFrame:CGRectMake(columnViewBackgroudWidth * 0.04, columnViewBackgroudHeight * 0.041, columnViewBackgroudWidth * 0.01, columnViewBackgroudHeight * 0.04)];
    labelImage.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:161.0/255.0 blue:250.0/255.0 alpha:1.0];
    labelImage.layer.cornerRadius = 2;
    labelImage.layer.masksToBounds = YES;
    [columnViewBackgroud addSubview:labelImage];
    
    self.columnView = [[AAChartView alloc] initWithFrame:CGRectMake((columnViewBackgroudWidth - columnViewWidth) / 2.0, columnViewBackgroudHeight * 0.1, columnViewWidth, columnViewHeight)];
    [columnViewBackgroud addSubview:self.columnView];
    NSNumber *data1 = [NSNumber numberWithDouble:[[self.data.subjects[0] objectForKey:@"below_amount"] doubleValue] / 1000.0];
    NSNumber *data2 = [NSNumber numberWithDouble:[[self.data.subjects[1] objectForKey:@"below_amount"] doubleValue] / 1000.0];
    NSNumber *data3 = [NSNumber numberWithDouble:[[self.data.subjects[2] objectForKey:@"below_amount"] doubleValue] / 1000.0];
    
    self.columnModel = AAObject(AAChartModel).chartTypeSet(AAChartTypeColumn)//设置图表的类型
    .titleSet(@"")
    .titleFontSizeSet(@20.0)
    .animationTypeSet(AAChartAnimationEaseInOutCubic)
    .animationDurationSet(@1200)
    .dataLabelEnabledSet(YES)
    .dataLabelFontSizeSet(@12)
    .yAxisTitleSet(@"")
    .legendEnabledSet(NO)
    .colorsThemeSet(@[@"#abd2ff", @"#ffabd7"])
    .categoriesSet(@[[self.data.subjects[0] objectForKey:@"subject_name"], [self.data.subjects[1] objectForKey:@"subject_name"], [self.data.subjects[2] objectForKey:@"subject_name"]])
    .seriesSet(@[
            AAObject(AASeriesElement)
                .nameSet(@"挂科率")
                .dataSet(@[data1, data2, data3]),
                ]);
    [self.columnView aa_drawChartWithChartModel:self.columnModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reflesh{
    [self.columnView aa_refreshChartWithChartModel:self.columnModel];
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
