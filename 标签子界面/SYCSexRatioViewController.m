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

@end

@implementation SYCSexRatioViewController

@synthesize data, numOfBoys, numOfGirls;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    numOfBoys = [data.sexRatio objectForKey:@"male_amount"];
    numOfGirls = [data.sexRatio objectForKey:@"female_amount"];
    
    NSLog(@"%@ %@", numOfBoys, numOfGirls);
    
    CGFloat pieViewWidth = self.view.frame.size.width;
    CGFloat pieViewHeight = self.view.frame.size.height - 400;
    
    AAChartView *pieView = [[AAChartView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - pieViewWidth) / 2.0, 60, pieViewWidth, pieViewHeight)];
    [self.view addSubview:pieView];
    
    AAChartModel *pieModel = AAObject(AAChartModel).chartTypeSet(AAChartTypePie)//设置图表的类型
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
            ]);
    [pieView aa_drawChartWithChartModel:pieModel];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
