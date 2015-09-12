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

@end
@implementation XBSNavigationBar
- (instancetype)initWithTitle:(NSString *)title Delegate:(UIViewController *)delegate {
    self.parentDelegate = delegate;
    self = [super initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    if (self) {
        //反面教材
        //[self setBackgroundColor:[UIColor greenColor]];
        
        //backgroundColor
        [self setTintColor:[UIColor whiteColor]];
        [self setBackgroundImage:[We getImageColored:MAIN_COLOR Size:CGSizeMake(ScreenWidth,64)] forBarMetrics:UIBarMetricsDefault];
        UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:nil];
        
        //leftButton
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(prevPage)];
        navigationItem.leftBarButtonItem = leftButton;
        
        //title
        NSLog(@"%f",leftButton.width);
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 44)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = title;
        navigationItem.titleView = self.titleLabel;
        
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