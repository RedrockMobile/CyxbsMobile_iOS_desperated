//
//  LoginViewController.h
//  MobileLogin
//
//  Created by GQuEen on 15/8/13.
//  Copyright (c) 2015年 GegeChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginSuccessHandler)(BOOL success);

@interface LoginViewController : UIViewController

@property (copy, nonatomic) LoginSuccessHandler loginSuccessHandler;

@end
