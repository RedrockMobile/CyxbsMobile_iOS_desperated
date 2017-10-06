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
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DayLabel *monthLabel;
@property (nonatomic, strong) NSMutableArray<DayLabel *> *dayLabels;
@property (nonatomic, strong) NSMutableArray<LessonButton *> *lessonBtns;
@property (nonatomic, strong) NSMutableArray<LessonNumLabel *> *lessonsLabel;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)loadDayLbTimeWithWeek:(NSInteger)week nowWeek:(NSInteger)nowWeek;
@end
