//
//  Config.m
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 8/24/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "Config.h"

@implementation Config
+ (NSMutableDictionary *)paramWithStuNum:(NSString *)stuNum IdNum:(NSString *)idNum {
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:stuNum forKey:@"stuNum"];
    [param setValue:stuNum forKey:@"stu"];
    [param setValue:stuNum forKey:@"xh"];
    [param setValue:idNum forKey:@"idNum"];
    [param setValue:idNum forKey:@"sfzh"];
    return param;
}


+ (NSString *)errInfo:(NSInteger)status
{
    NSString *err[1000];
    for (int i = 0; i < 1000; i++) {
        err[i] = [NSString stringWithFormat:@"好像发生了未知错误啦，请及时报告网校人员，错误码%ld",status];
    }
    
    err[0] = @"您没有补考哟";
    return err[status];
}

+ (NSString *)transformDateFormat:(NSString *)dateString{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormat dateFromString:@"20140828"];
    [dateFormat setDateFormat:@"yyyy年MM月dd日"];
    return [dateFormat stringFromDate:date];
    
}

+ (NSString *)transformNumFormat:(NSString *)numString {
    NSInteger num = numString.integerValue;
    return weekdayWordsArr[num - 1];
}
@end
