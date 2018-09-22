//
//  ClassBook.m
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "ClassBook.h"
#import "HttpClient.h"
#define URL @"https://wx.idsbllp.cn/api/kebiao"
@implementation ClassBook


- (void)getClassBookArray:(NSString *)stu_Num title:(NSString *)title {
    self.weekArray = [[NSMutableArray alloc]init];
    
    NSDictionary *parameters = @{@"stu_num":stu_Num};
    
   [[HttpClient defaultClient] requestWithPath:URL method:HttpRequestPost parameters:parameters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        //获取测试用dic
        //NSLog(@"%@Modle连接成功",title);
        NSArray *array = [responseObject objectForKey:@"data"];
        self->_classBookArray = [[NSMutableArray alloc]init];
        //[self->_classBookArray addObject:array];
        
        [self ->_weekArray addObject:array];
        [self transform:array];
        //NSLog(@"classbookArray:%@",array);
        self->_nowWeek = [responseObject objectForKey:@"nowWeek"];
        //NSLog(@"week1:%@",self->_classBookArray[0]);
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat: @"%@DataLoadSuccess",title] object:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //NSLog(@"%@Modle连接失败",title);
        NSLog(@"%@LoadErrorCode:%@",title,error);
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat: @"%@DataLoadFailure",title] object:nil];
        
    }];
    
}
-(void)transform:(NSArray*)array{
    //临时数组，用来保存按星期存储的数据
    NSMutableArray *weekArray = [[NSMutableArray alloc]init];
    
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
        
        [weekArray addObject:tmp];
        
//        [_classBookArray addObject:tmp];
        
    }
    
    _weekArray = weekArray;
    
    //把数据转换成按每天每节课分
    
    
    //遍历每一周的数据
    for (int i = 0 ; i < weekArray.count; i++) {
        //一节课分7天
        NSMutableArray *alesson = [[NSMutableArray alloc]initWithCapacity:7];
        
        for (int i = 0; i < 7; i++) {
            alesson[i] = @"";
        }
        NSMutableArray *aweek = [[NSMutableArray alloc]initWithCapacity:6];
        //一周共6节课
        for (int i = 0; i < 6; i++) {
            aweek[i] = [alesson mutableCopy];
        }
        //提取第i周数据到数组
        NSArray *arr = [[NSArray alloc]init];
           arr = weekArray[i];
        for (int j = 0; j < arr.count; j++) {
            //遍历第i周的数据，先按星期几分开，存入aday数组
//            NSString *day = [arr[j] objectForKey:@"day"];
//            NSString *lesson = [arr[j] objectForKey:@"lesson"];
//            NSArray *lessonAndDay = [self calculateLessonInDay:day lesson:lesson];
//            NSNumber *dayNum = lessonAndDay[0];
//            NSNumber *lessonNum = lessonAndDay[1];
//
            NSNumber *hash_day = [arr[j] objectForKey:@"hash_day"];
            NSNumber *hash_lesson = [arr[j] objectForKey:@"hash_lesson"];
            //[aweek[hash_lesson.intValue] insertObject:arr[j] atIndex:hash_day.intValue];
            aweek[hash_lesson.integerValue][hash_day.integerValue] = arr[j];
            //NSLog(@"d:%@,l:%@,j:%d",hash_day,hash_lesson,j);
           
        }
        //NSLog(@"aweek%@",aweek[1][0]);
        
        [_classBookArray addObject:aweek];
       
    }
    
    //NSLog(@"_classBookArray:%@",_classBookArray[0][0][1] );
    
    
}




-(NSArray *)calculateLessonInDay:(NSString *)day lesson:(NSString *)lesson{
    NSInteger dayNum = 0, lessonNum = 0;
    
    if ([day isEqualToString:@"星期一"]) {
        dayNum = 0;
    }else if ([day isEqualToString:@"星期二"]){
        dayNum = 1;
    }else if ([day isEqualToString:@"星期三"]){
        dayNum = 2;
    }else if ([day isEqualToString:@"星期四"]){
        dayNum = 3;
    }else if ([day isEqualToString:@"星期五"]){
        dayNum = 4;
    }else if ([day isEqualToString:@"星期六"]){
        dayNum = 5;
    }else{
        dayNum = 6;
    }
    
    if ([lesson isEqualToString:@"一二节"]) {
        lessonNum = 0;
    }else if ([lesson isEqualToString:@"三四节"]){
        lessonNum = 1;
    }else if ([lesson isEqualToString:@"五六节"]){
        lessonNum = 2;
    }else if ([lesson isEqualToString:@"七八节"]){
        lessonNum = 3;
    }else if ([lesson isEqualToString:@"九十节"]){
        lessonNum = 4;
    }else {
        lessonNum = 5;
    }
    
    NSArray *lessonAndDay = [NSArray arrayWithObjects:[NSNumber numberWithInteger:dayNum],[NSNumber numberWithInteger:lessonNum], nil];
    return lessonAndDay;
}

//if ([day isEqualToString:@"星期一"]) {
//    aday[0] = arr[j];
//}else if ([day isEqualToString:@"星期二"]){
//    aday[1] = arr[j];
//}else if ([day isEqualToString:@"星期三"]){
//    aday[2] = arr[j];
//}else if ([day isEqualToString:@"星期四"]){
//    aday[3] = arr[j];
//}else if ([day isEqualToString:@"星期五"]){
//    aday[4] = arr[j];
//}else if ([day isEqualToString:@"星期六"]){
//    aday[5] = arr[j];
//}

@end
