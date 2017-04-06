//
//  QuerLoginViewController.m
//  Query
//
//  Created by hzl on 2017/3/4.
//  Copyright © 2017年 c. All rights reserved.
//

#import "QuerLoginViewController.h"
#import "QuerCircleView.h"
#import "QuerLoginModel.h"
#import "QuerNoteView.h"
#import "QuerPullTableViewCell.h"
#import "triangleView.h"
#import "InstallRoomViewController.h"
#import "InstallcurrentViewController.h"
#import "QuerRemindViewController.h"
#import "IntallFailViewController.h"
#import "AppDelegate.h"

#define font(R) (R)*([UIScreen mainScreen].bounds.size.width)/375.0
#define ELECTROLYSIS_URL @"http://hongyan.cqupt.edu.cn/MagicLoop/index.php?s=/addon/ElectricityQuery/ElectricityQuery/queryElecByRoom"

CG_INLINE CGRect
CHANGE_CGRectMake(CGFloat x, CGFloat y,CGFloat width,CGFloat height){

    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleY;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}

@interface QuerLoginViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;

@property (nonatomic) BOOL on;

@property (nonatomic, strong) NSDictionary *dataDic;
@end

@implementation QuerLoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    QuerNoteView *qnv = [[QuerNoteView alloc] initWithFrame:CHANGE_CGRectMake(0, 450, 375, 247)];
    
    QuerCircleView *qcv = [[QuerCircleView alloc] initWithFrame:CHANGE_CGRectMake(0, 94, 378, 264)];
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = pathArray[0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"RoomAndBuild.plist"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    QuerLoginModel *qlModel = [[QuerLoginModel alloc] init];
    [qlModel RequestWithBuildingNum:[NSString stringWithFormat:@"%@",dataDic[@"build"]] RoomNum:[NSString stringWithFormat:@"%@",dataDic[@"room"]]];

    qcv.percentage = 0;
    qcv.chargeStr = @"00.00";
    qcv.ElectrolysisStr = @"0";
    qcv.AveragELecStr = @"0";
    qcv.FreeElecStr = @"0";
    qcv.ElcStarStr = @"0";
    qcv.ElcEndStr = @"0";
    qnv.recordStr = @"0月0日";
    
    if (dataDic[@"room"]&&dataDic[@"build"]) {
        qlModel.saveBlock = ^(NSDictionary *jsonDic){
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            if ([[jsonDic objectForKey:@"elec_inf"]objectForKey:@"elec_spend"] == [NSNull null]) {
            }
            else{
                [userDefault setObject:jsonDic[@"elec_inf"] forKey:@"elecData"];
                [userDefault synchronize];
                [qcv removeFromSuperview];
                [qnv removeFromSuperview];
                [self reloadElecData];
            }
        };
    }
    [self.view addSubview:qnv];
    [self.view addSubview:qcv];
}

- (void)reloadElecData{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = pathArray[0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"RoomAndBuild.plist"];
    NSMutableDictionary *elecDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dataDic = [userDefault objectForKey:@"elecData"];
    
    QuerNoteView *qnv = [[QuerNoteView alloc] initWithFrame:CHANGE_CGRectMake(0, 450, 375, 247)];
    
    QuerCircleView *qcv = [[QuerCircleView alloc] initWithFrame:CHANGE_CGRectMake(0, 94, 378, 264)];
    
    NSString *charge = [NSString stringWithFormat:@"%@.%@",dataDic[@"elec_cost"][0],dataDic[@"elec_cost"][1]];
    qcv.chargeStr = charge;
    qcv.ElectrolysisStr = [NSString stringWithFormat:@"%@",dataDic[@"elec_spend"]];
    NSInteger elec = [[NSString stringWithFormat:@"%@",dataDic[@"elec_spend"]] integerValue];
    NSInteger day = [[[NSString stringWithFormat:@"%@",dataDic[@"record_time"]] substringFromIndex:3] integerValue];
    qcv.AveragELecStr = [NSString stringWithFormat:@"%ld",elec/day];
    qcv.FreeElecStr = [NSString stringWithFormat:@"%@",dataDic[@"elec_free"]];
    qcv.ElcStarStr = [NSString stringWithFormat:@"%@",dataDic[@"elec_start"]];
    qcv.ElcEndStr = [NSString stringWithFormat:@"%@",dataDic[@"elec_end"]];
    if (elecDic[@"remind"]) {
        qcv.percentage = (CGFloat)charge.integerValue/[elecDic[@"remind"] integerValue];
    }else{
    qcv.percentage = (CGFloat)charge.integerValue/200;
    }
    
    qnv.recordStr = [NSString stringWithFormat:@"%@",dataDic[@"record_time"]];
    
    [self.view addSubview:qnv];
    [self.view addSubview:qcv];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CHANGE_CGRectMake(232, 71.5, 136, 102.5) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _on = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1]};
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"..." style:UIBarButtonItemStylePlain target:self action:@selector(showMinTableView)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(0, 435, 375, 10)];
    label.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:label];
    
    [barItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font(34)]} forState:UIControlStateNormal];
    
    
    self.navigationItem.rightBarButtonItem = barItem;
    self.navigationItem.title = @"查电费";

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuerPullTableViewCell *cell = [QuerPullTableViewCell cellWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.guideLabel.text = @"设置提醒";
    }
    if (indexPath.row == 1) {
        cell.guideLabel.text = @"设置寝室";
    }
