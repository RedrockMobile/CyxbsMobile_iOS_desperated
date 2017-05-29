//
//  TopicRequest.m
//  TopicSearch
//
//  Created by hzl on 2017/5/21.
//  Copyright © 2017年 hzl. All rights reserved.
//

#import "TopicRequest.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

#define TOPIC_URL @"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Topic/topicList"

#define MYJOINTOPIC_URL @"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Topic/myJoinedTopic"

@implementation TopicRequest

- (void)requestImageForImageView:(UIImageView *)imageView withUrlStr:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20];
    
    [imageView setImageWithURLRequest:request placeholderImage:nil success:nil failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestTopicDataWithSize:(NSString *)size page:(NSString *)page searchText:(NSString *)serachText{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (serachText) {
        [manager POST:TOPIC_URL parameters:@{@"size":size,
                                            @"page":page,
                                            @"searchKeyword":serachText}
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                 if(self.topicBlk){
                     self.topicBlk(dataDic);
                 }
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 if (error) {
                     NSLog(@"%@",error);
                 }
             }];
    }else{
    [manager POST:TOPIC_URL parameters:@{@"size":size,
                                        @"page":page}
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
             if(self.topicBlk){
                 self.topicBlk(dataDic);
             }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

}


- (void)requestMyJoinTopicDataWithSize:(NSString *)size page:(NSString *)page stuNum:(NSString *)stuNum idNum :(NSString *)idNum searchText:(NSString *)searchText{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (searchText) {
        [manager POST:MYJOINTOPIC_URL parameters:@{@"size":size,
                                                  @"page":page,
                                                  @"stuNum":stuNum,
                                                  @"idNum":idNum,
                                                  @"keyword":searchText}
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                if(self.myJoinBlk){
                    self.myJoinBlk(dataDic);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSLog(@"%@",error);
                }
            }];
    }else{
        [manager POST:MYJOINTOPIC_URL parameters:@{@"size":size,
                                                  @"page":page,
                                                  @"stuNum":stuNum,
                                                  @"idNum":idNum}
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                if (self.myJoinBlk) {
                    self.myJoinBlk(dataDic);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSLog(@"%@",error);
                }
            }];
    }
}

@end
