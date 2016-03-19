//
//  MOHLessonTimeModel.h
//  MoblieCQUPT_iOS
//
//  Created by user on 16/3/18.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOHLessonTimeModel : NSObject
@property (strong,readonly,nonatomic) NSArray *lessonStart;
@property (strong,readonly,nonatomic) NSArray *lessonEnd;
@property (strong,readonly,nonatomic) NSArray * serialLessonEnd;
+ (NSString *)stringWithBeginLesson:(NSInteger)beginLesson
                             period:(NSInteger)time;
+ (NSArray *)refreshLessonArray;
@end
