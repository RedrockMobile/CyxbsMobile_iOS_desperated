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
#import <MBProgressHUD.h>

@interface ExamScheduleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSArray *pointArray;
@property (strong, nonatomic) MBProgressHUD *hub;
@end

@implementation ExamScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hub.labelText = @"正在加载";
    [self fetchData];
    [self.view addSubview:self.tabelView];
    self.tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _pointArray = @[@"pinkPoint", @"bluePoint", @"yellowPoint"];
}

- (UITableView *)tabelView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H - 64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UINib *nib = [UINib nibWithNibName:@"ExamScheduleTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    }
    
    return _tableView;
}

- (void)fetchData {
    NSString *stuNum = [UserDefaultTool getStuNum];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/api/examSchedule"
                            WithParameter:@{@"stuNum": stuNum}
                     WithReturnValeuBlock:^(id returnValue) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         _data = [[NSMutableArray alloc] init];
                         [_data addObjectsFromArray:[returnValue objectForKey:@"data"]];
                         [_data reverse];
                         
                         [_tableView reloadData];
                         
                     } WithFailureBlock:^{
                         
                         [self initFailViewWithDetail:@"哎呀！网络开小差了 T^T"];
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initFailViewWithDetail:(NSString *)string{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIImageView *failLoad = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 250)];
    failLoad.contentMode = UIViewContentModeScaleAspectFit;
    failLoad.image = [UIImage imageNamed:@"emptyImage"];
    UILabel *detailLab= [[UILabel alloc]initWithFrame:CGRectMake(0, failLoad.bottom, SCREENWIDTH, 30)];
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.font = kFont;
    detailLab.textColor = [UIColor colorWithHexString:@"4B535B"];
    detailLab.text = string;
    [self.view addSubview:detailLab];
    [self.view addSubview:failLoad];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 119;
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
    NSString *schoolData = [NSString stringWithString:_data[indexPath.row][@"term"]];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *myDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@-%@-12", [NSString stringWithFormat:@"0%@", [schoolData substringWithRange:NSMakeRange(0, 4)]], [schoolData substringWithRange:NSMakeRange(4, 1)]]];
    NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * ([_data[indexPath.row][@"weekday"] intValue] + [_data[indexPath.row][@"week"] intValue] * 7)];
    NSLog(@"%@ %@",[dateFormatter stringFromDate:newDate], _data[indexPath.row][@"weekday"]);
    //横杆
    if (indexPath.row == 0) {
        cell.upView.backgroundColor = [UIColor clearColor];
        cell.downView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    }
    else if (indexPath.row == _data.count - 1) {
        cell.upView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        cell.downView.backgroundColor = [UIColor clearColor];
    }
    else{
        cell.upView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        cell.downView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    }
    //圆点
    cell.pointView.image = [UIImage imageNamed:_pointArray[indexPath.row % 3]];
    
    cell.examName.text = _data[indexPath.row][@"course"];
    NSString *examLocationLableText = [_data[indexPath.row][@"classroom"] stringByAppendingFormat:@"教室    %@座", _data[indexPath.row][@"seat"]];
    cell.examLocation.text = examLocationLableText;
    NSString *examTimeLableText = [_data[indexPath.row][@"begin_time"] stringByAppendingFormat:@" - %@", _data[indexPath.row][@"end_time"]];
    cell.examTime.text = examTimeLableText;
    NSArray *dateArray = @[@"零",@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    
    int dateIndex = [_data[indexPath.row][@"weekday"] intValue];
    NSString *examDateLabelText = [_data[indexPath.row][@"week"] stringByAppendingFormat:@"周 周%@",dateArray[dateIndex]];
    cell.examDate.text = examDateLabelText;
    cell.month.text = [NSString stringWithFormat:@"%@月",[[dateFormatter stringFromDate:newDate] substringWithRange:NSMakeRange(6, 1)]];
    cell.day.text = [[dateFormatter stringFromDate:newDate] substringWithRange:NSMakeRange(8, 2)];
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
