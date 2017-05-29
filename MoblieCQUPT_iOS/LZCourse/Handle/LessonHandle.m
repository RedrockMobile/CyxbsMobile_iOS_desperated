//
//  LessonHandle.m
//  Demo
//
//  Created by 李展 on 2016/11/17.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "LessonHandle.h"
@implementation LessonHandle
+ (LessonMatter *)handle:(NSDictionary *)data{
    LessonMatter *matter = [[LessonMatter alloc]init];
    matter.hash_day = [data objectForKey:@"hash_day"];
    matter.hash_lesson = [data objectForKey:@"hash_lesson"];;
    matter.begin_lesson = [data objectForKey:@"begin_lesson"];//课程从第几节开始
    matter.day = [data objectForKey:@"day"];//星期几
    matter.lesson = [data objectForKey:@"lesson"];//课程节数
    matter.course = [data objectForKey:@"course"];//课程名称
    matter.teacher = [data objectForKey:@"teacher"];//老师
    matter.classroom = [data objectForKey:@"classroom"];//教室
    matter.rawWeek = [data objectForKey:@"rawWeek"];//课程周期 eg：1-16
    matter.weekModel = [data objectForKey:@"weekModel"];
    matter.weekBegin = [data objectForKey:@"weekBegin"];//课程开始的周
    matter.weekEnd = [data objectForKey:@"weekEnd"];//课程结束的周
    matter.type = [data objectForKey:@"type"];//必修 选修 重修
    matter.period = [data objectForKey:@"period"];//课程长度
    matter.week = [data objectForKey:@"week"];//课程的周数组
    return matter;
}
@end
