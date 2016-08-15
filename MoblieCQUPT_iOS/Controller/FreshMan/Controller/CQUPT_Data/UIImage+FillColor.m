//
//  UIImage+FillColor.m
//  FreshManFeature
//
//  Created by 李展 on 16/8/15.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "UIImage+FillColor.h"

@implementation UIImage (FillColor)
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
