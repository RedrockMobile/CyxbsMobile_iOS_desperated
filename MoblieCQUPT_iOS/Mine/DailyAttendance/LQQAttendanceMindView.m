//
//  LQQAttendanceMindView.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/31.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "LQQAttendanceMindView.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <UserNotifications/UserNotifications.h>
@interface LQQAttendanceMindView()
@property (nonatomic,weak) UILabel* textLabel;
@property(nonatomic,weak) UISwitch* mindSwitch;
@property(nonatomic, strong)NSUserDefaults *defaults;
@property(nonatomic)BOOL isOpen;//按钮是否被点击
@end
@implementation LQQAttendanceMindView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        self.defaults = defaults;
//        self.isOpen = [defaults boolForKey:@"isOpenTheCheckInRemind"];
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    self.backgroundColor = [UIColor whiteColor];;
    [self showLabel];
    [self showSwitch];
}
-(void)showLabel{
    UILabel* textLabel = [[UILabel alloc]init];
    self.textLabel = textLabel;
    textLabel.text = @"连续签到每日提醒";
    textLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15.0f];
    [self addSubview:textLabel];
    
}
-(void)showSwitch{
    UISwitch* mindSwitch = [[UISwitch alloc]init];
    self.mindSwitch = mindSwitch;
    [self addSubview:mindSwitch];
    //如果isOpen的值为YES，则将switch设置为打开状态
    if(self.isOpen){
        [mindSwitch setOn:YES];
        
    }
    [mindSwitch addTarget:self action:@selector(touchMindSwitch) forControlEvents:UIControlEventValueChanged];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
    }];
    [self.mindSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
    }];
    
}

-(void) touchMindSwitch{
    if(!self.isOpen){
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"将会在每天早晨通知您哦～";
    [hud hide:YES afterDelay:1];
        self.isOpen = YES;

        [self addNotification];
//        [self.defaults setObject:@YES forKey:@"isOpenTheCheckInRemind]"];//保存用户是否打开了签到提醒偏好设置
//        [self.defaults synchronize];
    }else{
        self.isOpen = NO;
        UIApplication *app = [UIApplication sharedApplication];
        app.applicationIconBadgeNumber = 0;
        [app cancelAllLocalNotifications];
        
//        [self.defaults setObject:@NO forKey:@"isOpenTheCheckInRemind]"];//保存用户是否打开了签到提醒偏好设置
//        [self.defaults synchronize];
        
    }
    
}
- (void)addNotification{
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"签到" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"记得签到哦"
                                                         arguments:nil];
    
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:24 * 60 * 60
                                                  repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content
                                                                          trigger:trigger];
    
    // Schedule the notification.
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:nil];
}

@end
