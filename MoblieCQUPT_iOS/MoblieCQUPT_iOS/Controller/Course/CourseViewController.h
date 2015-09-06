//
//  CourseViewController.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/8/21.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseView.h"
#import "UPStackMenu.h"
#import "TitleBaseViewController.h"


@interface CourseViewController : TitleBaseViewController

@property (strong, nonatomic)UIView *mainView;
@property (strong, nonatomic)UIScrollView *mainScrollView;
@property (strong, nonatomic)NSMutableArray *colorArray;
@property (strong, nonatomic)NSMutableSet *registRepeatClassSet;
@property (strong, nonatomic)NSArray *dataArray;
@property (strong, nonatomic)NSArray *weekDataArray;
@property (strong, nonatomic)UIImageView *moreMenu;
@property (strong, nonatomic)NSMutableArray *buttonTag;

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIPageControl *page;
@property (strong, nonatomic) UIView *alertView;

@property (strong, nonatomic)NSMutableDictionary *parameter;
@end
