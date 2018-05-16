//
//  ReportModel.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/4/22.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ReportModel.h"
#define REPORTURL @"localhost/index.php/Home/Feedback/addReport"
@implementation ReportModel
- (void)setReport{
    HttpClient *client = [HttpClient defaultClient];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults objectForKey:@"stuNum"];
    [client requestWithPath:REPORTURL method:HttpRequestPost parameters:@{@"type":_type, @"content":_content, @"user_id": userId,@"question_id":_qusId} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
@end
