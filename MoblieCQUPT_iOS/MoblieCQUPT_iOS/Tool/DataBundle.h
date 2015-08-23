//
//  DataBundle.h
//  ConsultingTest
//
//  Created by RainyTunes on 8/22/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ViewController.h"
#import "MainViewController.h"

#define API_EXAM_SCHEDULE @"http://hongyan.cqupt.edu.cn/api/examSchedule"
#define API_EXAM_GRADE @"http://hongyan.cqupt.edu.cn/api/examGrade"
#define API_EMPTY_ROOMS @"http://hongyan.cqupt.edu.cn/api/roomEmpty"
#define API_REEXAM_SCHEDULE @"http://hongyan.cqupt.edu.cn/examapi/index.php?s=/Home/Index/index"

@interface DataBundle : NSObject

@property (strong,nonatomic)NSDictionary *dicWithParam;
@property (strong,nonatomic)NSMutableDictionary *json;
@property (strong,nonatomic)AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic)ViewController *delegate;
@property (strong,nonatomic)MainViewController *mainDelegate;

+ (NSMutableDictionary *)paramWithStuNum:(NSString *)stuNum IdNum:(NSString *)idNum;
+ (NSMutableDictionary *)paramWithWeekdayNum:(NSString *)weekdayNum
                                  SectionNum:(NSString *)sectionNum
                                    BuildNum:(NSString *)buildNum
                                        Week:(NSString *)week;
- (void)httpPost:(NSString *)typeStr;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
