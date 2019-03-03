//
//  WYCClassAndNoteModel.h
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYCClassAndNoteModel : NSObject
@property (nonatomic, strong) NSMutableArray *weekArray;
@property (nonatomic, strong) NSMutableArray *noteArray;
@property (nonatomic, copy) NSNumber *nowWeek;
- (void)getClassBookArray:(NSString *)stu_Num;
- (void)getClassBookArrayFromNet:(NSString *)stu_Num;


- (void)getNote:(NSString *)stuNum idNum:(NSString *)idNum;
- (void)getNoteFromNet:(NSString *)stuNum idNum:(NSString *)idNum;
- (void)deleteNote:(NSString *)stuNum idNum:(NSString *)idNum noteId:(NSNumber *)noteId;

@end
