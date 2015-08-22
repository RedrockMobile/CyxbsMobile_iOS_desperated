//
//  ExampleAnimation.m
//  自定义动画
//
//  Created by user on 15/8/19.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "ExampleAnimation.h"
#import "OrangeAnimation.h"

@implementation ExampleAnimation


+ (void) discoverViewAnimation:(UIView *)aniView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor grayColor];
    [backView setAlpha:0.5];
    [aniView addSubview:backView];
    OrangeAnimation *ani = [[OrangeAnimation alloc] init];
    [ani addAnimate:^{
        
        backView.frame  = CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2, 80, 120);
        backView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        
    } withTime:0.3];
    
    [ani addAnimate:^{
        backView.frame  = [UIScreen mainScreen].bounds;
        
    } withTime:0.7];
    [ani runAnimation];
    
    [OrangeAnimation animateTransformWithRotate:720 time:1.1 forView:backView distribute:30 completionState:^{
        backView.frame  = [UIScreen mainScreen].bounds;
    }];
}




@end