//
//  NSDate+schoolDate.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/12/8.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "NSDate+schoolDate.h"

@implementation NSDate(schoolDate)
- (NSDate *)getShoolData:(NSString *)week andWeekday:(NSString *)weekday nowWeek:(NSInteger)nowWeek{
    CGFloat week_float = week.floatValue;
    CGFloat weekday_float = weekday.floatValue;
    CGFloat diffNum = week_float - nowWeek;
    NSDate *nowDate = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    comps =[calendar components:NSCalendarUnitWeekday
                       fromDate:nowDate];
    NSArray *weekdays = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEEE";
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    NSString *string = [formatter stringFromDate:nowDate];
    NSInteger day = 7;
    for (NSString *str in weekdays) {
        day --;
        if ([str isEqualToString:string]) {
            break;
        }
    }


    NSDate *examDate = [nowDate dateByAddingTimeInterval: 60 * 60 * 24 * ((diffNum - 1) * 7 + 5 + day + weekday_float)];
    
    return examDate;
}

@end
