//
//  ClassBook.h
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYCClassBookModel : NSObject
@property (nonatomic, strong) NSMutableArray *weekArray;
@property (nonatomic, copy) NSNumber *nowWeek;
- (void)getClassBookArray:(NSString *)stu_Num;
-(void)parsingData:(NSArray*)array;
@end
