//
//  LessonBtnModel.h
//  Demo
//
//  Created by 李展 on 2016/11/17.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LessonMatter.h"
#import "ExamMatter.h"
#import "RemindMatter.h"
@interface LessonBtnModel : NSObject
@property NSMutableArray <RemindMatter *> *remindArray;
@property NSMutableArray <LessonMatter *> *lessonArray;
@property NSMutableArray <ExamMatter *>   *examArray;
@property NSInteger longLesson;
@end
