//
//  Course.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/8/20.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (strong, nonatomic)NSString *stuNum;//学生学号
@property (strong, nonatomic)NSString *course;//课程名称
@property (strong, nonatomic)NSString *lesson;//课程节数
@property (strong, nonatomic)NSString *teacher;//老师
@property (strong, nonatomic)NSString *classroom;//教室
@property (strong, nonatomic)NSString *begin_lesson;//课程从第几节开始
@property (strong, nonatomic)NSString *period;//课程长度
@property (strong, nonatomic)NSString *rawWeek;//课程周期 eg：1-16
@property (strong, nonatomic)NSString *day;//星期几
@property (strong, nonatomic)NSString *type;//必修 选修 重修
@property (strong, nonatomic)NSString *term;//学期
@property (strong, nonatomic)NSArray *week;//课程的周数组
@property (strong, nonatomic)NSString *weekBegin;//课程开始的周
@property (strong, nonatomic)NSString *weekEnd;//课程结束的周

@property (strong, nonatomic)NSString *color;//课程颜色



- (id)initWithPropertiesDictionary:(NSDictionary *)dic;

@end
