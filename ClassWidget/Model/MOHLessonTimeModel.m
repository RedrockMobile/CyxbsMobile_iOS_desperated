//
//  MOHLessonTimeModel.m
//  MoblieCQUPT_iOS
//
//  Created by user on 16/3/18.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MOHLessonTimeModel.h"


@implementation MOHLessonTimeModel

#pragma mark - 课程时间表
//课程开始
- (NSDictionary *)lessonStart{
    return @{
             //早上
             @(1):@"08:00",//12
             @(3):@"10:05",//34

             //中午
             @(5):@"14:00",
             @(7):@"16:05",
             
             //晚上
             @(9) :@"19:00",
             @(11):@"21:50",
             };
}

//课程结束
- (NSDictionary *)lessonEnd{
    return @{
             //早上
             @(1):@"09:40",//12
             @(3):@"11:45",//34
             
             //中午
             @(5):@"15:40",
             @(7):@"17:45",
             //晚上
             @(9):@"20:40",
             @(11):@"22:30"
             };
}

//三节连上
- (NSDictionary *)serialLessonEnd{
    return @{
             @(1):@"11:00",//早上
             @(5):@"17:00",//中午
             @(11):@"22:00",//晚上
             
             };
    
}

+ (NSString *)stringWithBeginLesson:(NSInteger)beginLesson
                             period:(NSInteger)time{
    if (beginLesson == -1) {
        return @"您今天已经没有课程了";
    }
    
    MOHLessonTimeModel *MOHClass = [MOHLessonTimeModel new];
    NSString *string = [[MOHClass lessonStart][@(beginLesson)] mutableCopy];
    string = [string stringByAppendingString:@"~"];
    if (time == 3) {
        
        string = [string stringByAppendingString:[[MOHClass serialLessonEnd][@(beginLesson)] mutableCopy]
         ];
    }else{
        string = [string stringByAppendingString:[[MOHClass lessonEnd][@(beginLesson)] mutableCopy]];
    }
    return string;
}
@end
