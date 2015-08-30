//
//  CourseViewController.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/8/21.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseView.h"

@interface CourseViewController : TitleBaseViewController <UPStackMenuDelegate>

@property (strong, nonatomic)UIView *mainView;
@property (strong, nonatomic)UIScrollView *mainScrollView;
@property (strong, nonatomic)NSArray *colors;

@property (strong, nonatomic)NSArray *dataArray;
@property (strong, nonatomic)CourseView *courseView;
@end
