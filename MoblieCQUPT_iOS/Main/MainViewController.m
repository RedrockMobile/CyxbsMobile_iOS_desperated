//
//  MainViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/20.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//


#import "MainViewController.h"
#import "MainViewController.h"

@interface MainViewController () <UITabBarControllerDelegate,UITabBarDelegate>
@property (strong, nonatomic) NSMutableArray *btnArray;
@property (strong, nonatomic) NSMutableArray *btnTextArray;
@property (assign, nonatomic) NSInteger btnNum;
@property (strong, nonatomic) UITabBarItem *centerBar;
@property (strong, nonatomic) NSDictionary *buttonConfig;
@property (strong, nonatomic) UIView *discoverView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *item = @[@"课表",@"社区",@"发现",@"我的"];
    self.tabBar.tintColor = MAIN_COLOR;
    for (int i = 0; i<self.viewControllers.count; i++) {
        UINavigationController *nvc = self.viewControllers[i];
        nvc.title = item[i];
        [nvc.tabBarItem setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_menu_%d.png",i+1]]];
        [nvc.tabBarItem setSelectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_menu_selected_%d.png",i+1]]];
        nvc.navigationBar.tintColor = FONT_COLOR;

        
    }
    self.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}





- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
//    if ([item isEqual:self.tabBar.items[0]]) {
//        self.navigationController.navigationBarHidden = YES;
//    }else{
//        self.navigationController.navigationBarHidden = NO;
//    }
    
//    NSArray *names = @[@"课表",@"社区",@"发现",@"我的"];
//    for (int i=0; i<=3; i++) {
//        if ([item isEqual:self.tabBar.items[i]]){
//            self.navigationItem.title = names[i];
//        }
//    }
}




@end
