//
//  UIShortTapGestureRecognizer.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/24.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIGestureRecognizerSubclass.h>

@interface UIShortTapGestureRecognizer : UITapGestureRecognizer

@property (assign, nonatomic) CGFloat maxDelay;

@end
