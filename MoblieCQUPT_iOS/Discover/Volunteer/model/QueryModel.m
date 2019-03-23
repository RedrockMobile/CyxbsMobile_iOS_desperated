//
//  QueryModel.m
//  MoblieCQUPT_iOS
//
//  Created by MaggieTang on 07/10/2017.
//  Copyright © 2017 Orange-W. All rights reserved.
//

#import "QueryModel.h"

@implementation QueryModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [self init];
    if (self) {
        self.start_time = dic[@"start_time"];
        self.content = dic [@"content"];
        self.address = dic [@"address"];

        self.hours = dic [@"hours"];
        if ([self.hours.class isSubclassOfClass:[NSNumber class]] ) {
            self.hours = [(NSNumber *)self.hours stringValue];
        }
    }
    return self;
}

//查询时长
-(void)volunteerTimes:(NSString *)uid{
    NSString *encrptUid = [self aesEncrypt:uid];
    NSString *url = @"https://wx.redrock.team/volunteer/select";
    HttpClient *client = [HttpClient defaultClient];
    NSDictionary *head = @{@"Authorization":@"Basic enNjeTpyZWRyb2Nrenk=",@"Content-Type":@"application/x-www-form-urlencoded"};
    NSDictionary *parameters = @{@"uid":encrptUid};
    [client requestWithHead:url method:HttpRequestPost parameters:parameters head:head prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"志愿查询请求成功%@",responseObject);
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            self.hours = responseObject[@"hours"];
            self.record = responseObject[@"record"];
            self.uid = encrptUid;
            NSUserDefaults *hourDefault = [NSUserDefaults standardUserDefaults];
            [hourDefault setObject:self.hours forKey:@"totalhour"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"volunteerDataLoadSuccess" object:nil];
        }
        else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"volunteerDataLoadFailure" object:nil];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败%@",error);
         [[NSNotificationCenter defaultCenter] postNotificationName:@"volunteerDataLoadFailure" object:nil];
    }];
    
}
//志愿帐号密码绑定学号
-(void)volunteerBinding:(NSString *)account passwd:(NSString *)passwd uid:(NSString *)uid{
    
    NSString *encryptPasswd = [self aesEncrypt:passwd];
    NSString *url = @"https://wx.redrock.team/volunteer/binding";
    HttpClient *client = [HttpClient defaultClient];
    NSDictionary *head = @{@"Authorization":@"Basic enNjeTpyZWRyb2Nrenk=",@"Content-Type":@"application/x-www-form-urlencoded"};
    NSDictionary *parameters = @{@"account":account,@"password":encryptPasswd,@"uid":uid};
    [client requestWithHead:url method:HttpRequestPost parameters:parameters head:head prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"bangding请求成功%@",responseObject);
        //NSString *status = responseObject[@"c"];
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"volunteerBindingSuccess" object:nil];
        }
        else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"volunteerBindingFailure" object:nil];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败%@",error);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"volunteerBindingFailure" object:nil];
    }];
}

-(NSString *)aesEncrypt:(NSString *)plainText{
    NSString *secretkey = @"redrockvolunteer";
    NSString *cipherText = aesEncryptString(plainText, secretkey);
    return cipherText;
}
@end
