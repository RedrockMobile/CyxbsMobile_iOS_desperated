//
//  WYCNoteModel.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/9/23.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "WYCNoteModel.h"


@implementation WYCNoteModel

- (void)getNote:(NSString *)stuNum idNum:(NSString *)idNum{
    self.noteArray = [[NSMutableArray alloc]init];
    
    
    NSDictionary *parameters = @{@"stuNum":stuNum,@"idNum":idNum};
    
    [[HttpClient defaultClient] requestWithPath:GETREMINDAPI method:HttpRequestPost parameters:parameters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
        NSMutableArray *reminds = [responseObject objectForKey:@"data"];
        [reminds writeToFile:remindPath atomically:YES];
        
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
            NSNumber *period = [NSNumber numberWithInt:2];
            NSMutableDictionary *tmp = [array[i] mutableCopy];
            
            [tmp setObject:hash_day forKey:@"hash_day"];
            [tmp setObject:hash_lesson forKey:@"hash_lesson"];
            [tmp setObject:period forKey:@"period"];
            
            NSArray *weekArray = [date[time] objectForKey:@"week"];
            for (int week = 0; week < weekArray.count; week++) {
                 NSNumber *weekNum = weekArray[week];
                [_noteArray[weekNum.integerValue-1] addObject:tmp];
            }
        }
        
    }
    
    
}
- (void)deleteNote:(NSString *)stuNum idNum:(NSString *)idNum noteId:(NSNumber *)noteId{
    NSDictionary *parameters = @{@"stuNum":stuNum,@"idNum":idNum,@"id":noteId};
    
    [[HttpClient defaultClient] requestWithPath:DELETEREMINDAPI method:HttpRequestPost parameters:parameters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSNumber *result = [responseObject objectForKey:@"status"];
        if (result.integerValue == 200) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NoteDeleteSuccess" object:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"NoteDeleteFailure:%@",error);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NoteDeleteFailure" object:nil];
        
    }];
    
}

@end
