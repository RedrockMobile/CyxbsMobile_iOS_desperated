//
//  ViewController.m
//  TestLayoutButton
//
//  Created by helloworld on 2017/8/4.
//  Copyright © 2017年 topkid. All rights reserved.
//
#import "HomePageViewController.h"

#import "StuStrategyRootViewController.h"
#import "CQUPTDataRootViewController.h"
#import "StuRootViewController.h"
#import "MilitaryTrainingRootViewController.h"
@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutButton];
}


- (void)tapFirstBtn {
    StuStrategyRootViewController *stuVC = [[StuStrategyRootViewController alloc] init];    
    [self.navigationController pushViewController:stuVC animated:YES];
}
- (void)tapSecondBtn{
    StuRootViewController *BeautyVC = [[StuRootViewController alloc]init];
    [self.navigationController pushViewController:BeautyVC animated:YES];
    
}
- (void)tapThirdBtn {
     CQUPTDataRootViewController *CQUPTDataVC = [[CQUPTDataRootViewController alloc] init];
    [self.navigationController pushViewController:CQUPTDataVC animated:YES];
}
- (void)tapFourthBtn {
    MilitaryTrainingRootViewController *MTVC = [[MilitaryTrainingRootViewController alloc] init];
    [self.navigationController pushViewController:MTVC animated:YES];
}

- (void)layoutButton {
    
/*
 邮子攻略
*/
    UIButton *firstBtn = [[UIButton alloc] init];
    firstBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstBtn];
    firstBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    [firstBtn setBackgroundImage:[UIImage imageNamed:@"邮子攻略"] forState:UIControlStateNormal];
//取消高亮 but why?...
    firstBtn.adjustsImageWhenDisabled = NO;
    firstBtn.adjustsImageWhenHighlighted = NO;
//    firstBtn.highlighted = NO;

    [firstBtn addTarget:self action:@selector(tapFirstBtn) forControlEvents:UIControlEventTouchUpInside];

    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:firstBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:18];
    [self.view addConstraint:leftConstraint];
    
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:firstBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-18];
    [self.view addConstraint:rightConstraint];

    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:firstBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:84];
    [self.view addConstraint:topConstraint];
    
        double width = [UIScreen mainScreen].bounds.size.width - 36.0;
    
//        double heigth = 121/340.0 * width;
//    NSLayoutConstraint *heigthConstraint = [NSLayoutConstraint constraintWithItem:firstBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:heigth];
//    [firstBtn addConstraint:heigthConstraint];
    

/*
 重邮风采
 */
    UIButton *secBtn = [[UIButton alloc] init];
    secBtn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:secBtn];
    secBtn.translatesAutoresizingMaskIntoConstraints = NO;
    secBtn.backgroundColor = [UIColor whiteColor];
    [secBtn addTarget:self action:@selector(tapSecondBtn)forControlEvents:UIControlEventTouchUpInside];
    [secBtn setBackgroundImage:[UIImage imageNamed:@"重邮风采"] forState:UIControlStateNormal];
    secBtn.adjustsImageWhenDisabled = NO;
    secBtn.adjustsImageWhenHighlighted = NO;
    
//    [secBtn addTarget:self action:@selector(tapSecBtn) forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *leftConstraint1 = [NSLayoutConstraint constraintWithItem:secBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:18];
    [self.view addConstraint:leftConstraint1];
    
    
    NSLayoutConstraint *rightConstraint1 = [NSLayoutConstraint constraintWithItem:secBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-18];
    [self.view addConstraint:rightConstraint1];
    
    
    NSLayoutConstraint *topConstraint1 = [NSLayoutConstraint constraintWithItem:secBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:firstBtn attribute:NSLayoutAttributeBottom multiplier:1.0 constant:27];
    [self.view addConstraint:topConstraint1];

//    NSLayoutConstraint *heigthConstraint1 = [NSLayoutConstraint constraintWithItem:secBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:heigth];
//    [secBtn addConstraint:heigthConstraint1];
    
/*
 重邮数据
 */
    UIButton *thirdBtn = [[UIButton alloc] init];
    thirdBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:thirdBtn];
    thirdBtn.translatesAutoresizingMaskIntoConstraints = NO;
    thirdBtn.backgroundColor = [UIColor whiteColor];
    
    [thirdBtn setBackgroundImage:[UIImage imageNamed:@"重邮数据"] forState:UIControlStateNormal];
    thirdBtn.adjustsImageWhenDisabled = NO;
    thirdBtn.adjustsImageWhenHighlighted = NO;
    
    [thirdBtn addTarget:self action:@selector(tapThirdBtn) forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *leftConstraint2 = [NSLayoutConstraint constraintWithItem:thirdBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:18];
    [self.view addConstraint:leftConstraint2];
    
    
    NSLayoutConstraint *rightConstraint2 = [NSLayoutConstraint constraintWithItem:thirdBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-18];
    [self.view addConstraint:rightConstraint2];
    
    
    NSLayoutConstraint *topConstraint2 = [NSLayoutConstraint constraintWithItem:thirdBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:secBtn attribute:NSLayoutAttributeBottom multiplier:1.0 constant:27];
    [self.view addConstraint:topConstraint2];
    
//    NSLayoutConstraint *heigthConstraint2 = [NSLayoutConstraint constraintWithItem:thirdBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:heigth];
//    [thirdBtn addConstraint:heigthConstraint2];
    
/*
 军训热辑
 */
    UIButton *fourthBtn = [[UIButton alloc] init];
    fourthBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:fourthBtn];
    fourthBtn.translatesAutoresizingMaskIntoConstraints = NO;
    fourthBtn.backgroundColor = [UIColor whiteColor];

    [fourthBtn setBackgroundImage:[UIImage imageNamed:@"军训特辑"] forState:UIControlStateNormal];
    [fourthBtn addTarget:self action:@selector(tapFourthBtn) forControlEvents:UIControlEventTouchUpInside];
    fourthBtn.adjustsImageWhenDisabled = NO;
    fourthBtn.adjustsImageWhenHighlighted = NO;
    
    NSLayoutConstraint *leftConstraint3 = [NSLayoutConstraint constraintWithItem:fourthBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:18];
    [self.view addConstraint:leftConstraint3];
    
    
    NSLayoutConstraint *rightConstraint3 = [NSLayoutConstraint constraintWithItem:fourthBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-18];
    [self.view addConstraint:rightConstraint3];
    
    
    NSLayoutConstraint *topConstraint3 = [NSLayoutConstraint constraintWithItem:fourthBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:thirdBtn attribute:NSLayoutAttributeBottom multiplier:1.0 constant:27];
    [self.view addConstraint:topConstraint3];
    
//    NSLayoutConstraint *heigthConstraint3 = [NSLayoutConstraint constraintWithItem:fourthBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:heigth];
//    [fourthBtn addConstraint:heigthConstraint3];
    
    NSLayoutConstraint *heigthConstraint1 = [NSLayoutConstraint constraintWithItem:firstBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:secBtn attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [self.view addConstraint:heigthConstraint1];
    
    NSLayoutConstraint *heigthConstraint2 = [NSLayoutConstraint constraintWithItem:secBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:thirdBtn attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [self.view addConstraint:heigthConstraint2];
    
    NSLayoutConstraint *heigthConstraint3 = [NSLayoutConstraint constraintWithItem:thirdBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:fourthBtn attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [self.view addConstraint:heigthConstraint3];
    
    NSLayoutConstraint *heigthConstraint4 = [NSLayoutConstraint constraintWithItem:fourthBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-27];
    [self.view addConstraint:heigthConstraint4];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
