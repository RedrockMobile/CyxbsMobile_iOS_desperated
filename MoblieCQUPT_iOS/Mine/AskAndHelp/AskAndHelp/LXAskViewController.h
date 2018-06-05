//
//  LXAskViewController.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/5/30.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXAskViewControllerDelegate <NSObject>

- (void) enterYouWen;

@end

@interface LXAskViewController : BaseViewController

@property (nonatomic, weak) id <LXAskViewControllerDelegate> delegate;
@property BOOL isAsk;

@end
