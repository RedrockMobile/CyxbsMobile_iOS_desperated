//
//  FreshmanModel.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "FreshmanModel.h"
#import "HttpClient.h"
@implementation FreshmanModel



- (void)networkLoadData:(NSString *)urlStr title:(NSString *)title {
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
  
    [[HttpClient defaultClient] requestWithPath:urlStr method:HttpRequestGet parameters:nil prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        //获取测试用dic
        //NSLog(@"%@Modle连接成功",title);
        _dic = responseObject;
     
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat: @"%@DataLoadSuccess",title] object:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //NSLog(@"%@Modle连接失败",title);
        NSLog(@"%@LoadErrorCode:%@",title,error);
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat: @"%@DataLoadFailure",title] object:nil];
        
    }];
    
}

@end
