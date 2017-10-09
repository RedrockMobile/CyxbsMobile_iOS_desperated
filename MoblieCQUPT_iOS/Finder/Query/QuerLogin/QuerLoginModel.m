//
//  QuerLoginModel.m
//  Query
//
//  Created by hzl on 2017/3/1.
//  Copyright © 2017年 c. All rights reserved.
//

#import "QuerLoginModel.h"
#import "AFNetworking.h"
#define ELECTROLYSIS_URL @"https://redrock.team/MagicLoop/index.php?s=/addon/ElectricityQuery/ElectricityQuery/queryElecByRoom"

@interface QuerLoginModel()


@end

@implementation QuerLoginModel


- (void)RequestWithBuildingNum:(NSString *)buildingNum RoomNum:(NSString *)roomNum{
    NSDictionary *param = @{
                            @"building" : buildingNum,
                            @"room" : roomNum
                            };
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger POST:ELECTROLYSIS_URL parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        
            if (self.saveBlock) {
                self.saveBlock(jsonDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}

@end
