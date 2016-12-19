//
//  LessonRemindNotification.m
//  MoblieCQUPT_iOS
//
//  Created by hzl on 2016/11/30.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "LessonRemindNotification.h"
#import <UserNotifications/UserNotifications.h>

@interface LessonRemindNotification()

@property (nonatomic, strong) NSMutableArray *weekDataArray;
@property (strong, nonatomic) UNMutableNotificationContent *content;

@end

@implementation LessonRemindNotification

- (NSMutableArray *)weekDataArray
{
    if (!_weekDataArray) {
        self.weekDataArray = [[NSMutableArray alloc] init];
    }
    return _weekDataArray;
}

- (void)deleteNotification
{
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[@"tomorrowRequestWithIdentifier"]];
}

- (void)notificationBody
{
    [self newWeekDataArray:true];
    self.content = [[UNMutableNotificationContent alloc] init];
    self.content.title = @"明天的课有:";
    NSString *appendStr = [[NSString alloc] init];
    for (int i = 0; i < _weekDataArray.count; i++) {
        appendStr = [appendStr stringByAppendingString:[self tomorrowLessonInfo][i]];
        appendStr = [appendStr stringByAppendingString:[self tomorrowLessonTimeInfo][i]];
        appendStr = [appendStr stringByAppendingString:[self tomorrowClassInfo][i]];
    }
    if ([appendStr isEqualToString:@""]) {
        self.content.body =  @"明天没有课哦";
    }else{
        self.content.body = appendStr;
    }
}


- (void)setGcdTimer
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 3600, 0.1 * NSEC_PER_SEC);
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        [weakSelf notificationBody];
    });
    dispatch_resume(timer);
    
}


- (void)addTomorrowNotification
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = 22;
    components.minute = 00;
    UNCalendarNotificationTrigger *calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    
//        UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    
    NSString *requestIdentifier = @"tomorrowRequestWithIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:self.content trigger:calendarTrigger];
    
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"Error:%@",error);
    }];
}

- (void)newWeekDataArray:(BOOL)tomorrow
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *hashDate = [[NSString alloc] init];
    NSString *hashDay = [[NSString alloc] init];
    if (tomorrow == true) {
        hashDate = [self weekDayStr:true];
    }else{
        hashDate = [self weekDayStr:false];
    }
    NSString *nowWeek = [[NSString alloc] initWithFormat:@"%@",[userDefault objectForKey:@"nowWeek"]];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[userDefault objectForKey:@"lessonResponse"][@"data"]];
    //        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[[userDefault objectForKey:@"response"] objectForKey:@"data"]];
    for (int i = 0; i < array.count; i++) {
        if (tomorrow == true) {
            hashDay = [NSString stringWithFormat:@"%@",array[i][@"hash_day"]];
        }else{
            hashDay = [NSString stringWithFormat:@"%@",array[i][@"day"]];
        }
        if ([hashDay isEqualToString:hashDate]&&[array[i][@"week"] containsObject:[NSNumber numberWithInteger:[nowWeek integerValue]]]) {
            [self.weekDataArray addObject:array[i]];
        }
    }
}

- (NSMutableArray *)tomorrowClassInfo
{
    NSString *classInfo = [[NSString alloc] init];
    NSMutableArray *classInfos = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.weekDataArray.count; i++) {
        classInfo = [NSString stringWithFormat:@" | %@\n",self.weekDataArray[i][@"classroom"]];
        [classInfos addObject:classInfo];
    }
    return classInfos;
}

- (NSMutableArray *)tomorrowLessonInfo
{
    NSString *lessonInfo = [[NSString alloc] init];
    NSMutableArray *lessonInfos = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.weekDataArray.count; i++) {
        lessonInfo = [NSString stringWithFormat:@"%@",self.weekDataArray[i][@"course"]];
        [lessonInfos addObject:lessonInfo];
    }
    return lessonInfos;
}

- (NSMutableArray *)tomorrowLessonTimeInfo
{
    NSString *timeInfo = [[NSString alloc] init];
    NSMutableArray *timeInfos = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.weekDataArray.count; i++) {
        timeInfo = [NSString stringWithFormat:@" | 第%@节开始上课",self.weekDataArray[i][@"begin_lesson"]];
        [timeInfos addObject:timeInfo];
    }
    return timeInfos;
}


- (NSString *)weekDayStr:(BOOL)hash
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"dd"];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    
    [outputFormatter setDateFormat:@"EEEE"];
    
    NSString *newDateString = [outputFormatter stringFromDate:[NSDate date]];
    
    if ([newDateString isEqualToString:@"星期一"]) {
        return @"1";
    }
    if ([newDateString isEqualToString:@"星期二"]) {
        
        return @"2";
    }
    if ([newDateString isEqualToString:@"星期三"]) {
        
        return @"3";
    }
    if ([newDateString isEqualToString:@"星期四"]) {
        
        return @"4";
    }
    if ([newDateString isEqualToString:@"星期五"]) {
        
        return @"5";
    }
    if ([newDateString isEqualToString:@"星期六"]) {
        
        return @"6";
    }
    if ([newDateString isEqualToString:@"星期天"]) {
        if (hash==true) {
            return @"0";
        }
        return @"7";
    }
    return 0;
}

@end
