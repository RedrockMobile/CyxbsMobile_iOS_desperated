//
//  RemindNotification.m
//  Demo
//
//  Created by hzl on 2016/11/30.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "RemindNotification.h"
#import <UserNotifications/UserNotifications.h>

@interface RemindNotification()

@property (nonatomic) NSInteger *arrayCount;

@property (nonatomic) NSInteger newEventCount;
@property (nonatomic, strong) NSMutableDictionary *identifierDic;
@property (nonatomic, strong) NSMutableArray *eventArray;

@end

@implementation RemindNotification

- (NSMutableDictionary *)identifierDic
{
    if (!_identifierDic) {
        self.identifierDic = [[NSMutableDictionary alloc] init];
    }
    return _identifierDic;
}

- (NSMutableArray *)eventArray
{
    if (!_eventArray) {
        self.eventArray = [[NSMutableArray alloc] init];
    }
    return _eventArray;
}

- (void)updateNotificationWithIdetifiers:(NSString *)newIdentifier
{
    NSMutableArray *events = [[NSMutableArray alloc] init];
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] init];
    NSDictionary *updateDic = [[NSDictionary alloc] init];
    NSString *lessonDateStr = [[NSString alloc] init];
    NSMutableArray *weekArray = [[NSMutableArray alloc] init];
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    NSDictionary *dateDic = [[NSDictionary alloc] init];
    NSString *identifier = [[NSString alloc] init];
    NSMutableArray *identifierArray = [[NSMutableArray alloc] init];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"remind.plist"];
    events = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:self.identifierDic[newIdentifier]];
    
    for (NSInteger i = 0; i < events.count; i++) {
        if ([[NSString stringWithFormat:@"%@",events[i][@"id"]] isEqualToString:newIdentifier]) {
            updateDic = events[i];
            break;
        }
    }
    dateArray = updateDic[@"date"];
    for (NSInteger i =  0; i < dateArray.count; i++) {
        dateDic = dateArray[i];
        weekArray = dateDic[@"week"];
        for (NSInteger j = 0; j < weekArray.count; j++) {
            identifier = newIdentifier
            ;
            identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",weekArray[j]]];
            identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",dateDic[@"day"]]];
            identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",dateDic[@"class"]]];
            [identifierArray addObject:identifier];
            
            if ([[userDefault objectForKey:@"nowWeek"] intValue] - [weekArray[i] intValue] >+ 0) {
                      lessonDateStr = [self calculateLessonDateWithWeek:weekArray[i] nowWeek:[userDefault objectForKey:@"nowWeek"] day:dateDic[@"day"] class:dateDic[@"class"]];
            
            comp = [self calculateNotificationTimeWithIntervalTime:updateDic[@"time"] LessonDate:lessonDateStr];
            
            [self addNotificationWithTitle:updateDic[@"title"] Content:updateDic[@"content"] Identifier:identifier components:comp];
            }
            
      }
    }
    [self.identifierDic setObject:identifierArray forKey:newIdentifier];
    self.eventArray = events;
}

- (void)addNotifictaion
{
    NSInteger identifierCount = 0;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *nowWeekStr = [[NSString alloc] init];
    NSString *identifierStr = [[NSString alloc] init];
    NSString *timeStr = [[NSString alloc] init];
    NSString *titleStr = [[NSString alloc] init];
    NSString *contentStr = [[NSString alloc] init];
    NSString *dayStr = [[NSString alloc] init];
    NSString *classStr = [[NSString alloc] init];
    NSString *weekStr = [[NSString alloc] init];
    NSString *lessonDateStr = [[NSString alloc] init];
    
    NSDictionary *newEventDic = [[NSDictionary alloc] init];
    NSDictionary *newEventDateDic = [[NSDictionary alloc] init];
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    NSMutableArray *weekArray = [[NSMutableArray alloc] init];
    NSMutableArray *identifiers = [[NSMutableArray alloc] init];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    
    nowWeekStr = [NSString stringWithFormat:@"%@",[userDefault objectForKey:@"nowWeek"]];
    [self creatIdentifiers];
    
    for (NSInteger i = 0; i < self.newEventCount; i++) {
        
        newEventDic = self.eventArray[self.eventArray.count - 1 - i];
        
        timeStr = [NSString stringWithFormat:@"%@",newEventDic[@"time"]];
        titleStr = [NSString stringWithFormat:@"%@",newEventDic[@"title"]];
        contentStr = [NSString stringWithFormat:@"%@",newEventDic[@"content"]];
        dateArray = newEventDic[@"date"];
        
        for (NSInteger j = 0; j < dateArray.count; j++) {
            newEventDateDic = dateArray[j];
            classStr = [NSString stringWithFormat:@"%@",newEventDateDic[@"class"]];
            dayStr = [NSString stringWithFormat:@"%@",newEventDateDic[@"day"]];
            weekArray = newEventDateDic[@"week"];
            for (NSInteger k = 0; k < weekArray.count; k++) {
                
                weekStr = [NSString stringWithFormat:@"%@",weekArray[k]];
                identifiers = self.identifierDic[newEventDic[@"id"]];
                identifierStr = identifiers[identifierCount];
                identifierCount++;
                
                if ([nowWeekStr intValue] - [weekStr intValue] >+ 0) {
                                   lessonDateStr = [self calculateLessonDateWithWeek:weekStr nowWeek:nowWeekStr day:dayStr class:classStr];

                comp = [self calculateNotificationTimeWithIntervalTime:timeStr LessonDate:lessonDateStr];

                [self addNotificationWithTitle:titleStr Content:contentStr Identifier:identifierStr components:comp];
                }
 
            }
        }
    }
    
}

