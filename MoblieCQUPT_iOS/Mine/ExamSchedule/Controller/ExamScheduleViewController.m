//
//  ExamScheduleViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 2016/12/16.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "ExamScheduleViewController.h"
#import "ExamScheduleTableViewCell.h"
#import <sys/socket.h>

@interface ExamScheduleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation ExamScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchData];

    [self.view addSubview:self.tabelView];
    self.tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (UITableView *)tabelView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UINib *nib = [UINib nibWithNibName:@"ExamScheduleTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    }
    
    return _tableView;
}

- (void)fetchData {
    NSString *stuNum = [LoginEntry getByUserdefaultWithKey:@"stuNum"];
    
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/examSchedule"
                            WithParameter:@{@"stuNum": stuNum}
                     WithReturnValeuBlock:^(id returnValue) {
                         
                         _data = [[NSMutableArray alloc] init];
                         [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
                         [_data reverse];
                         
                         [_tableView reloadData];
                         
                     } WithFailureBlock:^{
                         UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
                         failLabel.text = @"哎呀！网络开小差了 T^T";
                         failLabel.textColor = [UIColor blackColor];
                         failLabel.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
                         failLabel.textAlignment = NSTextAlignmentCenter;
                         [self.view addSubview:failLabel];
                         [_tableView removeFromSuperview];
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

#pragma mark - Table view delagate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExamScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[ExamScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.examName.text = _data[indexPath.row][@"course"];
    NSString *examLocationLableText = [_data[indexPath.row][@"classroom"] stringByAppendingFormat:@"教室    %@座", _data[indexPath.row][@"seat"]];
    cell.examLocation.text = examLocationLableText;
    NSString *examTimeLableText = [_data[indexPath.row][@"begin_time"] stringByAppendingFormat:@" - %@", _data[indexPath.row][@"end_time"]];
    cell.examTime.text = examTimeLableText;
    NSString *examDateLableText = [_data[indexPath.row][@"week"] stringByAppendingFormat:@"周 周%@", _data[indexPath.row][@"weekday"]];
    cell.examDate.text = examDateLableText;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
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
