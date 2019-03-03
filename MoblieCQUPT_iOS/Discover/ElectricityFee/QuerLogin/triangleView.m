//
//  triangleView.m
//  Query
//
//  Created by hzl on 2017/3/7.
//  Copyright © 2017年 c. All rights reserved.
//

#import "triangleView.h"

@implementation triangleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGFloat topPoint_x = (self.bounds.origin.x + self.bounds.size.width)/2.0;
    CGFloat topPoint_y = self.bounds.origin.y;
    CGFloat lowPoint_y = self.bounds.origin.y + self.bounds.size.height;
    
    CGPoint topPoint = CGPointMake(topPoint_x, topPoint_y);
    CGPoint leftPoint = CGPointMake(self.bounds.origin.x, lowPoint_y);
    CGPoint rightPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width , lowPoint_y);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:topPoint];
    [path addLineToPoint:leftPoint];
    [path addLineToPoint:rightPoint];
    [path addLineToPoint:topPoint];
    
    [[UIColor clearColor] setStroke];
    [[UIColor whiteColor] setFill];
    
    [path stroke];
    [path fill];
}


@end
