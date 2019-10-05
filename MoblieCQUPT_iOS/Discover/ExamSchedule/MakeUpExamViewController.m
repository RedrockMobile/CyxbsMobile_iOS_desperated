//
//  MakeUpExamViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/9.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "MakeUpExamViewController.h"
#import <MBProgressHUD.h>
#import "ExamScheduleTableViewCell.h"
#import "NSDate+schoolDate.h"
@interface MakeUpExamViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) MBProgressHUD *hub;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *pointArray;
@property (strong, nonatomic) UITableView *MakeUpExamTableView;
@property (weak, nonatomic)UIImageView *noExamArrangeImageView;
@property (weak, nonatomic)UILabel *noExamArrangeLabel;
@end

@implementation MakeUpExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hub.labelText = @"正在加载";
    _pointArray = @[@"pinkPoint", @"bluePoint", @"yellowPoint"];
    [self loadData];

}
- (void)loadData{
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    NSString *stuNum = [defaults objectForKey:@"stuNum"];
    [NetWork NetRequestPOSTWithRequestURL:MAKEAPI WithParameter:@{@"stuNum": stuNum} WithReturnValeuBlock:^(id returnValue) {
        self.data = returnValue[@"data"];
        if (self.data.count == 0) {
            if(self.data.count == 0){
                NSLog(@"1");
            }
            if(!returnValue[@"data"]){
                NSLog(@"2");
            }
//            [self initFailViewWithDetail:@"暂无补考消息~"];
            [self showNoExamArrangeImage];
            [self.hub hide:YES];
        }
//        if (returnValue[@"data"])
        else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.data = returnValue[@"data"];
            [self setUpTableView];
        }
    } WithFailureBlock:^{
        [self initFailViewWithDetail:@"哎呀！网络开小差了 T^T"];

    }];
}
/// 展示没有考试时显示的图片和一行文字
-(void) showNoExamArrangeImage{
    //图片
    UIImageView*image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emptyImage"]];
    self.noExamArrangeImageView = image;
    [self.view addSubview:self.noExamArrangeImageView];
    [self.noExamArrangeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
//        make.height.width.equalTo(@"300");
    }];
    //文字
    UILabel* label = [[UILabel alloc]init];
    label.text = @"暂无补考安排";
    label.textColor = [UIColor colorWithRed:77/255.0 green:85/255.0 blue:93/255.0 alpha:1];
    self.noExamArrangeLabel = label;
    [self.view addSubview:self.noExamArrangeLabel];
    [self.noExamArrangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.noExamArrangeImageView).offset(80);
    }];
}
- (void)setUpTableView{
    _MakeUpExamTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-self.view.height*58/667-HEADERHEIGHT) style:UITableViewStylePlain];
    _MakeUpExamTableView.delegate = self;
    _MakeUpExamTableView.dataSource = self;
    _MakeUpExamTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:@"ExamScheduleTableViewCell" bundle:nil];
    [_MakeUpExamTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_MakeUpExamTableView];
}

- (void)initFailViewWithDetail:(NSString *)string{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIImageView *failLoad = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 250)];
    failLoad.contentMode = UIViewContentModeScaleAspectFit;
    failLoad.image = [UIImage imageNamed:@"emptyImage"];
    UILabel *detailLab= [[UILabel alloc]initWithFrame:CGRectMake(0, failLoad.bottom, SCREEN_WIDTH, 30)];
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.font = kFont;
    detailLab.textColor = [UIColor colorWithHexString:@"4B535B"];
    detailLab.text = string;
    [self.view addSubview:detailLab];
    [self.view addSubview:failLoad];
}
#pragma mark 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 119;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExamScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[ExamScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
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
    
    // 判断考试时间是否为开学前

    NSString *examDateLabelText;
    if ([_data[indexPath.row][@"week"] intValue] < 0) {
        examDateLabelText = [NSString stringWithFormat:@"开学前%d周 周%@",-[_data[indexPath.row][@"week"] intValue] ,dateArray[dateIndex]];
    } else {
        examDateLabelText = [NSString stringWithFormat:@"%d周 周%@   ",[_data[indexPath.row][@"week"] intValue] ,dateArray[dateIndex]];
    }
    cell.examDate.text = examDateLabelText;
    //日期
//    NSDate *newDate = [[NSDate alloc] getShoolData:_data[indexPath.row][@"week"] andWeekday:_data[indexPath.row][@"weekday"]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd";
//    NSString *examDate = [formatter stringFromDate:newDate];
    cell.month.text = [NSString stringWithFormat:@"%@月" ,[_data[indexPath.row][@"date"] substringWithRange:NSMakeRange(0, 1)]];
    [cell.month sizeToFit];
    cell.day.text = [_data[indexPath.row][@"date"] substringWithRange:NSMakeRange(2, 2)];
    [cell.day sizeToFit];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
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
