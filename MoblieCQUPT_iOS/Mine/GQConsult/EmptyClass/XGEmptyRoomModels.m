//
//  XGEmptyRoomModels.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/9.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "XGEmptyRoomModels.h"
#define EmptyClassApi @"http://hongyan.cqupt.edu.cn/api/roomEmpty"
@implementation XGEmptyRoomModels
- (void)loadEmptyData{
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    week = [defaults objectForKey:@"nowWeek"];
    weekdayNum = [self currentDateWithFormatter:@"EEEE"];
    NSArray *weekdays = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Staurday", @"Sunday"];
    NSString *weekday = [NSString stringWithFormat:@"%ld", (unsigned long)[weekdays indexOfObject:weekdayNum] ];
    NSDictionary *data = @{@"week": week, @"weekday": weekday, @"buildNum": _buildNum, @"sectionNum": _sectionNum};
    _FinalData = [[NSDictionary alloc] init];
    [NetWork NetRequestPOSTWithRequestURL:EmptyClassApi WithParameter:data WithReturnValeuBlock:^(id returnValue) {
         _FinalData = [self handleData:returnValue[@"data"]];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"data" object:_FinalData];
    } WithFailureBlock:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"data" object:nil];
    }];
}

- (NSString *)currentDateWithFormatter:(NSString *)formatter
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:formatter];
    NSString *weekString = [dateformatter stringFromDate:date];
    return weekString;
}

- (NSDictionary *)handleData:(NSArray *)array {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *array1 = @[@"1",@"2",@"3",@"4",@"5"];
    for (int i = 0; i < array1.count; i ++) {
        NSMutableArray *newArray = [NSMutableArray array];
        for (int j = 0; j < array.count; j++) {
            NSString *string = [array[j] substringWithRange:NSMakeRange(1, 1)];
            if ([string isEqualToString:array1[i]]) {
                [newArray addObject:array[j]];
            }
        }
        [dic setObject:newArray forKey:array1[i]];
    }
    return dic;
}

@end
