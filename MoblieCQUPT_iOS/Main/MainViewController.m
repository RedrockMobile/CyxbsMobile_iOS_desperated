//
//  MainViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/20.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavigationController.h"
@interface MainViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *bootPageScrollView;
@property (nonatomic, strong) UIPageControl *bootPageController;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titles = @[@"课表",@"社区",@"迎新",@"发现",@"我的"];
    NSArray *images = @[@"tabbar_image_timetable",@"tabbar_image_community",@"freshman_button",@"tabbar_image_find",@"tabbar_image_mine"];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor colorWithHexString:@"788EFA"];
    
    
    for (int i = 0; i<self.viewControllers.count; i++) {
        BaseNavigationController *nvc = self.viewControllers[i];
        nvc.topViewController.title = titles[i];
        UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
        backItem.title=@"";
        nvc.topViewController.navigationItem.backBarButtonItem = backItem;
        nvc.tabBarItem.image = [UIImage imageNamed:images[i]];
        
        if (i == 2) {
            nvc.tabBarItem.selectedImage = [[UIImage imageNamed:@"freshman_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nvc.tabBarItem.image = [[UIImage imageNamed:@"freshman_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nvc.tabBarItem.imageInsets = UIEdgeInsetsMake(-10, 0, 10, 0);
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchSplash:) name:@"touchSplash" object:nil];
    
    //先隐藏自己，显示引导页
    if ([self isUpdateVersion]) {
        self.view.hidden = YES;
    } else {
        ;
    }
}

-(void)viewDidAppear:(BOOL)animated {
    if ([self isUpdateVersion]) {
        [self showBootPage];
    } else {
        ;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchSplash:(NSNotification *)notification{
    NSString *target_url = notification.object;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:target_url]]];
    BaseViewController *vc = [[BaseViewController alloc]init];
    [vc.view addSubview:webView];
    vc.hidesBottomBarWhenPushed = YES;
    BaseNavigationController *nvc = [self.viewControllers firstObject];
    [nvc pushViewController:vc animated:YES];
}

#pragma mark - 引导图

- (BOOL)isUpdateVersion {
    NSDictionary *bundleDic = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [bundleDic objectForKey:@"CFBundleVersion"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![[userDefaults objectForKey:@"version"] isEqualToString:version]) {
        return YES;
    }
    else {
        return NO;
    }
}

-(void)showBootPage {
    NSDictionary *bundleDic = [[NSBundle mainBundle] infoDictionary];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *version = [bundleDic objectForKey:@"CFBundleVersion"];
    [userDefaults setObject:version forKey:@"version"];
    
    //创建引导页
    self.bootPageScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    int bootPageNum = 4;
    self.bootPageScrollView.contentSize = CGSizeMake(SCREENWIDTH*bootPageNum, SCREENHEIGHT);
    self.bootPageScrollView.directionalLockEnabled = YES;
    self.bootPageScrollView.bounces = NO;
    self.bootPageScrollView.pagingEnabled = YES;
    self.bootPageScrollView.showsHorizontalScrollIndicator = NO;
    self.bootPageScrollView.showsVerticalScrollIndicator = NO;
    self.bootPageScrollView.userInteractionEnabled = YES;
    self.bootPageScrollView.delegate = self;
    for (int i = 0; i < bootPageNum; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg_splash_guide_%d", i+1]];
        [self.bootPageScrollView addSubview:imageView];
        if (i != 3) {
            //跳过按钮
            UIButton *skipBtn = [[UIButton alloc] init];
            [imageView addSubview:skipBtn];
            [skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(imageView.mas_right).offset(-25);
                make.top.equalTo(imageView.mas_top).offset(24);
                make.width.mas_equalTo(@(58/375.0*SCREENWIDTH));
                make.height.mas_equalTo(@(28/667.0*ScreenHeight));
            }];
            [skipBtn setBackgroundImage:[UIImage imageNamed:@"skip_btn"] forState:UIControlStateNormal];
            [skipBtn addTarget:self action:@selector(entryMainView) forControlEvents:UIControlEventTouchUpInside];
        } else {
            //开始体验按钮
            UIButton *confirmBtn = [[UIButton alloc] init];
            [imageView addSubview:confirmBtn];
            [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(imageView.mas_centerX);
                make.bottom.equalTo(imageView.mas_bottom).offset(-76);
                make.width.mas_equalTo(@(193/375.0*SCREENWIDTH));
                make.height.mas_equalTo(@(48/667.0*ScreenHeight));
            }];
            [confirmBtn setBackgroundImage:[UIImage imageNamed:@"confirm_btn"] forState:UIControlStateNormal];
            [confirmBtn addTarget:self action:@selector(entryMainView) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.bootPageScrollView];
    
    // pageControl
    self.bootPageController = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH / 2, 30)];
    self.bootPageController.center = CGPointMake(SCREENWIDTH / 2, SCREENHEIGHT - 48/667.0*ScreenHeight * 2 + (self.bootPageController.height /2.0) - 76);
    [window addSubview:self.bootPageController];
    self.bootPageController.numberOfPages = bootPageNum;
    self.bootPageController.pageIndicatorTintColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    self.bootPageController.currentPageIndicatorTintColor = [UIColor colorWithRed:110/255.0 green:140/255.0 blue:240/255.0 alpha:1];

}

- (void)entryMainView {
    [self.bootPageScrollView removeFromSuperview];
    self.view.hidden = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int currentPage = (scrollView.contentOffset.x + SCREENWIDTH/2.0) / SCREENWIDTH;
    self.bootPageController.currentPage = currentPage;
}

@end
