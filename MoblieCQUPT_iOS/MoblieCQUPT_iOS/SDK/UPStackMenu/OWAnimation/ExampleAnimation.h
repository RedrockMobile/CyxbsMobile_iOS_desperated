//
//  ExampleAnimation.h
//  自定义动画
//
//  Created by user on 15/8/19.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExampleAnimation : UIView
@property (strong, nonatomic) NSMutableArray *uikitArray;

+ (void) discoverViewAnimation:(UIView *)aniView;

+ (NSMutableArray *)AnimationFrom:(UIView *)fromView ;//
@end