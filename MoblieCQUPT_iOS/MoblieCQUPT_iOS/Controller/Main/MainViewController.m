//
//  MainViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/20.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UITabBarControllerDelegate,UITabBarDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *item = @[@"我的课程",@"发现",@"查询",@"知重邮",@"设置"];
    int whichVc = 0;
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_menu_1.png"] style:UIBarButtonItemStyleDone target:self action:@selector(userInfo)];
    for (UINavigationController *vc in self.viewControllers) {
        vc.title = item[whichVc];
        //[vc.tabBarItem setImage:[UIImage imageNamed:@"icon_menu_1.png"]];
        
        if ([vc respondsToSelector:@selector(viewControllers)]) {
            [[vc viewControllers][0] navigationItem].title = item[whichVc];
            
            [[vc viewControllers][0] navigationItem].leftBarButtonItem = bar;
            [[vc viewControllers][0] navigationItem].rightBarButtonItem = bar;
        }
        whichVc++;
    }
    
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userInfo{
    static BOOL isPush = NO;
    int movX = !isPush?100:0;
    [UIView animateWithDuration:0.8 animations:^{
        self.view.frame = CGRectMake(movX, 0, self.view.frame.size.width, self.view.frame.size.height);
        isPush = !isPush;
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    //NSLog(@"%@",[[[self viewControllers][0] viewControllers][0] navigationItem]);
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    //NSLog(@"%@",item.title);
}

- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray *)items{
    NSLog(@"s%@",items[2]);
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UITabBarItem *itemSelected = tabBarController.tabBar.selectedItem;
    if ([itemSelected isEqual:tabBarController.tabBar.items[2]]) {
        NSLog(@"%@",itemSelected);
//        UITabBarItem *bar = [[UITabBarItem alloc] initWithTitle:@"ss" image:[UIImage imageNamed:@"icon_menu_1.png"] selectedImage:[UIImage imageNamed:@"icon_menu_1.png"]];
        
        return  NO;
    }
    
    return  YES;
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
