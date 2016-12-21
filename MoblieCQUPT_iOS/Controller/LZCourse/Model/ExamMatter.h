//
//  ExamMatter.h
//  Demo
//
//  Created by 李展 on 2016/11/17.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "BaseMatter.h"

@interface ExamMatter : BaseMatter
@property NSString *begin_time;
@property NSString *end_time;
@property NSString *course;
@property NSNumber *week;
@property NSNumber *weekday;
@property NSString *classroom;
@property NSNumber *seat;
- (instancetype)initWithRemind:(NSDictionary *)remind;
@end
