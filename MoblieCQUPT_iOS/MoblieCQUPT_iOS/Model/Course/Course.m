//
//  Course.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/8/20.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "Course.h"

@implementation Course

- (id)initWithPropertiesDictionary:(NSDictionary *)dic {

    self = [super init];
    if (self) {
        if (dic != nil) {
            self.stuNum = [dic objectForKey:@"stuNum"];
            self.course = [dic objectForKey:@"course"];
            self.lesson = [dic objectForKey:@"lesson"];
            self.teacher = [dic objectForKey:@"teacher"];
            self.classroom = [dic objectForKey:@"classroom"];
            self.begin_lesson = [dic objectForKey:@"begin_lesson"];
            self.period = [dic objectForKey:@"period"];
            self.rawWeek = [dic objectForKey:@"rawWeek"];
            self.day = [dic objectForKey:@"day"];
            self.type = [dic objectForKey:@"type"];
            self.term = [dic objectForKey:@"term"];
            self.week = [dic objectForKey:@"week"];
            self.weekBegin = [dic objectForKey:@"weekBegin"];
            self.weekEnd = [dic objectForKey:@"weekEnd"];
            self.color = [dic objectForKey:@"color"];
        }
    }
    return self;
}

- (NSString *)description {
    NSString *result = @"";
    result = [result stringByAppendingFormat:@"stuNum : %@\n",self.stuNum];
    result = [result stringByAppendingFormat:@"course : %@\n",self.course];
    result = [result stringByAppendingFormat:@"lesson : %@\n",self.lesson];
    result = [result stringByAppendingFormat:@"teacher : %@\n",self.teacher];
    result = [result stringByAppendingFormat:@"classroom : %@\n",self.classroom];
    result = [result stringByAppendingFormat:@"begin_lesson : %@\n",self.begin_lesson];
    result = [result stringByAppendingFormat:@"period : %@\n",self.period];
    result = [result stringByAppendingFormat:@"rawWeek : %@\n",self.rawWeek];
    result = [result stringByAppendingFormat:@"day : %@\n",self.day];
    result = [result stringByAppendingFormat:@"type: %@\n",self.type];
    result = [result stringByAppendingFormat:@"term: %@\n",self.term];
    result = [result stringByAppendingFormat:@"week: %@\n",self.week];
    result = [result stringByAppendingFormat:@"weekBegin: %@\n",self.weekBegin];
    result = [result stringByAppendingFormat:@"weekEnd: %@\n",self.weekEnd];
    result = [result stringByAppendingFormat:@"color: %@\n",self.color];
    return result;
}


@end
