//
//  XBSConsultNavigationBar.m
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/10/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "XBSNavigationBar.h"
#import "MainViewController.h"
#import "We.h"
@interface XBSNavigationBar ()
@property (nonatomic, strong) UIViewController *parentDelegate;
@end
@implementation XBSNavigationBar
- (instancetype)initWithTitle:(NSString *)title Delegate:(UIViewController *)delegate {
    self.parentDelegate = delegate;
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    if (self) {
        //反面教材
        //[self setBackgroundColor:[UIColor greenColor]];
        self.translucent = YES;

        
        //backgroundColor
        [self setTintColor:[UIColor whiteColor]];
        [self setBackgroundImage:[We getImageColored:MAIN_COLOR Size:CGSizeMake(ScreenWidth,64)] forBarMetrics:UIBarMetricsDefault];
        UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:nil];
        
        //leftButton
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(prevPage)];
        navigationItem.leftBarButtonItem = leftButton;
        
        //title
        NSLog(@"%f",leftButton.width);
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 44)];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        navigationItem.titleView = titleLabel;
        
        [self pushNavigationItem:navigationItem animated:NO];
        
    }
    return self;
}

- (void)prevPage {
    //似乎是错误的打开方式
    //self.parentDelegate.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.parentDelegate dismissViewControllerAnimated:YES completion:nil];
}

@end