//
//  OrangeAnimation.h
//  自定义动画
//
//  Created by user on 15/8/16.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrangeAnimation : UIView
@property (strong, nonatomic) NSMutableArray *animateChain;
@property (assign, nonatomic) NSInteger distributeAngle;//单位为度 default = 30

- (void) addAnimate:(void (^)(void))block withTime:(float)time;
- (void) runAnimation;


- (NSMutableArray *) addAnimateWithArray: (NSMutableArray *)animateArray
                                    time: (float)time
                            animateBlock: (void (^)(void)) block;

- (void)runWithAnimateChain:(NSMutableArray *)animateArray;
- (void)runAnimateChain:(NSMutableArray *)arr now:(int)indexPath;

/**
 *  @author Orange-W, 15-08-17 09:08:22
 *
 *  @brief  旋转
 *  @param angle           旋转角度
 *  @param time            时间
 *  @param view            旋转的视图
 *  @param distributeAngle 动画离散度(不能大于180) (默认为30)
 *  @return <#return value description#>
 */
+ (CGFloat)animateTransformWithRotate:(NSInteger)angle
                                 time:(CGFloat)time
                              forView:(UIView *)view
                           distribute:(NSInteger)distributeAngle
                      completionState:(void (^)())block;
/* 同上,默认动画离散度 */
+ (CGFloat)animateTransformWithRotate:(NSInteger)angle
                                 time:(CGFloat)time
                              forView:(UIView *)view;
@end
