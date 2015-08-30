//
//  MyTool.m
//  Class5
//
//  Created by RainyTunes on 8/12/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "We.h"
#import <UIKit/Uikit.h>

@implementation We : NSObject

# pragma mark Get Hexadecimal Conversion Methods
+ (NSString *)getHexWithDec:(NSInteger)num {
    NSString *per = @"";
    NSMutableString *result = [[NSMutableString alloc]init];
    int n = log10l(num)/log10(16);
    for (int i = n; i >= 0; i--) {
        int a = pow(16, i);
        switch (num / a) {
            case 15:
                per = @"f";
                break;
            case 14:
                per = @"e";
                break;
            case 13:
                per = @"d";
                break;
            case 12:
                per = @"c";
                break;
            case 11:
                per = @"b";
                break;
            case 10:
                per = @"a";
                break;
            default:
                per = [NSString stringWithFormat:@"%ld",num / a];
                break;
        }
        [result appendString:per];
        num = num - num / a * a;
    }
    return result;
}

+ (NSInteger)getDecWithHex:(NSString *)aString {
    [aString lowercaseString];
    NSInteger result = 0;
    int n;
    for (int i = (int)aString.length - 1; i >= 0; i--) {
        switch ([aString characterAtIndex:i]) {
            case 'f':
                n = 15;
                break;
            case 'e':
                n = 14;
                break;
            case 'd':
                n = 13;
                break;
            case 'c':
                n = 12;
                break;
            case 'b':
                n = 11;
                break;
            case 'a':
                n = 10;
                break;
            default:
                n = (int)[aString characterAtIndex:i] - 48;
                break;
        }
        result += pow(16, (int)aString.length - 1 - i) * n;
    }
    return result;
}

# pragma mark Get UIColor Methods
+ (UIColor *)getColor:(Color)color {
    NSArray *colorArray = [NSArray arrayWithObjects:@"#e51c23",@"#e91e63",@"#9c27b0"
                          ,@"#673ab7",@"#3f51b5",@"#5677fc",@"#03a9f4",@"#00bcd4"
                          ,@"#009688",@"#259b24",@"#8bc34a",@"#cddc39",@"#ffeb3b"
                          ,@"#ffc107",@"#ff9800",@"#ff5722",@"#795548",@"#9e9e9e"
                          ,@"#607d8b",nil];
    return [self getColorByRGBHex:(NSString *)[colorArray objectAtIndex:color]];
}

+ (UIColor *)getColorRandom {
    return [UIColor colorWithRed:arc4random() % 255 / 255.0
                           green:arc4random() % 255 / 255.0
                            blue:arc4random() % 255 / 255.0
                           alpha:1];
}

+ (UIColor *)getColorByRGBHex:(NSString *)hexString {
    NSInteger red, green, blue;
    red = [self getDecWithHex:[hexString substringWithRange:NSMakeRange(1, 2)]];
    green = [self getDecWithHex:[hexString substringWithRange:NSMakeRange(3, 2)]];
    blue = [self getDecWithHex:[hexString substringWithRange:NSMakeRange(5, 2)]];
    return [self getColorWithRed:red Green:green Blue:blue];
}

+ (UIColor *)getColorWithRed:(NSInteger)red Green:(NSInteger)green Blue:(NSInteger)blue {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

# pragma mark Others Methods
+ (NSDictionary *)getDictionaryWithHexData:(NSData *)hexData {
    if (hexData == nil) {
        return nil;
    }
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:hexData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"Failed to analyse Json：%@",err);
        return nil;
    }
    return dic;
}

+ (UIButton *)getButton {
    UIButton *button;
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = CGSizeMake(120, 40);
    button.frame = CGRectMake(0, 0, size.width, size.height);
    button.center = [self getScreenCenter];
    [button.layer setCornerRadius:5.0];
    button.layer.masksToBounds = YES;
    [button setBackgroundColor:[self getColor:OrangeDeep]];
    [button setBackgroundImage:[self getImageColored:[self getColorByRGBHex:@"#9e9e9e"] Size:size] forState:UIControlStateHighlighted];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button setTitleColor:[self getColorByRGBHex:@"#ffffff"] forState:UIControlStateNormal];
    [button setTitleColor:[self getColorByRGBHex:@"#f5f5f5"] forState:UIControlStateHighlighted];
    return button;
}

+ (UIButton *)getButtonWithTitle:(NSString *)title Color:(Color)color {
    UIButton *button = [self getButton];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:[self getColor:color]];
    return button;
}

+ (NSInteger)getScreenHeight {
    return CGRectGetHeight([UIScreen mainScreen].bounds);
}

+ (NSInteger)getScreenWidth {
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

+ (CGPoint)getScreenCenter {
    return CGPointMake([self getScreenWidth] / 2, [self getScreenHeight] / 2);
}

+ (CGRect)getScreenFrame {
    return CGRectMake(0, 0, [self getScreenWidth], [self getScreenHeight]);
}

+ (CGSize)getScreenSize {
    return CGSizeMake([self getScreenWidth], [self getScreenHeight]);
}
+ (UIImage *)getImageColored:(UIColor *)color Size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width,size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSArray *)getSameComponents:(NSArray *)arrayBundle {
    
    NSMutableArray *results = [[NSMutableArray alloc]init];
    NSMutableArray *theJoinedArray = [[NSMutableArray alloc]init];
    for (NSArray *array in arrayBundle) {
        [theJoinedArray addObjectsFromArray:array];
    }
    for (id aComponent in theJoinedArray) {
        if ([theJoinedArray hasComponent:aComponent] == arrayBundle.count &&
            [results hasComponent:aComponent] == 0) {
            [results addObject:aComponent];
        }
    }
    return results;
}


@end
