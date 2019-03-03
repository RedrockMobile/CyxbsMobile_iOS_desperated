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
#import "MBCommunity_ViewModel.h"
@interface MBCommunityHandle : NSObject
//+ (ClickSupportBtnBlock)clickSupportBtn:(UIViewController *)viewController;
+ (NSString *)clickUpvoteBtn:(UIViewController *)viewController currentUpvoteNum:(NSInteger)currentUpvoteNum upvoteIsSelect:(BOOL)upvoteIsSelect viewModel:(MBCommunity_ViewModel *)viewModel;
+ (void) noLogin:(UIViewController *)viewController handler:(LoginSuccessHandler)handler;
@end
