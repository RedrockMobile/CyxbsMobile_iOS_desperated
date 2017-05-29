//
//  DetailRemindViewController.h
//  Demo
//
//  Created by 李展 on 2016/12/2.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemindMatter.h"
@interface DetailRemindViewController : UIViewController
- (instancetype)initWithRemindMatters:(NSArray *)reminds;
- (void)edit:(UIButton *)sender;
- (void)reloadWithRemindMatters:(NSArray *)reminds;
@end
