//
//  SYCMainPageViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCMainPageViewController.h"
#import "SYCMainPageView.h"
#import "SYCCollageTableViewController.h"

@interface SYCMainPageViewController ()

@property (nonatomic, strong) UIButton *enterRequiredBtn;
@property (nonatomic, strong) UIButton *militaryTrainingBtn;
@property (nonatomic, strong) UIButton *campusGuideBtn;
@property (nonatomic, strong) UIButton *onlineChatBtn;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@end

@implementation SYCMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:scrollView];
    
    const CGFloat imageRatio = 2.933;
    CGFloat mainPageWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat mainPageHeight = mainPageWidth * imageRatio;
    
    SYCMainPageView *mainPageView = [[SYCMainPageView alloc] initWithFrame:CGRectMake(0, 0, mainPageWidth, mainPageHeight)];
    
    self.enterRequiredBtn = [[UIButton alloc] initWithFrame: CGRectMake(mainPageWidth * 0.173, mainPageHeight * 0.193, mainPageWidth * 0.442, mainPageHeight * 0.073)];
    [self.enterRequiredBtn setBackgroundImage:[UIImage imageNamed:@"入学必备"] forState:UIControlStateNormal];
    

    [scrollView addSubview:mainPageView];
    [scrollView addSubview:self.enterRequiredBtn];
    
    scrollView.contentSize = mainPageView.bounds.size;
    
    [self.enterRequiredBtn addTarget:self action:@selector(clickEnterRequiredBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickEnterRequiredBtn:(id)sender{
    NSLog(@"11111111111111");
    SYCCollageTableViewController *collageVC = [[SYCCollageTableViewController alloc] init];
    [self.navigationController pushViewController:collageVC animated:YES];
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
