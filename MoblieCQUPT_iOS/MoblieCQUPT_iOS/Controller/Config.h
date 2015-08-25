//
//  Config.h
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 8/24/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

#define API_EXAM_SCHEDULE @"http://hongyan.cqupt.edu.cn/api/examSchedule"
#define API_EXAM_GRADE @"http://jwc.cqupt.edu.cn/showStuQmcj.php"
#define API_EMPTY_ROOMS @"http://hongyan.cqupt.edu.cn/api/roomEmpty"
#define API_REEXAM_SCHEDULE @"http://hongyan.cqupt.edu.cn/examapi/index.php?s=/Home/Index/index"

@interface Config : NSObject
+ (NSString *)errInfo:(NSInteger)status;
+ (NSMutableDictionary *)paramWithStuNum:(NSString *)stuNum IdNum:(NSString *)idNum;
@end
