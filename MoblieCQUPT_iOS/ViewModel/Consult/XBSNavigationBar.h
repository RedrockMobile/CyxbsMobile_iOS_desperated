//
//  XBSConsultNavigationBar.h
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/10/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBSNavigationBar : UINavigationBar
@property (nonatomic, strong) UIViewController *parentDelegate;
@property (nonatomic, strong) UILabel *titleLabel;
- (instancetype)initWithTitle:(NSString *)title Delegate:(UIViewController *)delegate;
 
@end
