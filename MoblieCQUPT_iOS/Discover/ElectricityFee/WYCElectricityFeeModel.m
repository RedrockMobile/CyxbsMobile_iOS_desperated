//
//  WYCElectricityFeeModel.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/4/2.
//  Copyright © 2019年 Orange-W. All rights reserved.
//

#import "WYCElectricityFeeModel.h"
#define ELECTROLYSIS_URL @"https://wx.idsbllp.cn/MagicLoop/index.php?s=/addon/ElectricityQuery/ElectricityQuery/queryElecByRoom"
@implementation WYCElectricityFeeModel


- (void)getFeeData:(NSString *)buildingNum RoomNum:(NSString *)roomNum{
    NSDictionary *parameters = @{
                            @"building" : buildingNum,
                            @"room" : roomNum
                            };
    
    [[HttpClient defaultClient] requestWithPath:ELECTROLYSIS_URL method:HttpRequestPost parameters:parameters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqual:[NSNumber numberWithInt:200]] ) {
            NSDictionary *elec_inf = [responseObject objectForKey:@"elec_inf"];
            self.elec_spend = elec_inf[@"elec_spend"];
            self.elec_start = elec_inf[@"elec_start"];
            self.elec_end = elec_inf[@"elec_end"];
            self.elec_free = elec_inf[@"elec_free"];
            self.lastmoney = elec_inf[@"lastmoney"];
            NSString *record_time = elec_inf[@"record_time"];
            self.record_time = [NSString stringWithFormat:@"抄表日期：%@",record_time];
            NSString *str1 = elec_inf[@"elec_cost"][0];
            NSString *str2 = elec_inf[@"elec_cost"][1];
            self.elec_cost = [NSString stringWithFormat:@"%@.%@",str1,str2];
            NSInteger elec = [[NSString stringWithFormat:@"%@",elec_inf[@"elec_spend"]] integerValue];
            CGFloat day = [[[NSString stringWithFormat:@"%@",elec_inf[@"record_time"]] substringFromIndex:3] floatValue];
            self.averag = [NSString stringWithFormat:@"%.2f",elec/day];
            self.dataArray = [NSArray arrayWithObjects:self.elec_cost,self.averag,self.elec_start,self.elec_end,self.elec_free, nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"FeeDataLoadSuccess" object:nil];
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"FeeDataLoadFail" object:nil];
        
      
    }];
    
    
}
@end
