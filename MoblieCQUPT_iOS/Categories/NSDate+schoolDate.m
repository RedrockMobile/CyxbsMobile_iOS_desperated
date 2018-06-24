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
    NSInteger diffNum = week - nowWeek;
    NSDate *nowDate = [NSDate date];
    NSDate *examDate = [nowDate dateByAddingTimeInterval: 60 * 60 * 24 * ((diffNum - 1) * 7 + weekday)];
    return examDate;
}

@end
