//
//  SchduleViewController.m
//  ConsultingTest
//
//  Created by RainyTunes on 8/21/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "SchduleViewController.h"
#import "UIColor+BFPaperColors.h"
#import "MainViewController.h"
#import "We.h"
#import "ScheduleTableViewCell.h"
#import "Config.h"
@interface SchduleViewController ()
@property NSArray *dataList;
@property (strong, nonatomic)UITableView *tableView;
@end

@implementation SchduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _dataList = _delegate.json[@"data"];
    UIButton *backButton = [We getButtonWithTitle:@"返回" Color:Blue];
    [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    backButton.center = CGPointMake(50, 50);
    [self.view addSubview:self.tableView];
    [self.view addSubview:backButton];
}

- (void)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [We getScreenHeight] / 9, [We getScreenWidth], [We getScreenHeight] / 9 * 8) style:UITableViewStylePlain];
        _tableView.dataSource = self;//数据源代理
        _tableView.delegate = self;
    }
    return _tableView;//属性的取值方法
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ScheduleTableViewCell" owner:self options:nil] lastObject];
    }
    NSDictionary *info = _dataList[indexPath.row];
    [cell.examTitle setText:info[@"course"]];
    UIFont *iconfont = [UIFont fontWithName:@"iconfont" size:15];
    [cell.timeIcon setFont:iconfont];
    [cell.timeIcon setText:@"\U000f00c4"];
    [cell.timeIcon setTextColor:[UIColor paperColorGray700]];
    [cell.locationIcon setFont:iconfont];
    [cell.locationIcon setText:@"\U000f014a"];
    [cell.locationIcon setTextColor:[UIColor paperColorGray700]];
    NSString *timeInfo, *locationInfo;
    if ([_delegate.json[@"type"] isEqualToString:API_EXAM_SCHEDULE]) {
        timeInfo = [NSString stringWithFormat:@"第%@周  星期%@  %@~%@",info[@"week"],[Config transformNumFormat:info[@"weekday"]],info[@"begin_time"],info[@"end_time"]];
        locationInfo = [NSString stringWithFormat:@"%@  %@教室  %@座位",info[@"status"],info[@"classroom"],info[@"seat"]];
    }
    if ([_delegate.json[@"type"] isEqualToString:API_REEXAM_SCHEDULE]) {
        timeInfo = [NSString stringWithFormat:@"%@  %@",[Config transformDateFormat:info[@"date"]],info[@"time"]];
        locationInfo = [NSString stringWithFormat:@"正常考试  %@教室  %@座位",info[@"classroom"],info[@"seat"]];
    }
    [cell.examTime setText:timeInfo];
    return cell;
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
