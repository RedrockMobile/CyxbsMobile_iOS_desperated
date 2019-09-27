//
//  NewsModel.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/9/28.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (void)getNewsList:(NSString *)pageNum{
    NSDictionary *parameters = @{@"page":pageNum};
    
    [[HttpClient defaultClient] requestWithPath:NEWSLIST method:HttpRequestGet parameters:parameters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"info"] isEqualToString:@"success"]) {
            NSArray *arr = [responseObject objectForKey:@"data"];
            [self.newsArray addObjectsFromArray:arr];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)getNewsDetail:(NSString *)newsId{
    NSDictionary *parameters = @{@"id":newsId,@"forceFetch":@"true"};
    [[HttpClient defaultClient] requestWithPath:NEWSLIST method:HttpRequestGet parameters:parameters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"info"] isEqualToString:@"success"]) {
           self.newsDetailDic = [responseObject objectForKey:@"data"];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
@end
