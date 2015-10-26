//
//  MainViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/20.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//


#import "MainViewController.h"
#import "XBSConsultDataBundle.h"
#import "XBSSchduleViewController.h"
#import "MainViewController.h"
#import "XBSConsultButtonClicker.h"
#import "XBSConsultConfig.h"

@interface MainViewController () <UITabBarControllerDelegate,UITabBarDelegate>
@property (strong, nonatomic) NSMutableArray *btnArray;
@property (strong, nonatomic) NSMutableArray *btnTextArray;
@property (assign, nonatomic) NSInteger btnNum;
@property (strong, nonatomic) UITabBarItem *centerBar;
@property (strong, nonatomic) NSDictionary *buttonConfig;
@property (nonatomic, strong) XBSConsultButtonClicker *clicker;
@property (strong, nonatomic) UIView *discoverView;
@end

@implementation MainViewController
static Boolean isClick = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self findButtonInit];
    NSArray *item = @[@"课程",@"教务信息",@"查询",@"发现",@"我的"];
    
//    self.navigationController.title=@"22";
    
    int whichVc = 0;
    self.tabBar.tintColor = MAIN_COLOR;
    
    for (UINavigationController *vc in self.viewControllers) {
        vc.title = item[whichVc];
        
        [vc.tabBarItem setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_menu_%d.png",whichVc+1]]];
//        vc.navigationController.navigationBar.hidden = NO;
        vc.navigationController.navigationBar.tintColor = kItemTintColor;
        vc.navigationController.navigationBar.barTintColor = kBarTintColor;
//        vc.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
//        vc.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//        vc.navigationController.navigationBar.layer.shadowOpacity = 0.1f;
//        vc.navigationController.navigationBar.layer.shadowRadius = 0.5f;
        vc.navigationController.navigationItem.title = item[whichVc];
        self.navigationItem.title = [item firstObject];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
        if([vc respondsToSelector:@selector(setCommonNavigationItem:)]){
            [vc performSelector:@selector(setCommonNavigationItem:) withObject:self.navigationItem];
        }
#pragma clang diagnostic pop
        
        whichVc==1?whichVc+=2:whichVc++;
    }


    self.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if ([item isEqual:self.tabBar.items[0]] || [item isEqual:self.tabBar.items[2]]) {
        self.navigationController.navigationBarHidden = YES;
    }else{
        self.navigationController.navigationBarHidden = NO;
    }
    
    NSArray *names = @[@"课程",@"教务信息",@"发现",@"我的"];
    for (int i=0; i<=3; i++) {
        if ([item isEqual:self.tabBar.items[i]]){
            self.navigationItem.title = names[i];
        }
    }
}



