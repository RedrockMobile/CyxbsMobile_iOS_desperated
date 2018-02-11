//
//  UITextField+Custom.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/8.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "UITextField+Custom.h"

@implementation UITextField (Custom)

+ (UITextField *) initWithPlaceholder:(NSString *)text andCell:(UITableViewCell *)cell {
    UITextField *custom = [[UITextField alloc] init];
    custom.placeholder = text;
    [custom sizeToFit];
    custom.frame = CGRectMake(60, 15, MAIN_SCREEN_W-60-40, 30);
    custom.font = [UIFont fontWithName:@"Arial" size:13];
    custom.textAlignment = NSTextAlignmentRight;
    custom.textColor = kDetailTextColor;
    custom.center = CGPointMake(custom.center.x, cell.center.y);
    return custom;
}
@end
