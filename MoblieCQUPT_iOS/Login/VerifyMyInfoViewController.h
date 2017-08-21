//
//  VerifyMyInfoViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/10.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VerifySuccessHandler)(BOOL success);

@interface VerifyMyInfoViewController : BaseViewController

@property (copy, nonatomic) VerifySuccessHandler verifySuccessHandler;

@end
