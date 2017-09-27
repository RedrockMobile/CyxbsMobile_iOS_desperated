//
//  LessonButtonViewModel.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/26.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LessonButtonViewModel.h"
#import "LZPersonModel.h"
#import "LessonMatter.h"
@interface LessonButtonViewModel()
@property (nonatomic, copy) NSArray <LZPersonModel *> *persons;
@property (nonatomic, assign) NSInteger week;
@property (nonatomic, assign) NSInteger beginLesson;
@end

@implementation LessonButtonViewModel
- (instancetype)initWithPersons:(NSArray <LZPersonModel *>*)persons andBeginLesson:(NSInteger)beginLesson{
    self = [self init];
    if (self) {
        self.persons = persons;
        self.beginLesson = beginLesson;
    }
    return self;
}

- (void)handleTitlesWithWeek:(NSInteger)week{
    self.titles = @"";
    self.isHidden = NO;
    self.week = week;
    NSMutableString *titles = @"".mutableCopy;
    for (LZPersonModel *person in self.persons) {
        BOOL isHaveLesson = NO;
        for (LessonMatter *lesson in person.lessons) {
            if (self.week == 0) {
                if (lesson.begin_lesson.integerValue == self.beginLesson && lesson.week.count != 0) {
                    isHaveLesson = YES;
                    break;
                }
            } // 整学期
            if (lesson.begin_lesson.integerValue == self.beginLesson && [lesson.week containsObject: @(self.week)]) {
                isHaveLesson = YES;
                break;
            } // 固定周
        }
        if (!isHaveLesson) {
            [titles appendString:[NSString stringWithFormat:@"%@/n",person.name]];
            self.isHidden = NO;
            self.titles = titles;
        }
    }
}

@end
