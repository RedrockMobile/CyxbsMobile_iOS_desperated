//
//  dailyAttendanceModel.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "dailyAttendanceModel.h"
#import "HttpClient.h"
#import "UserDefaultTool.h"

@implementation dailyAttendanceModel

- (void)requestNewScore{
    HttpClient * client = [HttpClient defaultClient];
    [client requestWithPath:YOUWEN_CHECKIN_API method:HttpRequestPost parameters:@{@"stuNum":[UserDefaultTool getStuNum], @"idNum":[UserDefaultTool getIdNum]} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *sore = responseObject[@"data"];
        NSString *str = [sore stringValue];
        [self.delegate getSore:str];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate getSore:@"NULL"];
    }];
}

- (void)requestContinueDay{
    HttpClient * client = [HttpClient defaultClient];
    [client requestWithPath:YOUWEN_CREDIT_USE_RECORD_LIST_API method:HttpRequestPost parameters:@{@"stunum":[UserDefaultTool getStuNum], @"idnum":[UserDefaultTool getIdNum]} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *data = responseObject[@"data"];
        NSString *str = data[@"serialDays"];
        NSNumber *che = data[@"checked"];
        [self.delegate getSerialDay:str AndCheck:[che stringValue]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
@end
