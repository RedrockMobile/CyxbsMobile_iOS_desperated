//
//  UITextField+Custom.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/8.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "UITextField+Custom.h"

@implementation UITextField (Custom)

- (UITextField *) initWithPlaceholder:(NSString *)text andCell:(UITableViewCell *)cell {
    self = [[UITextField alloc] init];
    self.placeholder = text;
    [self sizeToFit];
    self.frame = CGRectMake(60, 15, MAIN_SCREEN_W-60-40, 30);
    self.font = [UIFont fontWithName:@"Arial" size:13];
    self.textAlignment = NSTextAlignmentRight;
    self.textColor = kDetailTextColor;
    self.center = CGPointMake(self.center.x, cell.center.y);
    return self;
}

@end
