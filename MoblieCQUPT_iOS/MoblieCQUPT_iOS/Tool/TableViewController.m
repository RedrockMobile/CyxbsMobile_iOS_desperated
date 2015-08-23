//
//  TableViewController.m
//  ConsultingTest
//
//  Created by RainyTunes on 8/21/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "TableViewController.h"
#import "We.h"
@interface TableViewController ()
@property NSArray *dataList;
@property (strong, nonatomic)UITableView *tableView;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataList = _delegate.json[@"data"];
    qlog(_dataList);
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[We getScreenFrame] style:UITableViewStylePlain];
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
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    NSDictionary *info = _dataList[indexPath.row];
    cell.textLabel.text = info[@"course"];
    if ([_delegate.json[@"type"] isEqualToString:API_EXAM_SCHEDULE]) {
        NSString *str1 = [NSString stringWithFormat:@"考试日期:第%@周星期%@",info[@"week"],info[@"weekday"]];
        NSString *str2 = [NSString stringWithFormat:@"考试地点:%@教室 %@座位",info[@"classroom"],info[@"seat"]];
        NSString *str3 = [NSString stringWithFormat:@"考试时间:%@~%@",info[@"begin_time"],info[@"end_time"]];
        NSString *str4 = [NSString stringWithFormat:@"考试资格:%@",info[@"status"]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n",str1,str2,str3,str4];
        cell.detailTextLabel.numberOfLines = 5;
    }
    if ([_delegate.json[@"type"] isEqualToString:API_REEXAM_SCHEDULE]) {
        NSString *str1 = [NSString stringWithFormat:@"考试日期:%@",info[@"date"]];
        NSString *str2 = [NSString stringWithFormat:@"考试地点:%@教室 %@座位",info[@"classroom"],info[@"seat"]];
        NSString *str3 = [NSString stringWithFormat:@"考试时间:%@",info[@"time"]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@\n",str1,str2,str3];
        cell.detailTextLabel.numberOfLines = 4;
    }
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
