//
//  SchoolCarRemindViewController.h
//  SchoolCarDemo
//
//  Created by 周杰 on 2018/3/10.
//  Copyright © 2018年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^markBlcok1)(int mark);
@interface SchoolCarRemindViewController : UIViewController
@property (nonatomic, copy)markBlcok1 backBlock;
@end
