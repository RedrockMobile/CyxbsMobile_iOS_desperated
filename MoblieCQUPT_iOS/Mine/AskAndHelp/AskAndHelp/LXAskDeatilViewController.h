//
//  LXAskDeatilViewController.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/5/30.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXAskDeatilViewController : BaseViewController

@property BOOL isAsk;
@property (copy, nonatomic) NSString *solvedProblem;
@property (copy, nonatomic) NSString *adoptedAnswers;
@property (strong, nonatomic) UINavigationController *parentVC;

@end
