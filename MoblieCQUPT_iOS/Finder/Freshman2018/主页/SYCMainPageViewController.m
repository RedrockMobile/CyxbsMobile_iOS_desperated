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
#import "SYCCollageDataManager.h"
#import "SYCActivityManager.h"
#import "MBProgressHUD.h"
#import "SYCCharacterViewController.h"
#import "SYCOrganizationManager.h"
#import "DLNecessityViewController.h"
#import "SchoolHomePageViewController.h"
#import "ChatViewControl.h"
#import "WantToSayController.h"
#import "ReportWaterfallController.h"
#import "MilitarytrainingViewController.h"

@interface SYCMainPageViewController ()

@property (nonatomic, strong) UIButton *rxbbBtn; //入学必备
@property (nonatomic, strong) UIButton *jxtjBtn; //军训特辑
@property (nonatomic, strong) UIButton *xyglBtn; //校园攻略
@property (nonatomic, strong) UIButton *xsjlBtn; //线上交流
@property (nonatomic, strong) UIButton *cyfcBtn; //重邮风采
@property (nonatomic, strong) UIButton *bdlcBtn; //报道流程
@property (nonatomic, strong) UIButton *wxdnsBtn; //我想对你说

@property (nonatomic, strong) UIImageView *carView;

@property (nonatomic, strong) SYCMainPageModel *mainPageModel;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *buttonFrames;

@property (nonatomic, strong) SYCActivityManager *activityManager;
@property (nonatomic, strong) SYCCollageDataManager *collageManager;

@end

@implementation SYCMainPageViewController

