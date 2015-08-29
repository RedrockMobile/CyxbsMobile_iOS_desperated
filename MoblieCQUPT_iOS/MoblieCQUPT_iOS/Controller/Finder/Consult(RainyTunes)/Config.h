//
//  Config.h
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 8/24/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TEST_STU_NUM @"2014213071"
#define TEST_ID_NUM @"040975"
#define TEST_WEEKDAY_NUM @"1"
#define TEST_SECTION_NUM @"0"
#define TEST_BUILD_NUM @"2"
#define TEST_WEEK @"1"

#define API_EXAM_SCHEDULE @"http://hongyan.cqupt.edu.cn/api/examSchedule"
#define API_EXAM_GRADE @"http://jwc.cqupt.edu.cn/showStuQmcj.php"
#define API_EMPTY_ROOMS @"http://hongyan.cqupt.edu.cn/api/roomEmpty"
#define API_REEXAM_SCHEDULE @"http://hongyan.cqupt.edu.cn/examapi/index.php?s=/Home/Index/index"

#define roomGroupUncheckHint @"请选择教室~"
#define periodGroupUncheckHint @"请选择时段~"
#define bothGroupsUncheckHint @"请选择教室与时段~"
#define noResultHint @"似乎没有合适的教室哦~"

#define consultingHint @"正在努力查询中~"
#define consultCompleteHint @"查询完毕，正在跳转~"
#define consultNetworkErrorHint @"您的网络是不是跪了，如果不是那就是我跪了qwq"

#define buildList @[@"二教", @"三教", @"四教", @"五教", @"八教", @"任意教室"]
#define buildTagList {2,3,4,5,8,0};
#define periodList @[@"一二节", @"三四节", @"五六节", @"七八节", @"九十节", @"全部时段"]
#define defaultResult @"请选择教室与时段~"

@interface Config : NSObject
+ (NSString *)errInfo:(NSInteger)status;
+ (NSMutableDictionary *)paramWithStuNum:(NSString *)stuNum IdNum:(NSString *)idNum;
@end
