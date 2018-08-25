//
//  SYCSexRatioViewController.m
//  CQUPTDataAnalyse
//
//  Created by 施昱丞 on 2018/8/9.
//  Copyright © 2018年 shiyucheng. All rights reserved.
//

#import "SYCSexRatioViewController.h"
#import "AAChartKit.h"


@interface SYCSexRatioViewController ()

@property (nonatomic)NSNumber *numOfBoys;
@property (nonatomic)NSNumber *numOfGirls;
@property (nonatomic, strong)AAChartView *pieView;
@property (nonatomic, strong)AAChartModel *pieModel;

@end

@implementation SYCSexRatioViewController

@synthesize data, numOfBoys, numOfGirls;

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat pieViewWidth = self.view.frame.size.width * 0.9;
    CGFloat pieViewHeight = self.view.frame.size.height * 0.4;
    
    CGFloat pieViewBackgroudWidth = pieViewWidth * 1.05;
    CGFloat pieViewBackgroudHeight = pieViewHeight * 1.2;
    
    self.view.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    
    UIView *pieViewBackgroud = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - pieViewBackgroudWidth) / 2.0, 10, pieViewWidth * 1.05, pieViewHeight * 1.05)];
    pieViewBackgroud.backgroundColor = [UIColor whiteColor];
    pieViewBackgroud.layer.cornerRadius = 16;
    pieViewBackgroud.layer.masksToBounds = YES;
    pieViewBackgroud.layer.shadowOffset = CGSizeMake(2, 5);
    pieViewBackgroud.layer.shadowOpacity = 0.1;
    pieViewBackgroud.layer.shadowColor = [UIColor grayColor].CGColor;
    [self.view addSubview:pieViewBackgroud];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(pieViewBackgroudWidth * 0.07, pieViewBackgroudHeight * 0.02, pieViewBackgroudWidth, pieViewBackgroudHeight * 0.08)];
    nameLabel.text = [NSString stringWithFormat:@"%@男女比例", data.name];
    nameLabel.textColor = [UIColor colorWithRed:80.0/255.0 green:161.0/255.0 blue:250.0/255.0 alpha:1.0];
    nameLabel.font = [UIFont systemFontOfSize:16];
    [pieViewBackgroud addSubview:nameLabel];
    
    UIView *labelImage = [[UIImageView alloc] initWithFrame:CGRectMake(pieViewBackgroudWidth * 0.04, pieViewBackgroudHeight * 0.041, pieViewBackgroudWidth * 0.01, pieViewBackgroudHeight * 0.04)];
    labelImage.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:161.0/255.0 blue:250.0/255.0 alpha:1.0];
    labelImage.layer.cornerRadius = 2;
    labelImage.layer.masksToBounds = YES;
    [pieViewBackgroud addSubview:labelImage];
    
    numOfBoys = [data.sexRatio objectForKey:@"male_amount"];
    numOfGirls = [data.sexRatio objectForKey:@"female_amount"];
    
    self.pieView = [[AAChartView alloc] initWithFrame:CGRectMake((pieViewBackgroudWidth - pieViewWidth) / 2.0, pieViewBackgroudHeight * 0.1, pieViewWidth, pieViewHeight)];
    [pieViewBackgroud addSubview:self.pieView];
    
    self.pieModel = AAObject(AAChartModel).chartTypeSet(AAChartTypePie)//设置图表的类型
    .titleSet(@"")
    .titleFontSizeSet(@25.0)
    .animationTypeSet(AAChartAnimationEaseInOutCubic)
    .animationDurationSet(@1200)
    .dataLabelEnabledSet(YES)
    .seriesSet(@[AAObject(AASeriesElement)
            .nameSet(@"人数")
            .dataSet(@[
                @[@"男生", numOfBoys],
                @[@"女生", numOfGirls],
                ])
            ])
    .colorsThemeSet(@[@"#6ecaff", @"#ff86c5"]);
    [self.pieView aa_drawChartWithChartModel:self.pieModel];
    
    UIBarButtonItem *cencelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cencelButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reflesh{
    [self.pieView aa_refreshChartWithChartModel:self.pieModel];
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
