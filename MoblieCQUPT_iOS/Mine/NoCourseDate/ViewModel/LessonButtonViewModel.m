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
@property (nonatomic, assign) NSInteger day;
@end

@implementation LessonButtonViewModel
- (instancetype)initWithPersons:(NSArray <LZPersonModel *>*)persons day:(NSInteger)day andBeginLesson:(NSInteger)beginLesson{
    self = [self init];
    if (self) {
        self.persons = persons;
        self.beginLesson = beginLesson;
        self.day = day;
        if (self.beginLesson < 2) {
            self.color = @"#FF89A5";
        }
        else if(self.beginLesson >= 2 && self.beginLesson < 4){
            self.color = @"#FFBF7B";
        }
        else if(self.beginLesson >= 4 && self.beginLesson < 6){
            self.color = @"#81B6FE";
        }
    }
    return self;
}

- (void)handleTitlesWithWeek:(NSInteger)week{
    self.isHidden = YES;
    self.week = week;
    NSMutableString *titles = @"".mutableCopy;
    for (LZPersonModel *person in self.persons) {
        BOOL isHaveLesson = NO;
        for (LessonMatter *lesson in person.lessons) {
            if (self.week == 0) {
                if (lesson.hash_lesson.integerValue == self.beginLesson && lesson.hash_day.integerValue == self.day &&lesson.week.count != 0) {
                    isHaveLesson = YES;
                    break;
                }
            } // 整学期
            if (lesson.hash_lesson.integerValue == self.beginLesson && lesson.hash_day.integerValue == self.day && [lesson.week containsObject: @(self.week)]) {
                isHaveLesson = YES;
                break;
            } // 固定周
        }
        if (!isHaveLesson) {
            [titles appendString:[NSString stringWithFormat:@"%@ \n",person.name]];
            self.isHidden = NO;
            self.titles = titles;
        }
    }
}

@end
