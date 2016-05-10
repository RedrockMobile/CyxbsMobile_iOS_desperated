//
//  UITextField+Custom.h
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/8.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Custom)

- (UITextField *) initWithPlaceholder:(NSString *)text andCell:(UITableViewCell *)cell;

@end