@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载数据中...";
    hud.detailsLabelText = @"不如先去看看其他的？";
    hud.color = [UIColor colorWithWhite:0.f alpha:0.4f];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [SYCActivityManager sharedInstance];
        [SYCOrganizationManager sharedInstance];
        [SYCCollageDataManager sharedInstance];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
    
    CGFloat mainPageWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat mainPageHeight = mainPageWidth * 2.933;

    
    
    self.rxbbBtn = [[UIButton alloc] initWithFrame: CGRectMake(mainPageWidth * 0.173, mainPageHeight * 0.193, mainPageWidth * 0.442, mainPageHeight * 0.073)];
    [self.rxbbBtn setImage:[UIImage imageNamed:@"入学必备"] forState:UIControlStateNormal];
    [self.rxbbBtn addTarget:self action:@selector(clickRxbbBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.rxbbBtn];
    
    self.jxtjBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.725, mainPageHeight * 0.260, mainPageWidth * 0.272, mainPageHeight * 0.105)];
    [self.jxtjBtn setImage:[UIImage imageNamed:@"军训特辑"] forState:UIControlStateNormal];
    [self.jxtjBtn addTarget:self action:@selector(clickJxtjBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.jxtjBtn];
    
    
    self.xyglBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.350, mainPageHeight * 0.290, mainPageWidth * 0.354, mainPageHeight * 0.139)];
    if (self.mainPageModel.currentStep < 2) {
        [self.xyglBtn setImage:[UIImage imageNamed:@"校园攻略锁"] forState:UIControlStateNormal];
    }else{
        [self.xyglBtn setImage:[UIImage imageNamed:@"校园攻略"] forState:UIControlStateNormal];
        [self.xyglBtn setTarget:self action:@selector(clickXyglBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [scrollView addSubview:self.xyglBtn];
    
    
    self.xsjlBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.125, mainPageHeight * 0.475, mainPageWidth * 0.472, mainPageHeight * 0.097)];
    if (self.mainPageModel.currentStep < 3) {
        [self.xsjlBtn setImage:[UIImage imageNamed:@"线上交流锁"] forState:UIControlStateNormal];
    }else{
        [self.xsjlBtn setImage:[UIImage imageNamed:@"线上交流"] forState:UIControlStateNormal];
        [self.xsjlBtn setTarget:self action:@selector(clickXsjlBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [scrollView addSubview:self.xsjlBtn];
    
    
    self.cyfcBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.01, mainPageHeight * 0.582, mainPageWidth * 0.440, mainPageHeight * 0.155)];
    [self.cyfcBtn setImage:[UIImage imageNamed:@"重邮风采"] forState:UIControlStateNormal];
    [self.cyfcBtn addTarget:self action:@selector(clickCyfcBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.cyfcBtn];
    
    self.bdlcBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.625, mainPageHeight * 0.655, mainPageWidth * 0.372, mainPageHeight * 0.107)];
    if (self.mainPageModel.currentStep < 4) {
        [self.bdlcBtn setImage:[UIImage imageNamed:@"报道流程锁"] forState:UIControlStateNormal];
    }else{
        [self.bdlcBtn setImage:[UIImage imageNamed:@"报道流程"] forState:UIControlStateNormal];
        [self.bdlcBtn setTarget:self action:@selector(clickBdlcBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [scrollView addSubview:self.bdlcBtn];
    
    
    self.wxdnsBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainPageWidth * 0.05, mainPageHeight * 0.800, mainPageWidth * 0.380, mainPageHeight * 0.143)];
    if (self.mainPageModel.currentStep < 5) {
        [self.wxdnsBtn setImage:[UIImage imageNamed:@"我想对你说锁"] forState:UIControlStateNormal];
    }else{
        [self.wxdnsBtn setImage:[UIImage imageNamed:@"我想对你说"] forState:UIControlStateNormal];
        [self.wxdnsBtn setTarget:self action:@selector(clickWxdnsBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [scrollView addSubview: self.wxdnsBtn];
    
    switch (self.mainPageModel.currentStep) {
        case 1:
            self.carView = [[UIImageView alloc] initWithFrame:CGRectMake(mainPageWidth * 0.393, mainPageHeight * 0.250, mainPageWidth * 0.129, mainPageHeight * 0.034)];
            break;
        
        case 2:
            self.carView = [[UIImageView alloc] initWithFrame:CGRectMake(mainPageWidth * 0.200, mainPageHeight * 0.370, mainPageWidth * 0.129, mainPageHeight * 0.034)];
            break;
            
        case 3:
            self.carView = [[UIImageView alloc] initWithFrame:CGRectMake(mainPageWidth * 0.590, mainPageHeight * 0.510, mainPageWidth * 0.129, mainPageHeight * 0.034)];
            break;
            
        case 4:
            self.carView = [[UIImageView alloc] initWithFrame:CGRectMake(mainPageWidth * 0.460, mainPageHeight * 0.700, mainPageWidth * 0.129, mainPageHeight * 0.034)];
            break;
            
        case 5:
            self.carView = [[UIImageView alloc] initWithFrame:CGRectMake(mainPageWidth * 0.460, mainPageHeight * 0.850, mainPageWidth * 0.129, mainPageHeight * 0.034)];
            break;
        default:
            break;
    }

    self.carView.image = [UIImage imageNamed:@"小车"];
    [self.scrollView addSubview:self.carView];
    

}

- (void)clickRxbbBtn:(id)sender{
    DLNecessityViewController *rxbbVC = [[DLNecessityViewController alloc] init];

    [self.navigationController pushViewController:rxbbVC animated:YES];
    rxbbVC.callBackHandle = ^{
        if (self.mainPageModel.currentStep < 2) {
            [self.mainPageModel setCurrentStep:2];
            [self.xyglBtn addTarget:self action:@selector(clickXyglBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (![self.mainPageModel.hasAnimationed[1] boolValue]) {
                [self buttonDisappearAnimation:self.xyglBtn];
                [self reloadButtonImage];
                self.mainPageModel.hasAnimationed[1] = [NSNumber numberWithBool:YES];
                [self moveCar];
            }
        }
    };
}

- (void)clickXyglBtn:(id)sender{
    SchoolHomePageViewController *xyglVC = [[SchoolHomePageViewController alloc] init];
    
    [self.navigationController pushViewController:xyglVC animated:YES];
    xyglVC.callBackHandle = ^{
        if (self.mainPageModel.currentStep < 3) {
            [self.mainPageModel setCurrentStep:3];
            [self.xsjlBtn addTarget:self action:@selector(clickXsjlBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (![self.mainPageModel.hasAnimationed[2] boolValue]) {
                [self buttonDisappearAnimation:self.xsjlBtn];
                 [self reloadButtonImage];
                self.mainPageModel.hasAnimationed[2] = [NSNumber numberWithBool:YES];
                [self moveCar];
            }
        }
    };
}

- (void)clickXsjlBtn:(id)sender{
    ChatViewControl *xsjlVC = [[ChatViewControl alloc] init];
    
    [self.navigationController pushViewController:xsjlVC animated:YES];
    xsjlVC.callBackHandle = ^{
        if (self.mainPageModel.currentStep < 4) {
            [self.mainPageModel setCurrentStep:4];
            [self.bdlcBtn addTarget:self action:@selector(clickBdlcBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (![self.mainPageModel.hasAnimationed[3] boolValue]) {
                [self buttonDisappearAnimation:self.bdlcBtn];
                 [self reloadButtonImage];
                self.mainPageModel.hasAnimationed[3] = [NSNumber numberWithBool:YES];
                [self moveCar];
            }
        }
    };
}

- (void)clickBdlcBtn:(id)sender{
    ReportWaterfallController *bdlcVC = [[ReportWaterfallController alloc] init];
    
    [self.navigationController pushViewController:bdlcVC animated:YES];
    bdlcVC.callBackHandle = ^{
        if (self.mainPageModel.currentStep < 5) {
            [self.mainPageModel setCurrentStep:5];
            [self.wxdnsBtn addTarget:self action:@selector(clickWxdnsBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (![self.mainPageModel.hasAnimationed[4] boolValue]) {
                [self buttonDisappearAnimation:self.wxdnsBtn];
                 [self reloadButtonImage];
                self.mainPageModel.hasAnimationed[4] = [NSNumber numberWithBool:YES];
                [self moveCar];
            }
        }
    };
}

- (void)clickJxtjBtn:(id)sender{
    MilitarytrainingViewController *jxtjVC = [[MilitarytrainingViewController alloc] init];
    [self.navigationController pushViewController:jxtjVC animated:YES];
}

- (void)clickWxdnsBtn:(id)sender{
    WantToSayController *collageVC = [[WantToSayController alloc] init];
    [self.navigationController pushViewController:collageVC animated:YES];
}

- (void)clickCyfcBtn:(id)sender{
    SYCCharacterViewController *cyfcVC = [[SYCCharacterViewController alloc] init];
    cyfcVC.callBackHandle = ^{
    };
    [self.navigationController pushViewController:cyfcVC animated:YES];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mainPageModel = [SYCMainPageModel shareInstance];
        
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

- (void)buttonDisappearAnimation:(UIButton *)button{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    CAKeyframeAnimation *rotation = nil;
    rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    CGFloat angle = M_PI_4 * 0.4;
    NSArray *values = @[@(angle * 0.1),@(-angle * 0.2),@(angle * 0.3), @(-angle * 0.4), @(angle * 0.5), @(-angle * 0.6),@(angle * 0.7),@(-angle * 0.8), @(angle * 0.9), @(-angle)];
    [rotation setValues:values];
    [rotation setRepeatCount:1];
    [rotation setDuration:2.0];
    [rotation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    [rotation setRemovedOnCompletion:NO];
    [rotation setFillMode:kCAFillModeBoth];
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [opacity setDuration:2.0];
    [opacity setFromValue:@1.0];
    [opacity setToValue:@0];
    
    [animationGroup setDuration:2.0];
    [animationGroup setAnimations:@[rotation, opacity]];
    [button.layer addAnimation:animationGroup forKey:nil];
}

- (void)buttonAppearAnimation:(UIButton *)button{
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [opacity setDuration:1.0];
    [opacity setFromValue:@0];
    [opacity setToValue:@1.0];
    [opacity setBeginTime:CACurrentMediaTime()+ 2.0];
    [button.layer addAnimation:opacity forKey:@"opacity"];
}

- (void)reloadButtonImage{
    NSUInteger currentStep = self.mainPageModel.currentStep;
    switch (currentStep) {
        case 2:
            [self.xyglBtn setImage:[UIImage imageNamed:@"校园攻略"] forState:UIControlStateNormal];
            [self buttonAppearAnimation:self.xyglBtn];
            break;
            
        case 3:
            [self.xsjlBtn setImage:[UIImage imageNamed:@"线上交流"] forState:UIControlStateNormal];
            [self buttonAppearAnimation:self.xsjlBtn];
            break;
            
        case 4:
            [self.bdlcBtn setImage:[UIImage imageNamed:@"报道流程"] forState:UIControlStateNormal];
            [self buttonAppearAnimation:self.bdlcBtn];
            break;
            
        case 5:
            [self.wxdnsBtn setImage:[UIImage imageNamed:@"我想对你说"] forState:UIControlStateNormal];
            [self buttonAppearAnimation:self.wxdnsBtn];
            break;
            
        default:
            break;
    }

    [self.view layoutSubviews];
}

- (void)moveCar{
    CGFloat mainPageWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat mainPageHeight = mainPageWidth * 2.933;
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 3.0;
    //Lets loop continuously for the demonstration
    pathAnimation.repeatCount = 1;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    switch (self.mainPageModel.currentStep - 1) {
        case 1:
            CGPathMoveToPoint(curvedPath, NULL, mainPageWidth * 0.440, mainPageHeight * 0.270);
            CGPathAddQuadCurveToPoint(curvedPath, NULL, mainPageWidth * 0.260, mainPageHeight * 0.380, mainPageWidth * 0.260, mainPageHeight * 0.380);
            break;
        
        case 2:
            CGPathMoveToPoint(curvedPath, NULL, mainPageWidth * 0.260, mainPageHeight * 0.380);
            CGPathAddQuadCurveToPoint(curvedPath, NULL, mainPageWidth * 0.190, mainPageHeight * 0.430, mainPageWidth * 0.660, mainPageHeight * 0.535);
            break;
            
        case 3:
            CGPathMoveToPoint(curvedPath, NULL, mainPageWidth * 0.660, mainPageHeight * 0.535);
            CGPathAddQuadCurveToPoint(curvedPath, NULL, mainPageWidth * 0.860, mainPageHeight * 0.630, mainPageWidth * 0.510, mainPageHeight * 0.715);
            break;
            
        case 4:
            CGPathMoveToPoint(curvedPath, NULL, mainPageWidth * 0.510, mainPageHeight * 0.715);
            CGPathAddQuadCurveToPoint(curvedPath, NULL, mainPageWidth * 0.360, mainPageHeight * 0.820, mainPageWidth * 0.510, mainPageHeight * 0.870);
            break;

        default:
            break;
    }
    
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    [self.carView.layer addAnimation:pathAnimation
                            forKey:@"moveTheSquare"];
}

- (void)dataFailed{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"数据加载失败" message:@"请检查网络连接" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *refleshAction = [UIAlertAction actionWithTitle:@"重新加载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载数据中...";
        hud.detailsLabelText = @"第一次启动请耐心等待噢";
        hud.color = [UIColor colorWithWhite:0.f alpha:0.4f];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            self.mainPageModel = [SYCMainPageModel shareInstance];
            [SYCActivityManager sharedInstance];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        });
    }];
    
    [alertController addAction:refleshAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
