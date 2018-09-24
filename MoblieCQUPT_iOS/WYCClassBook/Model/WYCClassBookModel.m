//
//  ClassBook.m
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCClassBookModel.h"
#import "HttpClient.h"
#define URL @"https://wx.idsbllp.cn/api/kebiao"
@implementation WYCClassBookModel


- (void)getClassBookArray:(NSString *)stu_Num{
    self.weekArray = [[NSMutableArray alloc]init];
    
    NSDictionary *parameters = @{@"stu_num":stu_Num};
    
   [[HttpClient defaultClient] requestWithPath:URL method:HttpRequestPost parameters:parameters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSArray *array = [responseObject objectForKey:@"data"];
        [self ->_weekArray addObject:array];
        [self parsingData:array];
        
        NSNumber *nowWeek = responseObject[@"nowWeek"];
        self->_nowWeek = nowWeek;
        [UserDefaultTool saveValue:nowWeek forKey:@"nowWeek"];
        [UserDefaultTool saveValue:responseObject forKey:@"lessonResponse"];
        
        // 共享数据
        NSUserDefaults *shared = [[NSUserDefaults alloc]initWithSuiteName:kAPPGroupID];
        [shared setObject:responseObject forKey:@"lessonResponse"];
        [shared synchronize];
      
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WYCClassBookModelDataLoadSuccess" object:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
     
        NSLog(@"WYCClassBookModelLoadErrorCode:%@",error);
        [[NSNotificationCenter defaultCenter] postNotificationName: @"WYCClassBookModelDataLoadFailure" object:nil];
        
    }];
    
}
-(void)parsingData:(NSArray*)array{
    
    for (int weeknum = 1; weeknum <= 25; weeknum++) {
        NSMutableArray *tmp = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < array.count; i++) {
          
            NSArray *week = [array[i] objectForKey:@"week"];
            
            
            for (int j = 0;j < week.count; j++) { 
                NSNumber *k = week[j];
             
                if (weeknum == k.intValue) {
                    [tmp addObject:array[i]];
                }
            }
        }
        
        [_weekArray addObject:tmp];
       
        
    }
   
    
    
}



@end
