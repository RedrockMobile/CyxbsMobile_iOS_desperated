//
//  QueryDataModel.m
//  MoblieCQUPT_iOS
//
//  Created by MaggieTang on 12/10/2017.
//  Copyright © 2017 Orange-W. All rights reserved.
//

#import "QueryDataModel.h"
@interface QueryDataModel()
@end
@implementation QueryDataModel

-(instancetype)initWithData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        
    }
    return self;
}
//志愿者账号登录
-(void)volunteerLogin:(NSString *)account password:(NSString *)password{
    
    NSString *url = [NSString stringWithFormat:@"http://www.zycq.org/app/api/ver2.0.php?os=3&v=3&m=login&uname=%@&upass=%@",account,password];
    HttpClient *client = [HttpClient defaultClient];
    
    [client requestWithPath:url method:HttpRequestGet parameters:nil prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"请求成功%@",responseObject);
        NSString *status = responseObject[@"c"];
        
        if([status isEqual:[NSNumber numberWithInteger:0]]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"volunteerLoginSuccess" object:nil];
   
            self.uid = responseObject[@"d"][@"uid"];
            self.sid = responseObject[@"d"][@"sid"];
            self.login_name = responseObject[@"d"][@"login_name"];

        }
        else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"volunteerLoginFailure" object:nil];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败%@",error);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"volunteerLoginFailure" object:nil];
    }];
}
//获取志愿者账号信息
-(void)getVolunteerInfo:(NSString *)uid{
    NSString *url = [NSString stringWithFormat:@"http://www.zycq.org/app/api/ver2.0.php?os=3&v=3&id=%@&p=1&m=hour_vol",uid];
    HttpClient *client = [HttpClient defaultClient];
    
    [client requestWithPath:url method:HttpRequestGet parameters:nil prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"请求成功%@",responseObject);
        
        self.data = responseObject[@"d"];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败%@",error);
    }];
}
@end
