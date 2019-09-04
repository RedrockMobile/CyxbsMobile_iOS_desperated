//
//  AttendanceMainView.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/31.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "AttendanceMainView.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface AttendanceMainView()

@property (nonatomic, weak) UIImageView *userImage;     //用户头像
@property (nonatomic, weak) UILabel *myScore;           //我的积分数
@property (nonatomic, weak) UILabel *tintLabel;         //已连续签到
@property (nonatomic, weak) UILabel *numberOfDay;       //天数
@property (nonatomic, weak) UIButton *attendanceBtn;
@property (nonatomic, weak) UILabel *overAttend;        //签到已完成Label
@property (nonatomic, weak) UILabel *day;               //天
@property (nonatomic, weak) UILabel *myScoreNumber;     //我的积分的数字
@property (nonatomic, weak) MBProgressHUD *hud1;

@end

@implementation AttendanceMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor whiteColor];
    UIImageView* userImage = [[UIImageView alloc]init];
    [self addSubview:userImage];
    userImage.image = [UIImage imageNamed:@"headImage"];
    userImage.clipsToBounds = YES;
    userImage.layer.cornerRadius = 25;
    self.userImage = userImage;
    
    
    UILabel* myScore = [[UILabel alloc]init];
    self.myScore = myScore;
    myScore.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15.0f];
    myScore.text = [NSString stringWithFormat:@"我的积分数:"];
    [self addSubview:self.myScore];
    
    UILabel* myScoreNumber = [[UILabel alloc]init];
    self.myScoreNumber = myScoreNumber;
    myScoreNumber.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15.0f];
    myScoreNumber.textColor = [UIColor colorWithHexString:@"839BFA"];
    myScoreNumber.text = [NSString stringWithFormat:@"00"];
    [self addSubview:self.myScoreNumber];
    
    UILabel* tintLabel = [[UILabel alloc]init];
    tintLabel.text = @"已连续签到";
    tintLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15.0f];
    self.tintLabel = tintLabel;
    [self addSubview:self.tintLabel];
    
    UILabel*numberOfDay = [[UILabel alloc]init];
    numberOfDay.text = [NSString stringWithFormat:@"%02d",0];
    numberOfDay.textColor = [UIColor colorWithHexString:@"839BFA"];
    numberOfDay.font = [UIFont fontWithName:@"Arial" size:60];
    self.numberOfDay = numberOfDay;
    [self addSubview:self.numberOfDay];
    
    UIButton* attendanceBtn = [[UIButton alloc]init];
    self.attendanceBtn = attendanceBtn;
    attendanceBtn.backgroundColor = [UIColor colorWithRed:108/255.0 green:132/255.0 blue:255/255.0 alpha:1];
    [attendanceBtn setTitle:@"每 日 签 到" forState:UIControlStateNormal];
    [self addSubview:attendanceBtn];
    attendanceBtn.layer.cornerRadius = 8;
    attendanceBtn.clipsToBounds = YES;
    [attendanceBtn addTarget:self action:@selector(touchAttendanceBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel*overAttend = [[UILabel alloc]init];
    self.overAttend = overAttend;
    self.overAttend.backgroundColor = [UIColor whiteColor];
    self.overAttend.text = @"今天打卡任务已完成，你还要忙着可爱";
    self.overAttend.textAlignment = NSTextAlignmentCenter;
    self.overAttend.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f];
    [self addSubview:self.overAttend];
    self.overAttend.hidden = YES;
    
    UILabel* day = [[UILabel alloc]init];
    day.text = @"天";
    day.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15.0f];
    day.textColor = [UIColor colorWithHexString:@"839BFA"];
    self.day = day;
    [self addSubview:day];
    
    // 判断今日是否签到
    __block NSMutableDictionary *checkInInfo = [[[NSUserDefaults standardUserDefaults] valueForKey:@"checkInInfo"] mutableCopy];
    if ([[checkInInfo allKeys] containsObject:@"hasCheckedToday"]) {
        if ([checkInInfo[@"hasCheckedToday"] intValue]) {
            self.overAttend.hidden = NO;
            self.attendanceBtn.hidden = YES;
        } else {
            self.overAttend.hidden = YES;
            self.attendanceBtn.hidden = NO;
        }
    } else {
        NSDictionary *myCheckInInfo = @{@"stunum": [UserDefaultTool getStuNum],
                                        @"idnum": [UserDefaultTool getIdNum]
                                        };
        HttpClient *client = [HttpClient defaultClient];
        [client requestWithPath:YOUWEN_MY_CHECKININFO method:HttpRequestPost parameters:myCheckInInfo prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([responseObject[@"data"][@"is_check_today"] intValue] == 1) {
                [checkInInfo setObject:@1 forKey:@"hasCheckedToday"];
                self.overAttend.hidden = NO;
                self.attendanceBtn.hidden = YES;
            } else {
                [checkInInfo setObject:@0 forKey:@"hasCheckedToday"];
                self.overAttend.hidden = YES;
                self.attendanceBtn.hidden = NO;
            }
            [[NSUserDefaults standardUserDefaults] setObject:checkInInfo forKey:@"checkInInfo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    
    // 读取签到信息
    [self readCheckInInfo];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.userImage setFrame:CGRectMake(20, 20, 50, 50)];
    [self.myScore setFrame:CGRectMake(80, 30, 85, 25)];
    [self.tintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-80);
    }];

    [self.numberOfDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
    }];
    [self.day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberOfDay.mas_right);
        make.bottom.equalTo(self.numberOfDay).offset(-10);
        
    }];
    [self.attendanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).multipliedBy(0.5);
        make.centerX.equalTo(self);
        make.top.equalTo(self.numberOfDay).offset(90);
    }];
    [self.overAttend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).multipliedBy(0.9);
        make.centerX.equalTo(self);
        make.top.equalTo(self.numberOfDay).offset(90);
    }];
    [self.myScoreNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myScore.mas_right);
        make.centerY.equalTo(self.myScore);
    }];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"努力加载中";
