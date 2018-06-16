//
//  SheetViewController.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetAlertController : UIAlertController
+ (instancetype)draftsAlert;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *target_ID;
@end
