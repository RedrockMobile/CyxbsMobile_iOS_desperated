//
//  LQQDailyAttendanceViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/31.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "LQQDailyAttendanceViewController.h"
#import "LQQAttendanceMindView.h"
#import "AttendanceMainView.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface LQQDailyAttendanceViewController ()
@property(nonatomic,weak)MBProgressHUD *hud;
@end

@implementation LQQDailyAttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self buildMyNavigationbar];
    self.view.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    [self showMainView];

}
- (void)buildMyNavigationbar{
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"每日签到";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:19];
    [titleView addSubview:titleLabel];
    
    
    self.navigationItem.titleView = titleView;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerX.equalTo(titleView);
        make.centerY.equalTo(titleView);
    }];
}

-(void) showMainView{
    AttendanceMainView*view = [[AttendanceMainView alloc]initWithFrame:CGRectMake(20, 30, self.view.width-40, 400)];


    view.layer.cornerRadius = 8.0f;
    view.clipsToBounds = YES;
    [self.view addSubview:view];

    
    LQQAttendanceMindView*viewTwo = [[LQQAttendanceMindView alloc]init];
    viewTwo.layer.cornerRadius = 8.0f;
    view.clipsToBounds = YES;
    [self.view addSubview:viewTwo];
    [viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(view);
        make.height.equalTo(@50);
        make.top.equalTo(view.mas_bottom).offset(10);
        make.centerX.equalTo(view);
    }];

    

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
