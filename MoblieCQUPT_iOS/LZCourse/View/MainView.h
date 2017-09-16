//
//  MainView.h
//  Demo
//
//  Created by 李展 on 2016/10/26.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayLabel.h"
#import "LessonButton.h"
#import "LessonNumLabel.h"
@interface MainView : UIView
@property UIScrollView *scrollView;
@property DayLabel *monthLabel;
@property NSMutableArray<DayLabel *> *dayLabels;
@property NSMutableArray<LessonButton *> *lessonBtns;
@property NSMutableArray<LessonNumLabel *> *lessonsLabel;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)loadDayLbTimeWithWeek:(NSInteger)week nowWeek:(NSInteger)nowWeek;
@end
