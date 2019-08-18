//
//  BusRoutesModel.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/11.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "BusRoutesModel.h"

@implementation BusRoutesModel

-(void)getBusRoutesData{
    NSString *url = @"http://129.28.185.138:8080/zsqy/json/5";
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:url method:HttpRequestGet parameters:nil prepareExecute:^{
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSNumber *code = [responseObject objectForKey:@"code"];
        if ([code  isEqual: @200]) {
            self.recommendedRouteData = [responseObject objectForKey:@"text_2"];
            NSArray *array = [self.recommendedRouteData objectForKey:@"message"];
            self.nameArray = [[NSMutableArray alloc]init];
            self.routeArray = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in array) {
                [self.nameArray addObject:[dic objectForKey:@"name"]];
            }
            for (NSDictionary *dic in array) {
                NSArray *arr = [dic objectForKey:@"route"];
                [self.routeArray addObject:arr[0]];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BusRoutesDataLoadSuccess" object:nil];
            // NSLog(@"%@",self.recommendedRouteData);
        }
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      
        NSLog(@"%@",error);
    }];
}
@end