//    self.hud = hud;
    
}
-(void)touchAttendanceBtn {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.yOffset = -64;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在签到";
    self.hud = hud;
    
    __block NSMutableDictionary *checkInfoDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"checkInInfo"] mutableCopy];
    if (![checkInfoDict[@"hasCheckedToday"] intValue]) {
        self.attendanceBtn.hidden = YES;
        self.overAttend.hidden = NO;
        
        HttpClient * client = [HttpClient defaultClient];
        
        [client requestWithPath:YOUWEN_CHECKIN_API method:HttpRequestPost parameters:@{@"stunum":[UserDefaultTool getStuNum], @"idnum":[UserDefaultTool getIdNum]} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[NSString stringWithFormat:@"%@", responseObject[@"status"]] isEqualToString:@"200"]) {
                [checkInfoDict setValue:@1 forKey:@"hasCheckedToday"];
                [[NSUserDefaults standardUserDefaults] setValue:checkInfoDict forKey:@"checkInInfo"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.hud hide:YES];
                [self getCheckInInfo];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
    }
}

- (void)getCheckInInfo {
    HttpClient * client = [HttpClient defaultClient];

    [client requestWithPath:@"https://cyxbsmobile.redrock.team/app/index.php/Home/Person/search" method:HttpRequestPost parameters:@{@"stuNum":[UserDefaultTool getStuNum], @"idNum":[UserDefaultTool getIdNum]} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.numberOfDay.text = [NSString stringWithFormat:@"%02d",[responseObject[@"data"][@"check_in_days"] intValue]];
        self.myScoreNumber.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"integral"]];
        
        NSMutableDictionary *checkInCache = [[[NSUserDefaults standardUserDefaults] objectForKey:@"checkInInfo"] mutableCopy];
        
        if (!checkInCache) {
            checkInCache = [@{@"numberOfDays": responseObject[@"data"][@"check_in_days"],
                             @"integral": responseObject[@"data"][@"integral"]
                             } mutableCopy];
        } else {
            [checkInCache setValue:responseObject[@"data"][@"check_in_days"] forKey:@"numberOfDays"];
            [checkInCache setValue:responseObject[@"data"][@"integral"] forKey:@"integral"];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:checkInCache forKey:@"checkInInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)readCheckInInfo {
    NSDictionary *checkInCache = [[NSUserDefaults standardUserDefaults] valueForKey:@"checkInInfo"];
    
    // 判断是否有缓存，如果有直接读取，没有则请求数据
    if (checkInCache) {
        self.numberOfDay.text = [NSString stringWithFormat:@"%02d", [checkInCache[@"numberOfDays"] intValue]];
        self.myScoreNumber.text = [NSString stringWithFormat:@"%@", checkInCache[@"integral"]];
    } else {
        [self getCheckInInfo];
    }
}

@end
