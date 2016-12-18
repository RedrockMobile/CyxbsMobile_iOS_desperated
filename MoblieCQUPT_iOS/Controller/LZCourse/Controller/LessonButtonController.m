//
//  LessonButtonController.m
//  Demo
//
//  Created by 李展 on 2016/11/13.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "LessonButtonController.h"
#import "LessonHandle.h"
#import "PrefixHeader.pch"
#import "UIImage+Color.h"
#import <Masonry.h>
@interface LessonButtonController ()
@property int lesson;
@property UIImageView *remindArrow;
@end

@implementation LessonButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (instancetype)initWithDay:(int)day Lesson:(int)lesson{
    self = [super init];
    if (self) {
        self.lesson = lesson;
        self.matter = [[LessonBtnModel alloc]init];
        self.view.frame = CGRectMake(MWIDTH+day*LESSONBTNSIDE+SEGMENT/2, lesson*LESSONBTNSIDE*2+SEGMENT/2, LESSONBTNSIDE-SEGMENT, LESSONBTNSIDE*2-SEGMENT);
        self.btn = [[LessonButton alloc]initWithFrame:self.view.frame];
    }
    return self;
}

- (BOOL)matterWithWeek:(NSNumber *)week{
    [self.remindArrow removeFromSuperview];
    [self.btn setTitle:@"" forState:UIControlStateNormal];
//    self.remindArrow = [[UIImageView alloc]init];
    if (self.lesson<6 && self.lesson >=4) {
        if (self.matter.lessonArray.count > 1) {
            [self.btn setBackgroundImage:[UIImage imageNamed:@"多课2"] forState:UIControlStateNormal];
        }
        else{
            [self.btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:120/255.f green:219/255.f blue:195/255.f alpha:1]] forState:UIControlStateNormal];
        }
    }
    else if (self.lesson<4 && self.lesson >=2) {
        if (self.matter.lessonArray.count >1) {
            [self.btn setBackgroundImage:[UIImage imageNamed:@"多课1"] forState:UIControlStateNormal];
        }
        else{
            [self.btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:249/255.f green:175/255.f blue:87/255.f alpha:1]] forState:UIControlStateNormal];
        }
    }
    else {
        if (self.matter.lessonArray.count > 1) {
            [self.btn setBackgroundImage:[UIImage imageNamed:@"多课0"] forState:UIControlStateNormal];
        }
        else{
            [self.btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:99/255.f green:210/255.f blue:246/255.f alpha:1]] forState:UIControlStateNormal];
        }
    }
    BOOL isHaveLesson = NO;
    for (LessonMatter *lesson in self.matter.lessonArray) {
        if([week isEqual:@0]){
            NSMutableString *btnTitle = [[lesson.course stringByAppendingString:lesson.classroom] mutableCopy];
            isHaveLesson = YES;
            if (![lesson.period isEqual:@2]) {
                [btnTitle appendFormat:@"(%@节)",lesson.period];
            }
            [self.btn setTitle:btnTitle forState:UIControlStateNormal];
            break;
        } //本学期
        if ([lesson.week containsObject:week]) {
            NSMutableString *btnTitle = [[lesson.course stringByAppendingString:lesson.classroom] mutableCopy];
            isHaveLesson = YES;
            if (![lesson.period isEqual:@2]) {
                [btnTitle appendFormat:@"(%@节)",lesson.period];
            }
            [self.btn setTitle:btnTitle forState:UIControlStateNormal];
            break;
        } //具体星期
    }
    
    BOOL isHaveRemind = NO;
    for (RemindMatter *remind in self.matter.remindArray) {
        if([week isEqual:@0]){
            if (isHaveLesson) {
                [self showRemindWithLesson];
            }
            else{
                [self showRemindWithoutLesson];
            }
            isHaveRemind = YES;
            break;
        } //本学期
        if ([remind.week containsObject:week]) {
            if (isHaveLesson) {
                [self showRemindWithLesson];
            }
            else{
                [self showRemindWithoutLesson];
            }
            isHaveRemind = YES;
            break;
        }
    }
    [self.view addSubview:self.btn];
    if (isHaveRemind || isHaveLesson) {
        return YES;
    }
    // 垃圾逻辑，等待修改
    return NO;
}

- (void)showRemindWithLesson{
    self.remindArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"remind"]];
    [self.btn addSubview:self.remindArrow];
    [self.remindArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btn).offset(-2);
        make.top.equalTo(self.btn).offset(2);
    }];
}

- (void)showRemindWithoutLesson{
    if (self.lesson<6 && self.lesson>=4) {
        [self.btn setBackgroundImage:[UIImage imageNamed:@"remind2"] forState:UIControlStateNormal];
    }
    else if(self.lesson <4 && self.lesson>= 2){
        [self.btn setBackgroundImage:[UIImage imageNamed:@"remind1"] forState:UIControlStateNormal];
    }
    else if(self.lesson <2 &&self.lesson>=0){
        [self.btn setBackgroundImage:[UIImage imageNamed:@"remind0"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
