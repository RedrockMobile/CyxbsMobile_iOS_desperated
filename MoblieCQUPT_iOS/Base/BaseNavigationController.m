//
//  BaseNavigationController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/13.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIFont+AdaptiveFont.h"
@interface BaseNavigationController ()<UINavigationBarDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"all_image_background"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navbar_image_back"]];
    [self.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"navbar_image_back"]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont adaptFontSize:17]}];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
