//
//  SuceessWindow.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/5.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "SuccessWindow.h"
//#import <Masonry.h>

@interface SuccessWindow ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CADisplayLink *display;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat endAngle;

@end

@implementation SuccessWindow

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1].CGColor;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"复制成功";
        label.textColor = [UIColor colorWithRed:144/255.0 green:170/255.0 blue:255/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.label = label;
        
        self.x = 0;
        self.y = 0;
        self.display= [CADisplayLink displayLinkWithTarget:self selector:@selector(updatePath)];
        [self.display addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_W - 80, MAIN_SCREEN_H * 0.24);
    self.center = CGPointMake(MAIN_SCREEN_W * 0.5, MAIN_SCREEN_H * 0.4);
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).multipliedBy(1.5);
    }];
}

- (void)updatePath {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat circleCenterX = rect.size.width * 0.5;
    CGFloat circleCenterY = rect.size.height * 0.4;
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    
    if (self.x + w * 0.45 <= w * 0.489) {
        self.x += 0.5 * 1.41421;
        self.y += 0.5 * 1.41421;
        [path moveToPoint:CGPointMake(w * 0.45, h * 0.4)];
        [path addLineToPoint:CGPointMake(w * 0.45 + self.x, h * 0.4 + self.y)];
    } else {
        self.x += 0.7 * 1.41421;
        self.y -= 0.7 * 1.41421;
        [path moveToPoint:CGPointMake(w * 0.45, h * 0.4)];
        [path addLineToPoint:CGPointMake(w * 0.489, h * 0.47)];
        [path addLineToPoint:CGPointMake(w * 0.45 + self.x, h * 0.4 + self.y)];
    }
    
    if (self.x + w * 0.45 >= w * 0.55) {
        [self.display invalidate];
    }
    
    self.endAngle += 0.25;
    
    UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(circleCenterX, circleCenterY) radius:26 startAngle:- M_PI endAngle:- M_PI - self.endAngle clockwise:NO];
    
    CGContextAddPath(context, path.CGPath);
    CGContextAddPath(context, circle.CGPath);
    
    CGContextSetLineWidth(context, 3.5 );
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    [[UIColor colorWithRed:144/255.0 green:170/255.0 blue:255/255.0 alpha:1] set];;
    
    CGContextStrokePath(context);
}


@end
