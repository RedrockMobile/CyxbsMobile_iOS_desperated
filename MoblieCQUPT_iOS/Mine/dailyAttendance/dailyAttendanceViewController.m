//
//  dailyAttendanceViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "dailyAttendanceViewController.h"
#import "MyInfoModel.h"
#import "dailyAttendanceModel.h"
#import "rotaryCountView.h"
#import "countdayView.h"
#import "TransparentView.h"
#import "attendanceMoreViewController.h"

@interface dailyAttendanceViewController ()<getSoreDelegate, getNewView>
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *attendanceSoreLabel;
@property (nonatomic, strong) rotaryCountView *continueView;
@property (nonatomic, strong) UIButton *detailSoreBtn;
@property (nonatomic, strong) UIButton *attendanceBotton;
@property (nonatomic, strong) countdayView *lineView;

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UISwitch *remindMeSwitch;
@end

@implementation dailyAttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self setUpMainView];
    [self setUpSwitch];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"andMore"] style:UIBarButtonItemStylePlain target:self action:@selector(moreInfor)];
}

- (void)setUpMainView{
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(18, 22, SCREENWIDTH - 36, 382)];
    _mainView.layer.cornerRadius = 5;
    _mainView.layer.borderWidth = 1;
    _mainView.layer.borderColor = [UIColor whiteColor].CGColor;
    _mainView.layer.masksToBounds = YES;
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    _mainView.layer.shadowOffset = CGSizeMake(5,5);
    _mainView.layer.shadowOpacity = 1;
    [self.view addSubview:_mainView];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 17, 60, 60)];
    headImageView.layer.cornerRadius = headImageView.width/2;
    headImageView.layer.borderWidth = 1;
    headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImageView.layer.masksToBounds = YES;

    MyInfoModel *model = [MyInfoModel getMyInfo];
    if (model.photo_thumbnail_src == nil){
        headImageView.image = [UIImage imageNamed:@"headImage"];
    }
    else {
        headImageView.image = model.photo_thumbnail_src;
    }
    [_mainView addSubview:headImageView];
    
    dailyAttendanceModel *dataModel = [[dailyAttendanceModel alloc] init];
    [dataModel requestNewScore];
    dataModel.delegate = self;
    _attendanceSoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.right + 14, 32, 200, 14)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我的积分数："];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 6)];
    _attendanceSoreLabel.attributedText = attributedString;
    [_mainView addSubview:_attendanceSoreLabel];
    
    _detailSoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_detailSoreBtn setTitle:@"积分明细" forState:UIControlStateNormal];
    _detailSoreBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [_detailSoreBtn setTitleColor:[UIColor colorWithHexString:@"6D86E8"] forState:UIControlStateNormal];
    [_detailSoreBtn addTarget:self action:@selector(detailSoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_detailSoreBtn];
    [_detailSoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top
        .mas_equalTo(_attendanceSoreLabel.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(13);
        make.left.mas_equalTo(headImageView.mas_right)
        .mas_offset(14);
        make.width.mas_offset(70);
    }];
    
    UILabel *wordLabel = [[UILabel alloc] init];
    wordLabel.text = @"已连续签到";
    wordLabel.textColor = [UIColor blackColor];
    wordLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [_mainView addSubview:wordLabel];
    [wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_mainView);
        make.top.mas_equalTo(_detailSoreBtn.mas_bottom)
        .mas_offset(40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    _continueView = [[rotaryCountView alloc] initWithFrame:CGRectMake(0 , headImageView.bottom + 60, 80, 50) andNum:@"1"];
    _continueView.centerX = _mainView.width / 2;
    [_mainView addSubview:_continueView];
    
    UILabel *dayLab = [[UILabel alloc] init];
    dayLab.text = @"天";
    dayLab.textColor = [UIColor colorWithHexString:@"6D86E8"];
    dayLab.font = [UIFont fontWithName:@"Arial" size:16];
    [_mainView addSubview:dayLab];
    
    [dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_continueView.mas_right)
        .mas_offset(10);
        make.bottom.mas_equalTo(_continueView);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
    
    _lineView = [[countdayView alloc] initWithFrame:CGRectMake(0, _mainView.centerY, 305, 0.22 * 305)AndDay:@"2"];
    _lineView.centerX = _mainView.width / 2;
    [_mainView addSubview:_lineView];
    
    
    _attendanceBotton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attendanceBotton setBackgroundImage:[UIImage imageNamed:@"AttendanceBotton"] forState:UIControlStateNormal];
    [_attendanceBotton addTarget:self action:@selector(attendance) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_attendanceBotton];
    
    [_attendanceBotton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_mainView);
        make.top.mas_equalTo(_lineView.mas_bottom)
        .mas_offset(30);
        make.width.mas_offset(190);
        make.height.mas_offset(50);
    }];
    
    
}

