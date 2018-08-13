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
#import "SYCMainPageModel.h"

@interface SYCMainPageViewController ()

@property (nonatomic, strong) UIButton *rxbbBtn; //入学必备
@property (nonatomic, strong) UIButton *jxtjBtn; //军训特辑
@property (nonatomic, strong) UIButton *xyglBtn; //校园攻略
@property (nonatomic, strong) UIButton *xsjlBtn; //线上交流
@property (nonatomic, strong) UIButton *cyfcBtn; //重邮风采
@property (nonatomic, strong) UIButton *bdlcBtn; //报道流程
@property (nonatomic, strong) UIButton *wxdnsBtn; //我想对你说\

@property (nonatomic, strong) SYCMainPageModel *mainPageModel;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SYCMainPageViewController

@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat mainPageWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat mainPageHeight = mainPageWidth * 2.933;
    
    self.mainPageModel = [SYCMainPageModel shareInstance];
    
    
    self.rxbbBtn = [[UIButton alloc] initWithFrame: CGRectMake(mainPageWidth * 0.173, mainPageHeight * 0.193, mainPageWidth * 0.442, mainPageHeight * 0.073)];
    [self.rxbbBtn setBackgroundImage:[UIImage imageNamed:@"入学必备"] forState:UIControlStateNormal];
    [self.rxbbBtn addTarget:self action:@selector(clickRxbbBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.rxbbBtn];
    
    self.jxtjBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.725, mainPageHeight * 0.260, mainPageWidth * 0.272, mainPageHeight * 0.105)];
    [self.jxtjBtn setBackgroundImage:[UIImage imageNamed:@"军训特辑"] forState:UIControlStateNormal];
    [self.jxtjBtn addTarget:self action:@selector(clickJxtjBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.jxtjBtn];
    
    
    self.xyglBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.350, mainPageHeight * 0.290, mainPageWidth * 0.354, mainPageHeight * 0.139)];
    if (self.mainPageModel.currentStep < 2) {
        [self.xyglBtn setBackgroundImage:[UIImage imageNamed:@"校园攻略锁"] forState:UIControlStateNormal];
    }else{
        [self.xyglBtn setBackgroundImage:[UIImage imageNamed:@"校园攻略"] forState:UIControlStateNormal];
        [self.xyglBtn addTarget:self action:@selector(clickXyglBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [scrollView addSubview:self.xyglBtn];
    
    
    self.xsjlBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.125, mainPageHeight * 0.475, mainPageWidth * 0.472, mainPageHeight * 0.097)];
    if (self.mainPageModel.currentStep < 3) {
        [self.xsjlBtn setBackgroundImage:[UIImage imageNamed:@"线上交流锁"] forState:UIControlStateNormal];
    }else{
        [self.xsjlBtn setBackgroundImage:[UIImage imageNamed:@"线上交流"] forState:UIControlStateNormal];
        [self.xsjlBtn addTarget:self action:@selector(clickXsjlBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [scrollView addSubview:self.xsjlBtn];
    
    
    self.cyfcBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.01, mainPageHeight * 0.582, mainPageWidth * 0.440, mainPageHeight * 0.155)];
    [self.cyfcBtn setBackgroundImage:[UIImage imageNamed:@"重邮风采"] forState:UIControlStateNormal];
    [self.cyfcBtn addTarget:self action:@selector(clickCyfcBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.cyfcBtn];
    
    self.bdlcBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.625, mainPageHeight * 0.655, mainPageWidth * 0.372, mainPageHeight * 0.107)];
    if (self.mainPageModel.currentStep < 4) {
        [self.bdlcBtn setBackgroundImage:[UIImage imageNamed:@"报道流程锁"] forState:UIControlStateNormal];
    }else{
        [self.bdlcBtn setBackgroundImage:[UIImage imageNamed:@"报道流程"] forState:UIControlStateNormal];
        [self.bdlcBtn addTarget:self action:@selector(clickBdlcBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [scrollView addSubview:self.bdlcBtn];
    
    
    self.wxdnsBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.05, mainPageHeight * 0.800, mainPageWidth * 0.380, mainPageHeight * 0.143)];
    if (self.mainPageModel.currentStep < 5) {
        [self.wxdnsBtn setBackgroundImage:[UIImage imageNamed:@"我想对你说锁"] forState:UIControlStateNormal];
    }else{
        [self.wxdnsBtn setBackgroundImage:[UIImage imageNamed:@"我想对你说"] forState:UIControlStateNormal];
        [self.wxdnsBtn addTarget:self action:@selector(clickWxdnsBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [scrollView addSubview: self.wxdnsBtn];
    
}

- (void)clickRxbbBtn:(id)sender{
    SYCCollageTableViewController *collageVC = [[SYCCollageTableViewController alloc] init];

    [self.navigationController pushViewController:collageVC animated:YES];
    collageVC.callBackHandle = ^{
        if (self.mainPageModel.currentStep < 2) {
            [self.mainPageModel setCurrentStep:2];
            [self viewDidLoad];
        }
    };
}

- (void)clickJxtjBtn:(id)sender{
    SYCCollageTableViewController *collageVC = [[SYCCollageTableViewController alloc] init];
    collageVC.callBackHandle = ^{
    };
    [self.navigationController pushViewController:collageVC animated:YES];
}

- (void)clickXyglBtn:(id)sender{
    SYCCollageTableViewController *collageVC = [[SYCCollageTableViewController alloc] init];
    
    [self.navigationController pushViewController:collageVC animated:YES];
    collageVC.callBackHandle = ^{
        if (self.mainPageModel.currentStep < 3) {
            [self.mainPageModel setCurrentStep:3];
            [self viewDidLoad];
        }
    };
}

- (void)clickXsjlBtn:(id)sender{
    SYCCollageTableViewController *collageVC = [[SYCCollageTableViewController alloc] init];
    
    [self.navigationController pushViewController:collageVC animated:YES];
    collageVC.callBackHandle = ^{
        if (self.mainPageModel.currentStep < 4) {
            [self.mainPageModel setCurrentStep:4];
            [self viewDidLoad];
        }
    };
}

- (void)clickCyfcBtn:(id)sender{
    SYCCollageTableViewController *collageVC = [[SYCCollageTableViewController alloc] init];
    collageVC.callBackHandle = ^{
    };
    [self.navigationController pushViewController:collageVC animated:YES];
}

- (void)clickBdlcBtn:(id)sender{
    SYCCollageTableViewController *collageVC = [[SYCCollageTableViewController alloc] init];
    
    [self.navigationController pushViewController:collageVC animated:YES];
    collageVC.callBackHandle = ^{
        if (self.mainPageModel.currentStep < 5) {
            [self.mainPageModel setCurrentStep:5];
            [self viewDidLoad];
        }
    };
}

- (void)clickWxdnsBtn:(id)sender{
    SYCCollageTableViewController *collageVC = [[SYCCollageTableViewController alloc] init];
    collageVC.callBackHandle = ^{
    };
    [self.navigationController pushViewController:collageVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:scrollView];
        
        const CGFloat imageRatio = 2.933;
        CGFloat mainPageWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat mainPageHeight = mainPageWidth * imageRatio;
        
        SYCMainPageView *mainPageView = [[SYCMainPageView alloc] initWithFrame:CGRectMake(0, 0, mainPageWidth, mainPageHeight)];
        [scrollView addSubview:mainPageView];
        scrollView.contentSize = mainPageView.bounds.size;
        [self viewDidLoad];
    }
    return self;
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
