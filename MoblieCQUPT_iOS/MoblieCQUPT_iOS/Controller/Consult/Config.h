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

#define COLOR_NAVIGATIONBAR [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]
#define COLOR_CONTENTBACKGROUND [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]
#define COLOR_CONTENTREGION [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
#define COLOR_MAINCOLOR [UIColor colorWithRed:255/255.0 green:152/255.0 blue:0/255.0 alpha:1]

#define API_EXAM_SCHEDULE @"http://hongyan.cqupt.edu.cn/api/examSchedule"
#define API_EXAM_GRADE @"http://jwc.cqupt.edu.cn/showStuQmcj.php"
#define API_EMPTY_ROOMS @"http://hongyan.cqupt.edu.cn/api/roomEmpty"
#define API_REEXAM_SCHEDULE @"http://hongyan.cqupt.edu.cn/examapi/index.php?s=/Home/Index/index"

#define roomGroupUncheckHint @"您还没有选择教学楼哦~"
#define periodGroupUncheckHint @"您还没有选择时段哦~"
#define bothGroupsUncheckHint @"您还没有选择教学楼和时段哦~"
#define noResultHint @"似乎没有合适的教室哦~"

#define consultingHint @"正在努力查询中~"
#define consultCompleteHint @"查询完毕，正在跳转~"
#define consultNetworkErrorHint @"网络似乎跪了qwq"

#define weekdayWordsArr @[@"一",@"二",@"三",@"四",@"五",@"六",@"天",]
#define buildList @[@"二教", @"三教", @"四教", @"五教", @"八教", @"任意教学楼"]
#define buildTagList {2, 3, 4, 5, 8, 0};
#define periodList @[@"1~2节", @"3~4节", @"5~6节", @"7~8节", @"9~10节", @"从早到晚"]

@interface Config : NSObject
+ (NSString *)errInfo:(NSInteger)status;
+ (NSMutableDictionary *)paramWithStuNum:(NSString *)stuNum IdNum:(NSString *)idNum;
+ (NSString *)transformDateFormat:(NSString *)dateString;
+ (NSString *)transformNumFormat:(NSString *)numString;
@end
