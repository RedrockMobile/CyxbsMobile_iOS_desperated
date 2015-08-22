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
//023-62750767 023-62751732 15025308654
@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *item = @[@"我的课程",@"发现",@"查询",@"知重邮",@"设置"];
    int whichVc = 0;
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"main_login.png"] style:UIBarButtonItemStyleDone target:self action:@selector(userInfo)];
    
    
    for (UINavigationController *vc in self.viewControllers) {
        vc.title = item[whichVc];
        
        [vc.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon_menu_3.png"]];
        if ([vc respondsToSelector:@selector(viewControllers)]) {
            [[vc viewControllers][0] navigationItem].title = item[whichVc];
            [vc.tabBarItem setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_menu_%d.png",whichVc+1]]];
            [[vc viewControllers][0] navigationItem].leftBarButtonItem = bar;
            [[vc viewControllers][0] navigationItem].rightBarButtonItem = bar;
            vc.navigationBar.tintColor = [UIColor grayColor];
        }else{
            [vc.tabBarItem setImage:[UIImage imageNamed:@"icon_menu_3.png"]];
        }
        
        
        
        vc.tabBarItem.image = [vc.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
   // NSLog(@"s%@",items[2]);
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UITabBarItem *itemSelected = tabBarController.tabBar.selectedItem;
    
    if ([itemSelected isEqual:tabBarController.tabBar.items[2]]) {
        static Boolean isClick = NO;
        NSString *imgName = isClick?@"icon_menu_3.png":@"icon_menu_3_press.png";
        [itemSelected setImage:[UIImage imageNamed:imgName]];
        itemSelected.image = [itemSelected.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self findTbabarAnimation];
        isClick = !isClick;
        return  NO;
    }
    
    return  YES;
}


- (void)findTbabarAnimation{
    int num = 5;
    NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, 30, 30);
    CGRect finalFrame = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40, 30, 30);
    NSLog(@"sd");
    for (int i=0; i<num; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        [btnArray addObject:button];
        button.backgroundColor = [UIColor redColor];
        [self.view addSubview:button];
    }
    
    [UIView beginAnimations:@"doflip" context:nil];
    //设置时常
    [UIView setAnimationDuration:1];
    //设置动画淡入淡出
    //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置翻转方向
    
    for (int i=0; i<num; i++) {
        CGRect tmpFrame = CGRectMake([UIScreen mainScreen].bounds.size.width+(i - num/2.0)*120, [UIScreen mainScreen].bounds.size.height - 80, 100, 30);
        UIButton *tmpBtn = btnArray[i] ;
        tmpBtn.frame = tmpFrame;
    }
    
    [UIView commitAnimations];

    
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
