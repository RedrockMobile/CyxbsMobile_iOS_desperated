//
//  UIColor+Hex.h
//  Demo
//
//  Created by 李展 on 2016/12/9.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+(UIColor *)colorWithHex:(NSString *)hexColor;
+(UIColor *)colorWithHex:(NSString *)hexColor alpha:(float)alpha;
@end
