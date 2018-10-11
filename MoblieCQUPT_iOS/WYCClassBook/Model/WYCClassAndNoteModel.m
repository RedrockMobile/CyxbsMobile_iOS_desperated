//
//  WYCClassAndNoteModel.m
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCClassAndNoteModel.h"
#import "HttpClient.h"
#define URL @"https://wx.idsbllp.cn/api/kebiao"
@interface WYCClassAndNoteModel()
//课表
@property (nonatomic, assign) BOOL classDataLoadFinish;
@property (nonatomic, assign) BOOL noteDataLoadFinish;
//备忘

@end
@implementation WYCClassAndNoteModel


- (void)getClassBookArray:(NSString *)stu_Num{
    //如果有缓存，则从缓存加载数据
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *lessonPath = [path stringByAppendingPathComponent:@"lesson.plist"];
    NSArray *array = [NSMutableArray arrayWithContentsOfFile:lessonPath];
    
    if (array) {
        self.weekArray = [[NSMutableArray alloc]init];
        [self.weekArray addObject:array];
        
        [self parsingData:array];
        
        self.classDataLoadFinish = YES;
        [self loadFinish];
    }else{
        
        [self getClassBookArrayFromNet:stu_Num];
    }
}
- (void)getClassBookArrayFromNet:(NSString *)stu_Num{
    self.classDataLoadFinish = nil;
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
        //数据缓存
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *lessonPath = [path stringByAppendingPathComponent:@"lesson.plist"];
        NSArray *lesson = [responseObject objectForKey:@"data"];
        [lesson writeToFile:lessonPath atomically:YES];
        
        // 共享数据
        NSUserDefaults *shared = [[NSUserDefaults alloc]initWithSuiteName:kAPPGroupID];
        [shared setObject:responseObject forKey:@"lessonResponse"];
        [shared synchronize];
        
        self.classDataLoadFinish = YES;
        [self loadFinish];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"WYCClassBookModelLoadErrorCode:%@",error);
        self.classDataLoadFinish = NO;
        [self loadFinish];
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


//备忘
- (void)getNote:(NSString *)stuNum idNum:(NSString *)idNum{
    //如果有缓存，则从缓存加载数据
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
    NSArray *array = [NSMutableArray arrayWithContentsOfFile:remindPath];
    
    if (array) {
        self.noteArray = [[NSMutableArray alloc]init];
        
        [self parsingNoteData:array];
        
        self.noteDataLoadFinish = YES;
        [self loadFinish];
    }else{
        
        [self getNoteFromNet:stuNum idNum:idNum];
    }
}
- (void)getNoteFromNet:(NSString *)stuNum idNum:(NSString *)idNum{
    self.noteArray = [[NSMutableArray alloc]init];
    self.noteDataLoadFinish = nil;
    
    NSDictionary *parameters = @{@"stuNum":stuNum,@"idNum":idNum};
    
    [[HttpClient defaultClient] requestWithPath:GETREMINDAPI method:HttpRequestPost parameters:parameters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
        NSMutableArray *reminds = [responseObject objectForKey:@"data"];
        
        [reminds writeToFile:remindPath atomically:YES];
        
        NSArray *dataArray = [responseObject objectForKey:@"data"];
        [self parsingNoteData:dataArray];
        
        self.noteDataLoadFinish = YES;
        [self loadFinish];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"WYCNoteModelDataLoadFailure:%@",error);
        self.noteDataLoadFinish = NO;
        [self loadFinish];
    }];
    
}
//解析数据
-(void)parsingNoteData:(NSArray *)array{
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

-(void)loadFinish{
    if (self.classDataLoadFinish == YES&&self.noteDataLoadFinish == YES) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ModelDataLoadSuccess" object:nil];
    }
    if (self.classDataLoadFinish == NO&&self.noteDataLoadFinish == NO) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ModelDataLoadFailure" object:nil];
    }
    
}
@end