//    if (indexPath.row == 2) {
//        cell.guideLabel.text = @"查看往期电费";
//    }
    [cell.guideLabel sizeToFit];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 301/6;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QuerPullTableViewCell *cell = [QuerPullTableViewCell cellWithTableView:tableView];
    cell.guideLabel.textColor = [UIColor colorWithRed:18/255.0 green:208/255.0 blue:255/255.0 alpha:1];
    if (indexPath.row == 0) {
        QuerRemindViewController *qrVC = [[QuerRemindViewController alloc] init];
        [self.navigationController pushViewController:qrVC animated:YES];
    }
    if (indexPath.row == 1) {
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = pathArray[0];
        NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"RoomAndBuild.plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        NSDate *currentDate = [NSDate date];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *compoent = [calendar components:NSCalendarUnitMonth fromDate:currentDate];
        
        if (data[@"room"]) {
            if ([NSString stringWithFormat:@"%@",compoent].integerValue -[NSString stringWithFormat:@"%@",data[@"month"]].integerValue == 0) {
                IntallFailViewController *ifVC = [[IntallFailViewController alloc] init];
                [self.navigationController pushViewController:ifVC animated:YES];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
            }else{
                 InstallcurrentViewController *icVC = [[InstallcurrentViewController alloc] init];
            [self.navigationController pushViewController:icVC animated:YES];
            }
        }else{
        InstallRoomViewController *roomVC = [[InstallRoomViewController alloc] init];
        [self.navigationController pushViewController:roomVC animated:YES];
    }
//    if (indexPath.row == 2) {
//  
//        }
    }
    self.view = nil;
}
- (void)showMinTableView{
    if (_on == NO) {
        _bgView = [[UIView alloc] initWithFrame:CHANGE_CGRectMake(0, 0, 375, 667)];
        [_bgView setBackgroundColor:[UIColor colorWithRed:57/255.0 green:57/255.0 blue:57/255.0 alpha:0.1]];
        UITapGestureRecognizer *tapGsture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBigView)];
        tapGsture.delegate = self;
        [_bgView addGestureRecognizer:tapGsture];
        
        triangleView *taV = [[triangleView alloc] initWithFrame:CHANGE_CGRectMake(335, 64, 15, 7.5)];
        
        [_bgView addSubview:taV];
        [_bgView addSubview:_tableView];
        
        
        [self.view addSubview:_bgView];
    
        _on = YES;
    }else{
        [self removeBigView];
        _on = NO;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
// 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件(只解除的是cell与手势间的冲突，cell以外仍然响应手势)
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
}
// 若为UITableView（即点击了tableView任意区域），则不截获Touch事件(完全解除tableView与手势间的冲突，cell以外也不会再响应手势)
if ([touch.view isKindOfClass:[UITableView class]]){
            return NO;
        }
        return YES;
}

- (void)removeBigView{
    _bgView.hidden = YES;
    _bgView = nil;
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
