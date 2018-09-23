//
//  WYCNoteModel.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/9/23.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "WYCNoteModel.h"

#define URL @"https://wx.idsbllp.cn/cyxbsMobile/index.php/Home/Person/getTransaction"

@implementation WYCNoteModel

- (void)getNote:(NSString *)stuNum idNum:(NSString *)idNum{
    self.noteArray = [[NSMutableArray alloc]init];
    
    
    NSDictionary *parameters = @{@"stuNum":stuNum,@"idNum":idNum};
    
    [[HttpClient defaultClient] requestWithPath:URL method:HttpRequestPost parameters:parameters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSArray *dataArray = [responseObject objectForKey:@"data"];
        [self parsingData:dataArray];
       
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WYCNoteModelDataLoadSuccess" object:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"WYCNoteModelDataLoadFailure:%@",error);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WYCNoteModelDataLoadFailure" object:nil];
        
    }];
   
}
//解析数据
-(void)parsingData:(NSArray *)array{
    _noteArray = [[NSMutableArray alloc]initWithCapacity:25];
    for (int i = 0; i < 25; i++) {
        _noteArray[i] = [@[] mutableCopy];
    }
  
    
    
    for (int i = 0; i < array.count; i++) {
        NSArray *date = [array[i] objectForKey:@"date"];
        
        for (int time = 0; time < date.count; time++) {
            
            
            NSNumber *hash_day = [date[time] objectForKey:@"day"];
            NSNumber *hash_lesson = [date[time] objectForKey:@"class"];
            NSMutableDictionary *tmp = [array[i] mutableCopy];
            
            [tmp setObject:hash_day forKey:@"hash_day"];
            [tmp setObject:hash_lesson forKey:@"hash_lesson"];
            
            NSArray *weekArray = [date[time] objectForKey:@"week"];
            for (int week = 0; week < weekArray.count; week++) {
                 NSNumber *weekNum = weekArray[week];
                [_noteArray[weekNum.integerValue-1] addObject:tmp];
            }
        }
        
    }
    
    
}


@end