- (void)setUpSwitch{
    _cellView = [[UIView alloc] initWithFrame:CGRectMake(18, _mainView.bottom + 14, SCREENWIDTH - 36, 56)];
    _cellView.layer.cornerRadius = 5;
    _cellView.layer.borderWidth = 1;
    _cellView.layer.borderColor = [UIColor whiteColor].CGColor;
    _cellView.layer.masksToBounds = YES;
    _cellView.backgroundColor = [UIColor whiteColor];
    _cellView.layer.shadowColor = [UIColor blackColor].CGColor;
    _cellView.layer.shadowOffset = CGSizeMake(5,5);
    _cellView.layer.shadowOpacity = 1;
    
    [self.view addSubview:_cellView];
    
    UILabel *wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, 22, 121, 14)];
    wordLabel.text = @"连续签到提醒";
    wordLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [_cellView addSubview:wordLabel];
    
    _remindMeSwitch = [[UISwitch alloc] init];
    [_remindMeSwitch addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
    _remindMeSwitch.onTintColor = [UIColor colorWithHexString:@"6D86E8"];
    [_cellView addSubview: _remindMeSwitch];
    
    [_remindMeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_cellView).mas_offset(-20);
        make.centerY.mas_equalTo(_cellView);
        make.width.mas_offset(40);
        make.height.mas_offset(20);
    }];
}
- (void)getSore:(NSString *)sore{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"我的积分数：%@", sore]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 6)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"6D86E8"] range:NSMakeRange(6, sore.length)];
    _attendanceSoreLabel.attributedText = attributedString;
}

- (void)switchAction{
    
}
- (void)newView:(UIButton *)btn{
    attendanceMoreViewController *view;
    if (btn.tag == 0) {
        view = [[attendanceMoreViewController alloc] initWithStr:@"每天完成一次签到可获得积分奖励；\n 2.连续签到在3天、5天、7天可获得积分加成；\n3.连续签到中断，将从第一天重新开始；\n4.积分计分周期为7天；\n5.连续签到奖励如下：\n第1天 —— +10\n第2天 —— +10\n第3天 —— +20\n第4天 —— +10\n第5天 —— +30\n第6天 —— +10\n第7天 —— +40"];
        view.title = @"签到规则";
    }
    else {
        view = [[attendanceMoreViewController alloc] initWithStr:@"Q：积分有什么用途？\nA：积分可用于兑换奖品及参与各类活动。\n\nQ：怎样获得积分？\nA：目前获得积分主要有三种途径：\n1.每天登录掌上重邮并签到；\n2.发布优质“帮助”帖；\n3.官方活动发放。"];
        view.title = @"积分说明";
    }
    
    [self.navigationController pushViewController:view animated:YES];
}
- (void)moreInfor{
    TransparentView *view = [[TransparentView alloc] initWithNews:@[@"signInRule",@"soreDetail",@"签到规则",@"积分说明"]];
    view.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}
- (void)attendance{
    [_continueView selectNum:@"2"];
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
