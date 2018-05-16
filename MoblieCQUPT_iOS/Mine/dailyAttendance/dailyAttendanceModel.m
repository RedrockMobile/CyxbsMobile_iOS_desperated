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

#define URL @"http://hongyan.cqupt.edu.cn/springtest/cyxbsMobile/index.php/QA/Integral/getDiscountBalance"
@implementation dailyAttendanceModel
- (void)requestNewScore{
    HttpClient * client = [HttpClient defaultClient];
    [client requestWithPath:URL method:HttpRequestPost parameters:@{@"stuNum":[UserDefaultTool getStuNum], @"idNum":[UserDefaultTool getIdNum]} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *sore = responseObject[@"data"];
        NSString *str = [sore stringValue];
        [self.delegate getSore:str];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}
@end