- (void)deleteNotificationAndIdentifiers
{
    NSMutableArray *identifiers = [[NSMutableArray alloc] init];
    NSString *idStr = [[NSString alloc] init];
    
    //待修改2
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"remind.plist"];
    NSMutableArray *events = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    NSDictionary *newDataDic = [[NSDictionary alloc] init];
    NSDictionary *oldDataDic = [[NSDictionary alloc] init];
    
    for (NSInteger i = 0; i < events.count; i++) {
        newDataDic = events[i];
        oldDataDic = self.eventArray[i];
        if (![newDataDic[@"id"] isEqual:oldDataDic[@"id"]])
        {
            idStr = [NSString stringWithFormat:@"%@",oldDataDic[@"id"]];
            break;
        }
    }
    identifiers = self.identifierDic[idStr];
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:identifiers];
    [self.identifierDic removeObjectForKey:idStr];
    self.eventArray = events;
}


- (void)creatIdentifiers
{
    self.newEventCount = 0;
    NSString *identifier = [[NSString alloc] init];
    
    NSMutableArray *events = [[NSMutableArray alloc] init];
    
    //待修改3
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"remind.plist"];
    events = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    NSDictionary *dataDic = [[NSDictionary alloc] init];
    NSDictionary *dateDic = [[NSDictionary alloc] init];
    
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    NSMutableArray *weekArray = [[NSMutableArray alloc] init];
    NSMutableArray *identifierArray = [[NSMutableArray alloc] init];
    
    for (NSInteger i = self.eventArray.count; i < events.count; i++) {

        dataDic = events[i];
        dateArray = dataDic[@"date"];
        for (NSInteger j = 0; j < dateArray.count; j++) {
            weekArray = dateArray[j][@"week"];
            dateDic = dateArray[j];
            for (NSInteger k = 0; k < weekArray.count; k++) {
                identifier = [NSString stringWithFormat:@"%@",dataDic[@"id"]];
                identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",weekArray[k]]];
                identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",dateDic[@"day"]]];
                identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",dateDic[@"class"]]];
                [identifierArray addObject:identifier];
            }
        }
        self.newEventCount++;
        [self.identifierDic setObject:identifierArray forKey:dataDic[@"id"]];
    }
    self.eventArray = events;
}

- (void)addNotificationWithTitle:(NSString *)title Content:(NSString *)text Identifier:(NSString *)identifier components:(NSDateComponents *)comp
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.body = text;
    
    UNCalendarNotificationTrigger *calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:comp repeats:NO];
    
//
//    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    
    NSString *requestIdentifier = identifier;
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:calendarTrigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"Error:%@",error);
    }];
}

-(NSDateComponents *)calculateNotificationTimeWithIntervalTime:(NSString *)time
                                                    LessonDate:(NSString *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    
    NSTimeInterval timeInterval = [time doubleValue] * 60;
    
    NSDate *intervalTime = [[formatter dateFromString:date]
                            dateByAddingTimeInterval:-timeInterval];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    NSDateComponents *comp = [gregorian components:unitFlags fromDate:intervalTime];
    
    return comp;
}

- (NSString *)calculateLessonDateWithWeek:(NSString *)week nowWeek:(NSString *)nowWeek day:(NSString *)day class:(NSString *)beginClass
{
    NSDictionary *beginTimes = @{@"0":@"8:00",@"1":@"10:05",@"2":@"14:00",@"3":@"16:05",@"4":@"19:00",@"5":@"20:50"};
    
    double oneDay = 24 * 60 * 60;
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    
    double monthDays = ([week doubleValue] - [nowWeek doubleValue]) * 7;
    
    double weekDays =  [day doubleValue] - [[self weekDayStr] doubleValue];
    
    NSDate *intervalDate = [now dateByAddingTimeInterval:monthDays * oneDay];
    
    intervalDate = [intervalDate dateByAddingTimeInterval:weekDays * oneDay];
    
    NSString *dateStr = [formatter stringFromDate:intervalDate];
    
    NSString *timeStr = [NSString stringWithFormat:@" %@",[beginTimes objectForKey:day]];
    
    dateStr = [dateStr stringByAppendingString:timeStr];
    
    return dateStr;
}


- (NSString *)weekDayStr
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    
    [outputFormatter setDateFormat:@"EEEE"];
    [outputFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSString *newDateString = [outputFormatter stringFromDate:[NSDate date]];
    
    if ([newDateString isEqualToString:@"星期一"]) {
        return @"0";
    }
    if ([newDateString isEqualToString:@"星期二"]) {
        
        return @"1";
    }
    if ([newDateString isEqualToString:@"星期三"]) {
        
        return @"2";
    }
    if ([newDateString isEqualToString:@"星期四"]) {
        
        return @"3";
    }
    if ([newDateString isEqualToString:@"星期五"]) {
        
        return @"4";
    }
    if ([newDateString isEqualToString:@"星期六"]) {
        
        return @"5";
    }
    if ([newDateString isEqualToString:@"星期天"]) {
        return @"6";
    }
    return 0;
}

@end
