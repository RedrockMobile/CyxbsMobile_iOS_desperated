//
//  CampusSceneryModel.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/11.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "CampusSceneryModel.h"

@implementation CampusSceneryModel

-(void)getCampusSceneryData{
    NSString *url = @"https://cyxbsmobile.redrock.team/zscy/zsqy/json/6";
//    NSString *url = @"https://getman.cn/mock/schoolPic";
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:url method:HttpRequestGet parameters:nil prepareExecute:^{
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *info = [responseObject objectForKey:@"info"];
        if ([info  isEqualToString:@"ok"]) {
            NSDictionary *dic = [responseObject objectForKey:@"text"];
            NSString *photoName = [dic objectForKey:@"photo"];
            NSString *urlString = [NSString stringWithFormat:@"%@%@",@"https://cyxbsmobile.redrock.team/zscy/zsqy/image/",photoName];
            NSString * encodingString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//            NSLog(@"%@",urlString);
            self.schoolMapUrl = [NSURL URLWithString:encodingString];
            self.schoolPicArray = [dic objectForKey:@"message"];
            self.schoolPicNameArray = [[NSMutableArray alloc]init];
            self.schoolPicUrlArray = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in self.schoolPicArray) {
                [self.schoolPicNameArray addObject:[dic objectForKey:@"name"]];
                NSString *photoName = [dic objectForKey:@"photo"];
                
                NSString *urlString = [NSString stringWithFormat:@"%@%@",@"https://cyxbsmobile.redrock.team/zscy/zsqy/image/",photoName];
                NSString * encodingString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//                NSLog(@"%@",urlString);
                NSURL *url = [NSURL URLWithString:encodingString];
//                NSLog(@"%@",url);
                [self.schoolPicUrlArray addObject:url];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CampusSceneryDataLoadSuccess" object:nil];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}
@end
