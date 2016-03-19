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
- (NSArray *)lessonStart{
    return @[
             //早上
             @"08:00",//12
             @"10:05",//34
             
             //中午
             @"14:00",
             @"16:05",
             
             //晚上
             @"19:00",
             @"21:05"
             ];
}

//课程结束
- (NSArray *)lessonEnd{
    return @[
             //早上
             @"09:40",//12
             @"11:45",//34
             
             //中午
             @"15:40",
             @"17:45",
             
             //晚上
             @"20:40",
             @"22:45"
             ];
}

//三节连上
- (NSArray *)serialLessonEnd{
    return @[
             @"11:00",//早上
             @"17:00",//中午
             @"22:00",//晚上
             
             ];
    
}

+ (NSString *)stringWithBeginLesson:(NSInteger)beginLesson
                             period:(NSInteger)time{
    if (beginLesson == -1) {
        return @"您今天已经没有课程了";
    }
    
    MOHLessonTimeModel *MOHClass = [MOHLessonTimeModel new];
    NSString *string = [[MOHClass lessonStart][beginLesson] mutableCopy];
    string = [string stringByAppendingString:@"~"];
    if (time == 3) {
        NSUInteger serialNum = ceilf(beginLesson/2);
        
        [string stringByAppendingString:[[MOHClass serialLessonEnd][serialNum] mutableCopy]
         ];
    }else{
        [string stringByAppendingString:[MOHClass lessonEnd][beginLesson]];
    }
    return string;
}
@end
