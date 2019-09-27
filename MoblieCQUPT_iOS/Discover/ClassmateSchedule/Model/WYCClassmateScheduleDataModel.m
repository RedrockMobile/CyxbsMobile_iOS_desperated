//
//  WYCClassmateScheduleDataModel.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/3/8.
//  Copyright © 2019年 Orange-W. All rights reserved.
//

#import "WYCClassmateScheduleDataModel.h"
@interface WYCClassmateScheduleDataModel()
//课表
@property (nonatomic, assign) BOOL classDataLoadFinish;

@end

@implementation WYCClassmateScheduleDataModel



- (void)getClassBookArrayFromNet:(NSString *)stu_Num{
    self.classDataLoadFinish = NO;
    self.weekArray = [[NSMutableArray alloc]init];
    
    NSDictionary *parameters = @{@"stu_num":stu_Num};
    
    [[HttpClient defaultClient] requestWithPath:URL method:HttpRequestPost parameters:parameters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSArray *lessonArray = [responseObject objectForKey:@"data"];
        
       
        [self.weekArray addObject:lessonArray];
        [self parsingClassBookData:lessonArray];
        
        self.classDataLoadFinish = YES;
        [self loadFinish];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"WYCClassmateScheduleModelLoadErrorCode:%@",error);
        self.classDataLoadFinish = NO;
        [self loadFinish];
    }];
    
}
-(void)parsingClassBookData:(NSArray*)array{
    
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


-(void)loadFinish{
    if (self.classDataLoadFinish ==YES) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WYCClassmateScheduleDataModelDataLoadSuccess" object:nil];
    }
    if (self.classDataLoadFinish == NO) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WYCClassmateScheduleDataModelDataLoadFailure" object:nil];
    }
    
}
@end

