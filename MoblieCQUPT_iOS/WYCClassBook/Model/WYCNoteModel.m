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
-(void)parsingData:(NSArray *)noteArray{
    _noteArray = [[NSMutableArray alloc]initWithCapacity:25];
    for (int i = 0; i < 25; i++) {
        _noteArray[i] = [@[] mutableCopy];
    }
    NSMutableArray *array = [noteArray mutableCopy];
    
    for (int i = 0; i < noteArray.count; i++) {
        array[i] = [noteArray[i] mutableCopy];
    }
    
    for (int i = 0; i < array.count; i++) {
        NSArray *date = [array[i] objectForKey:@"date"];
        NSArray *weekArray = [date[i] objectForKey:@"week"];
        for (int time = 0; time < date.count; time++) {
            NSNumber *hash_day = [date[time] objectForKey:@"day"];
            NSNumber *hash_lesson = [date[time] objectForKey:@"class"];
            
            
            [array[i] setObject:hash_day forKey:@"hash_day"];
            [array[i] setObject:hash_lesson forKey:@"hash_lesson"];
            
            
        }
        
        for (int j = 0; j < weekArray.count; j++) {
            NSNumber *weekNum = weekArray[j];
            [_noteArray[weekNum.integerValue - 1] addObject:[array[i] mutableCopy]];
        }
        
        //[array[i] removeObjectForKey:@"date"];
    }
    
    NSLog(@"%@",_noteArray[1]);
    
    
}


@end
