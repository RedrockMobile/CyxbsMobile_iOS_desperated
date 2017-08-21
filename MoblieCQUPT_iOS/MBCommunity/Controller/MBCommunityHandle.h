//
//  MBCommunityHandle.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/14.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBCommunity_ViewModel.h"
#import "LoginViewController.h"
#import "MBCommunityCellTableViewCell.h"
@interface MBCommunityHandle : NSObject
+ (ClickSupportBtnBlock)clickSupportBtn:(UIViewController *)viewController;
+ (void) noLogin:(UIViewController *)viewController handler:(LoginSuccessHandler)handler;
@end
