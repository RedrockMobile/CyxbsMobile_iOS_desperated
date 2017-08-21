//
//  LessonButtonController.h
//  Demo
//
//  Created by 李展 on 2016/11/13.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "LessonBtnModel.h"
#import "LessonButton.h"
@interface LessonButtonController : BaseViewController
@property LessonBtnModel *matter;
- (instancetype)initWithDay:(int)day Lesson:(int)lesson;
@property LessonButton *btn;
- (BOOL)matterWithWeek:(NSNumber *)week;
//- (BOOL)remindWithWeek:(NSNumber *)week;
@end