- (void)findButtonInit{
    _discoverView = [[UIView alloc] initWithFrame:CGRectZero];
    _discoverView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _discoverView.alpha = 0.9;
    
    [self.view addSubview:_discoverView];
    
    self.btnArray = [[NSMutableArray alloc] init];
    self.btnTextArray = [[NSMutableArray alloc] init];
    self.buttonConfig = [[NSMutableDictionary alloc] init];
    self.buttonConfig = @{
                        @"btnOriginY":@(-MAIN_SCREEN_W*0.3),
                        @"distance":@(MAIN_SCREEN_W*0.3),
                        @"baseSize":@10,
                        @"finalSize":@(MAIN_SCREEN_W*0.2),
                          };
    
    self.btnNum = 4;
    
    
    
    NSArray *tempStrArr = @[@"20-3b.png",@"20-3补考.png",@"20-3exam.png",@"20-3c.png"];
    //NSArray *textArray = @[@"考试查询",@"补考查询",@"成绩查询",@"找空教室"];
    SEL s[4] = {@selector(clickForExamSchedule),@selector(clickForReexamSchedule),
        @selector(clickForExamGrade),@selector(clickForEmptyClassroom)};
    self.clicker = [[XBSConsultButtonClicker alloc]init];
    self.clicker.delegate = self;
    for (int i=0; i<self.btnNum; i++) {
        ///** label **/
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        //label.text = textArray[i];
        [self.btnTextArray addObject:label];
        [self.view addSubview:label];
        /** button **/
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.btnArray addObject:button];
        if(i < self.btnNum){
            [button setImage:[UIImage imageNamed:tempStrArr[i]] forState:UIControlStateNormal];
        }
        [button addTarget:self.clicker action:s[i] forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)findTbabarAnimation{
    isClick = YES;
    CGFloat barHeight = 64;
    CGFloat tabBarHeight = self.tabBar.frame.size.height;
//    NSLog(@"%f",barHeight);
    _discoverView.frame = CGRectMake(0, barHeight, MAIN_SCREEN_W, MAIN_SCREEN_H-tabBarHeight-barHeight);
    
    [self.centerBar setImage:[UIImage imageNamed:@"icon_menu_3_press.png"]];
    self.centerBar.image = [self.centerBar.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSInteger num = self.btnNum;
    int btnHeight = [self.buttonConfig[@"btnOriginY"] intValue];
    int distance = [self.buttonConfig[@"distance"] intValue];
    int baseSize = [self.buttonConfig[@"baseSize"] intValue];
    int finalSize = [self.buttonConfig[@"finalSize"] intValue];
    CGRect frame = CGRectMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H-btnHeight, baseSize, baseSize);
    
    /*飞按钮*/
    for (int i=0; i<num; i++) {
        UIButton *button = self.btnArray[i];
        button.center = CGPointMake(MAIN_SCREEN_W/2, frame.origin.y);
        button.layer.cornerRadius = finalSize/2;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 3, 29, 244, 1 });
        [button.layer setBorderColor:colorref];
        
        UILabel *label = _btnTextArray[i];
        label.frame = CGRectZero;
    }
    
    [UIView beginAnimations:@"btn" context:nil];
    //设置时常
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationDelegate:self];
    
    
    double indexH  = MAIN_SCREEN_H-btnHeight;
    for (int i=0; i<num; i++) {
        double tmpD =  indexH - 2*distance;
        CGPoint point = CGPointMake(MAIN_SCREEN_W/2+(i%3-1)*distance, tmpD);
        if ((i+1)%3==0) {
            indexH -= distance;
        }
        [self.btnArray[i] setSize:CGSizeMake(finalSize, finalSize)];
        [self.btnArray[i] setCenter:point];
        [self.btnTextArray[i] setSize:CGSizeMake(finalSize, finalSize)];
        [self.btnTextArray[i] setCenter:CGPointMake(point.x, point.y+finalSize/2)];
    }
    
    [UIView commitAnimations];
}


- (void)disFindTbabarAnimation{
    isClick = NO;
    _discoverView.frame = CGRectZero;
//    [self.view sendSubviewToBack:_discoverView];
    
    [self.centerBar setImage:[UIImage imageNamed:@"icon_menu_3.png"]];
    self.centerBar.image = [self.centerBar.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSInteger num = self.btnNum;
    int finalSize = [self.buttonConfig[@"finalSize"] intValue];;
    [UIView animateWithDuration:0.2 animations:^{
        for (int i=0; i<num; i++) {
            UIButton *button = self.btnArray[i];
            button.layer.cornerRadius = finalSize/2;
//            button.backgroundColor = MAIN_COLOR;
            button.frame =  CGRectMake(MAIN_SCREEN_W/2, button.frame.origin.y, button.frame.size.width, button.frame.size.width);
            button.center = CGPointMake(MAIN_SCREEN_W/2, button.frame.origin.y);
            
            UILabel *label =  _btnTextArray[i];
            label.center = CGPointMake(MAIN_SCREEN_W/2, button.frame.origin.y+button.frame.size.height/2);
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            for (int i=0; i<num; i++) {
                UIButton *button = self.btnArray[i];
                button.frame =  CGRectMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H+10, 0,0);
                button.center = CGPointMake(MAIN_SCREEN_W/2, button.frame.origin.y);
                
                UILabel *label =  _btnTextArray[i];
                label.frame = button.frame =  CGRectMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H+10, 0,0);
                label.center = CGPointMake(MAIN_SCREEN_W/2, button.frame.origin.y);
            }
        }];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self disFindTbabarAnimation];
}

@end
