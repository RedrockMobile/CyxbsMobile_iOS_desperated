//
//  OrangeAnimation.m
//  自定义动画
//
//  Created by user on 15/8/16.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "OrangeAnimation.h"

@implementation OrangeAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animateChain = [[NSMutableArray alloc] init];
        self.distributeAngle = 30;
    }
    return self;
}

/***/
#pragma mark -核心递归调用
- (void)runAnimateChain:(NSMutableArray *)arr now:(int)indexPath{
    
    if (indexPath >= arr.count ) {
        return ;
    }
    
    NSDictionary *dic = arr[indexPath];
    NSTimeInterval time = [dic[@"time"] floatValue];
    void (^tmpBlock)() = dic[@"animation"];
    
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionLayoutSubviews  animations:tmpBlock
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self runAnimateChain:arr now:indexPath+1];
                         }
                     }];
    
}

- (void)runWithAnimateChain:(NSMutableArray *)animateArray{
    [self runAnimateChain:animateArray now:0];
    
}

- (NSMutableArray *) addAnimateWithArray:(NSMutableArray *)animateArray
                                    time:(float)time
                            animateBlock:(void (^)(void)) block{
    NSDictionary *dic = @{@"time":[NSNumber numberWithFloat:time],@"animation":block};
    [animateArray addObject:dic];
    return  animateArray;
}

- (void) addAnimate:(void (^)(void))block withTime:(float)time{
    NSDictionary *dic = @{@"time":[NSNumber numberWithFloat:time],@"animation":block};
    [self.animateChain addObject:dic];
}

- (void) runAnimation{
    [self runWithAnimateChain:self.animateChain];
}

/****/
#pragma mark -旋转
+ (CGFloat)animateTransformWithRotate:(NSInteger)angle
                              time:(CGFloat)time
                           forView:(UIView *)view
                        distribute:(NSInteger)distributeAngle
                           completionState:(void (^)())block
{
//CGAffineTransform ts = view.transform;
   OrangeAnimation *ani =  [[self alloc] init];
    distributeAngle = (distributeAngle>10 && distributeAngle<180)
                                ? distributeAngle
                                : ani.distributeAngle;
    
    NSInteger num = angle/distributeAngle;
    CGFloat everyAngle = angle/(float)num;
    CGFloat angleTmp = 0;
    CGFloat acgTime = time/num;
    
    for (int i=0; i<num; i++) {
        angleTmp = (i+1)*everyAngle;
        CGFloat rotation = angleTmp*(M_PI/180.0f);
        [ani addAnimate:^{
            CGAffineTransform tmpAni =  CGAffineTransformMakeRotation(rotation);
            view.transform = tmpAni;
        } withTime:acgTime];
    }
    
    [ani addAnimate:^{
        block();
    } withTime:acgTime];

    
    [ani runAnimation];
    return angleTmp;
}

+ (CGFloat)animateTransformWithRotate:(NSInteger)angle
                                 time:(CGFloat)time
                              forView:(UIView *)view
{
   return [OrangeAnimation animateTransformWithRotate:angle
                                           time:time
                                        forView:view
                                     distribute:30
                                    completionState:nil
           ];
}



@end
