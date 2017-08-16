//
//  UIImage+Circle.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/8.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "UIImage+Circle.h"

@implementation UIImage (Cicle)
- (UIImage *)drawACircle{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef cg = UIGraphicsGetCurrentContext();
    CGFloat lenth;
    if (self.size.width >= self.size.height) {
        lenth = self.size.height;
    }
    else{
        lenth = self.size.width;
    }
    CGRect rect = CGRectMake(0, 0, lenth, lenth);
    CGContextAddEllipseInRect(cg, rect);
    CGContextClip(cg);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)cutCircleImage:(UIImage *)imageName
{
    return [imageName drawACircle];
}

@end
