//
//  CourseView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/8/22.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "CourseView.h"

@implementation CourseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.alpha = 0.6;
        [[[UIApplication sharedApplication]keyWindow]addSubview : self];
        [self loadAlertView];
        
    }
    return self;
}

- (void)loadAlertView {
    _courseScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(ScreenWidth/6, ScreenHeight/5, ScreenWidth/6*4, ScreenHeight/5*3)];
    
    _courseScroll.contentSize = CGSizeMake(ScreenWidth/6*4*2, ScreenHeight/5*3);
    [[[UIApplication sharedApplication]keyWindow]addSubview : _courseScroll];
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/6*4, ScreenHeight/5*3)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 5.0;
    [_courseScroll addSubview:_alertView];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth/6*4-20, 50)];
    titleLabel.text = @"课程详细信息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:25];
    titleLabel.textColor = MAIN_COLOR;
    [_alertView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth/6*4, 2)];
    lineView.backgroundColor = MAIN_COLOR;
    [_alertView addSubview:lineView];
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(10, ScreenHeight-ScreenHeight/5*2-60, ScreenWidth/6*4-20, 50)];
    done.layer.cornerRadius = 5.0;
    [done setTitle:@"确认" forState:UIControlStateNormal];
    done.backgroundColor = MAIN_COLOR;
    done.titleLabel.textAlignment = NSTextAlignmentCenter;
    [done addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:done];
}

- (void)doneClick {
    [self removeFromSuperview];
    [_courseScroll removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
