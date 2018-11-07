//
//  NSDate+schoolDate.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/12/8.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "NSDate+schoolDate.h"

@implementation NSDate(schoolDate)
- (NSDate *)getShoolData:(NSInteger)week andWeekday:(NSInteger)weekday{
    NSInteger nowWeek = [[UserDefaultTool valueWithKey:@"nowWeek"] integerValue];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval  oneDay = 24*60*60;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:nowDate];
    NSTimeInterval timeInterval = ((week-nowWeek)*7+(weekday-(components.weekday+6)%7))*oneDay;
    NSDate *date = [NSDate dateWithTimeInterval:timeInterval sinceDate:nowDate];
    return date;
}

@end
