//
//  SchoolHomePageViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//
typedef void(^callBack)(void);
#import <UIKit/UIKit.h>

@interface SchoolHomePageViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *SchoolRootView;

@property (nonatomic, strong)callBack callBackHandle;
@end
