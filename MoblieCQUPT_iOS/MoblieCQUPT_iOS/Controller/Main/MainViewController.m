//
//  MainViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/20.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UITabBarControllerDelegate,UITabBarDelegate>
@property (strong, nonatomic) NSMutableArray *btnArray;
@property (assign, nonatomic) NSInteger btnNum;
@property (strong, nonatomic) UITabBarItem *centerBar;
@end
//023-62750767 023-62751732 15025308654
@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self findButtonInit];
    NSArray *item = @[@"我的课程",@"发现",@"查询",@"知重邮",@"设置"];
    int whichVc = 0;
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"main_login.png"] style:UIBarButtonItemStyleDone target:self action:@selector(userInfo)];
    
    
    for (UINavigationController *vc in self.viewControllers) {
        vc.title = item[whichVc];
        
        //[vc.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon_menu_3.png"]];
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



- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UITabBarItem *itemSelected = tabBarController.tabBar.selectedItem;
    
    if ([itemSelected isEqual:tabBarController.tabBar.items[2]]) {
        static Boolean isClick = NO;
        self.centerBar = itemSelected;
        if (!isClick) {
            [self findTbabarAnimation];
        }else{
            [self disFindTbabarAnimation];
        }
        isClick = !isClick;
        return  NO;
    }
    
    return  YES;
}


- (void)findButtonInit{
    self.btnArray = [[NSMutableArray alloc] init];
    self.btnNum = 6;
    for (int i=0; i<self.btnNum; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.btnArray addObject:button];
        [self.view addSubview:button];
    }
}

- (void)findTbabarAnimation{
    [self.centerBar setImage:[UIImage imageNamed:@"icon_menu_3_press.png"]];
    self.centerBar.image = [self.centerBar.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSInteger num = self.btnNum;
    int btnHeight = -80;
    int distance = 100;
    int baseSize = 10;
    int finalSize = 60;
    CGRect frame = CGRectMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H-btnHeight, baseSize, baseSize);

 
    for (int i=0; i<num; i++) {
        UIButton *button = self.btnArray[i];
        button.center = CGPointMake(MAIN_SCREEN_W/2, frame.origin.y);
        button.layer.cornerRadius = finalSize/2;
        button.backgroundColor = MAIN_COLOR;
    }
    
    [UIView beginAnimations:@"btn" context:nil];
    //设置时常
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationDelegate:self];
    //设置翻转方向
    
    double indexH  = MAIN_SCREEN_H-btnHeight;
    for (int i=0; i<num; i++) {
        double tmpD =  indexH - 2*distance;
        CGPoint point = CGPointMake(MAIN_SCREEN_W/2+(i%3-1)*distance, tmpD);
        if ((i+1)%3==0) {
            indexH -= distance;
        }
        [self.btnArray[i] setSize:CGSizeMake(finalSize, finalSize)];
        [self.btnArray[i] setCenter:point];
    }
    
    [UIView commitAnimations];
}


- (void)disFindTbabarAnimation{
    [self.centerBar setImage:[UIImage imageNamed:@"icon_menu_3.png"]];
    self.centerBar.image = [self.centerBar.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSInteger num = self.btnNum;
    int finalSize = 60;
    [UIView animateWithDuration:0.2 animations:^{
        for (int i=0; i<num; i++) {
            UIButton *button = self.btnArray[i];
            button.layer.cornerRadius = finalSize/2;
            button.backgroundColor = MAIN_COLOR;
            button.frame =  CGRectMake(MAIN_SCREEN_W/2, button.frame.origin.y, button.frame.size.width, button.frame.size.width);
            button.center = CGPointMake(MAIN_SCREEN_W/2, button.frame.origin.y);
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            for (int i=0; i<num; i++) {
                UIButton *button = self.btnArray[i];
                button.frame =  CGRectMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H+10, 0,0);
                button.center = CGPointMake(MAIN_SCREEN_W/2, button.frame.origin.y);
            }
        }];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self disFindTbabarAnimation];
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
