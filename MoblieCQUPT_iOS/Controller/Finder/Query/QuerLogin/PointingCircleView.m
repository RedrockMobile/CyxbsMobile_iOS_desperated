//
//  PointingCircleView.m
//  Query
//
//  Created by hzl on 2017/3/3.
//  Copyright © 2017年 c. All rights reserved.
//

#import "PointingCircleView.h"

@implementation PointingCircleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //根据bounds计算中心点
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;

    
    //计算圆形半径
    CGFloat innerRadius = 6.5;
    CGFloat outerRadius = 8.5;
    CGFloat weekOuterRadius = 11.5;
    
    UIBezierPath *innerPath = [[UIBezierPath alloc] init];
    UIBezierPath *outerPath = [[UIBezierPath alloc] init];
    UIBezierPath *weekOuterPath = [[UIBezierPath alloc] init];
    
    innerPath.lineCapStyle = kCGLineCapRound;
    innerPath.lineJoinStyle = kCGLineJoinRound;
    
    outerPath.lineCapStyle = kCGLineCapRound;
    outerPath.lineJoinStyle = kCGLineJoinRound;
    
    weekOuterPath.lineCapStyle = kCGLineCapRound;
    weekOuterPath.lineJoinStyle = kCGLineJoinRound;
    
    //画圆
    [innerPath addArcWithCenter:center radius:innerRadius startAngle:0.0 endAngle:2.0 * M_PI clockwise:1];
    [outerPath addArcWithCenter:center radius:outerRadius startAngle:0.0 endAngle:2.0 * M_PI clockwise:1];
    [weekOuterPath addArcWithCenter:center radius:weekOuterRadius startAngle:0.0 endAngle:2.0 * M_PI clockwise:1];
    
    [[UIColor colorWithRed:18/255.0 green:208/255.0 blue:255/255.0 alpha:0.13]setFill];
    
    [weekOuterPath fill];
    
    
    [[UIColor colorWithRed:18/255.0 green:208/255.0 blue:255/255.0 alpha:0.20]setFill];
    
    [outerPath fill];
    
    [[UIColor colorWithRed:75/255.0 green:210/255.0 blue:255.0/255.0 alpha:0.85] setFill];
    
    [innerPath fill];
    
}

@end
