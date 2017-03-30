//
//  LostTableViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/8.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LostTableViewController : UITableViewController
- (instancetype)initWithTitle:(NSString *)title Theme:(NSNumber *)theme;
typedef NS_ENUM(NSInteger,LZTheme){
    LZLost = 0,
    LZFound = 1
};
@end
