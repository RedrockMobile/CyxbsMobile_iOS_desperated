//
//  XBSSchduleViewController.m
//  ConsultingTest
//
//  Created by RainyTunes on 8/21/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "XBSSchduleViewController.h"
#import "UIColor+BFPaperColors.h"
#import "MainViewController.h"
#import "We.h"
#import "XBSScheduleTableViewCell.h"
#import "XBSConsultConfig.h"
@interface XBSSchduleViewController ()
@property NSArray *dataList;
@property (strong, nonatomic)UITableView *tableView;
@end

@implementation XBSSchduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];  //
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _dataList = _delegate.json[@"data"];
    [self.view addSubview:self.tableView];
}

- (void)initNavigationBar:(NSString *)title{
    UINavigationBar *navigaionBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    UINavigationItem *navigationItem  = [[UINavigationItem alloc]initWithTitle:nil];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    [navigaionBar pushNavigationItem:navigationItem animated:YES];
    [navigaionBar setBackgroundColor:COLOR_MAINCOLOR];
    [navigaionBar setTintColor:COLOR_MAINCOLOR];
    
    navigaionBar.layer.shadowColor = [UIColor blackColor].CGColor;
    navigaionBar.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);//有个毛线用啊
    navigaionBar.layer.shadowOpacity = 0.1f;
    navigaionBar.layer.shadowRadius = 1.0f;
    
    [navigationItem setLeftBarButtonItem:leftButton];
    [navigationItem setTitle:title];
    [self.view addSubview:navigaionBar];
}
- (void)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 66, [We getScreenWidth], [We getScreenHeight] - 66) style:UITableViewStylePlain];
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
    static NSString *identify = @"XBSScheduleTableViewCell";
    XBSScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"XBSScheduleTableViewCell" owner:self options:nil] lastObject];
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
    NSString *timeInfo;//, *locationInfo;
    if ([_delegate.json[@"type"] isEqualToString:API_EXAM_SCHEDULE]) {
        self.navigationBar.titleLabel.text = ConsultFuntionName[0];
        timeInfo = [NSString stringWithFormat:@"第%@周  星期%@  %@~%@",info[@"week"],[Config transformNumFormat:info[@"weekday"]],info[@"begin_time"],info[@"end_time"]];
//        locationInfo = [NSString stringWithFormat:@"%@  %@教室  %@座位",info[@"status"],info[@"classroom"],info[@"seat"]];
    }
    if ([_delegate.json[@"type"] isEqualToString:API_REEXAM_SCHEDULE]) {
        self.navigationBar.titleLabel.text = ConsultFuntionName[1];
        timeInfo = [NSString stringWithFormat:@"%@  %@",[Config transformDateFormat:info[@"date"]],info[@"time"]];
//        locationInfo = [NSString stringWithFormat:@"正常考试  %@教室  %@座位",info[@"classroom"],info[@"seat"]];
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
