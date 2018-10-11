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
#import "NSDate+schoolDate.h"
@interface ExamScheduleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSArray *pointArray;
@property (strong, nonatomic) MBProgressHUD *hub;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H-HEADERHEIGHT-self.view.height*58/667) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"ExamScheduleTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    }
//    [self loadRefreshView];
    return _tableView;
}

- (void)fetchData {
    NSString *stuNum = [UserDefaultTool getStuNum];
    [HttpClient requestWithPath:GRADECLASSAPI method:HttpRequestPost parameters:@{@"stuNum": stuNum} prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _data = [[NSMutableArray alloc] init];
        [_data addObjectsFromArray:[responseObject objectForKey:@"data"]];
        [_data reverse];
        
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
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
//    NSString *schoolData = [NSString stringWithString:_data[indexPath.row][@"term"]];
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *myDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@-%@-12", [NSString stringWithFormat:@"0%@", [schoolData substringWithRange:NSMakeRange(0, 4)]], [schoolData substringWithRange:NSMakeRange(4, 1)]]];
    NSInteger week = [_data[indexPath.row][@"week"] integerValue];
    NSInteger weekday = [_data[indexPath.row][@"weekday"] integerValue];
    NSDate *newDate = [[NSDate alloc]getShoolData:week andWeekday:weekday];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd";
    NSString *examDate = [formatter stringFromDate:newDate];
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
    cell.month.text = [NSString stringWithFormat:@"%@月" ,[examDate substringWithRange:NSMakeRange(0, 2)]];
    [cell.month sizeToFit];
    cell.day.text = [examDate substringWithRange:NSMakeRange(3, 2)];
    [cell.day sizeToFit];
    return cell;
}
//- (void) loadRefreshView
//{
//    // 下拉刷新
//    _refreshControl = [[UIRefreshControl alloc] init];
//    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
//    [_refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:_refreshControl];
//    [self.tableView sendSubviewToBack:_refreshControl];
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    decelerate = YES;
//    if (scrollView.contentOffset.y < -40) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在刷新"];
//        });
//        [_refreshControl beginRefreshing];
//        [self fetchData];
//    }
//    else if(scrollView.contentOffset.y > SCREENHEIGHT - 50){
//    }
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView.contentOffset.y >= _tableView.height + 20) {
//        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
//    }
//    else if (!scrollView.decelerating) {
//        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"松开刷新"];
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
