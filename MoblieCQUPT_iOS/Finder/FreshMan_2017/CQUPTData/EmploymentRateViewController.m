//
//  EmploymentRateViewController.m
//  TestLayoutButton
//
//  Created by helloworld on 2017/8/5.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "StatisticsTable.h"
#import <AFNetworking.h>
#import "EmploymentRateViewController.h"

#define KHEIGHT [UIScreen mainScreen].bounds.size.height
#define KWIDTH [UIScreen mainScreen].bounds.size.width

@interface EmploymentRateViewController ()

@property (strong, nonatomic) NSArray *companyArray;
@property (strong, nonatomic) NSArray *numberOfPeopleArray;
@property (strong, nonatomic) NSArray *animateViewWidthArray;

@end

@implementation EmploymentRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 6)];
    [self.view addSubview:grayView];
    grayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];

    self.companyArray = [[NSArray alloc] initWithObjects:@"腾讯", @"华为", @"烽火", @"中国铁塔", @"海信", @"猪八戒", @"中国联通", @"深信服", @"中国移动", @"中国电信", nil];
    self.animateViewWidthArray = [[NSArray alloc] initWithObjects:@(26), @(43), @(44), @(71), @(58), @(74), @(142), @(46), @(138), @(99), nil];
    self.numberOfPeopleArray = [[NSArray alloc] initWithObjects:@"20人", @"22人", @"23人", @"40人", @"35人", @"65人", @"194人", @"25人", @"177人", @"123人", nil];
}

- (void)getData {
    for (int i = 0; i < 10; i++) {
        if ([UIScreen mainScreen].bounds.size.width <= 330) {
            UILabel *companyLabel = [[UILabel alloc] init];
            [self.view addSubview:companyLabel];
            companyLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            companyLabel.text = self.companyArray[i];
            companyLabel.font = [UIFont systemFontOfSize:10];
            companyLabel.textAlignment = NSTextAlignmentCenter;
            [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(19);
                make.top.equalTo(self.view.mas_top).offset(30 * (i+1) + 13 * i);
                make.height.mas_equalTo(13);
                make.width.mas_equalTo(60);
            }];
            UIView *animateView = [[UIView alloc] initWithFrame:CGRectMake(90, 30 * (i+1) + 13 * i, 0, 18)];
            [self.view addSubview:animateView];
            animateView.layer.cornerRadius = 8;
            animateView.backgroundColor = [UIColor colorWithRed:158/255.0 green:252/255.0 blue:238/255.0 alpha:1];
            
            UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(90+15, 30 * (i+1) + 13 * i, 50, 20)];
            [self.view addSubview:numberLabel];
            numberLabel.font = [UIFont systemFontOfSize:10];
            numberLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.55];
            numberLabel.text = self.numberOfPeopleArray[i];
            
            [UIView beginAnimations:@"animate" context:nil];
            [UIView setAnimationDuration:2];
            [animateView setWidth:[self.animateViewWidthArray[i] doubleValue]];
            [numberLabel setOrigin:CGPointMake(105 + [self.animateViewWidthArray[i] doubleValue], 30 * (i+1) + 13 * i)];
            [UIView commitAnimations];
        }
        else {
            UILabel *companyLabel = [[UILabel alloc] init];
            [self.view addSubview:companyLabel];
            companyLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            companyLabel.text = self.companyArray[i];
            companyLabel.font = [UIFont systemFontOfSize:14];
            companyLabel.textAlignment = NSTextAlignmentCenter;
            [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(19);
                make.top.equalTo(self.view.mas_top).offset(34 * (i+1) + 13 * i);
                make.height.mas_equalTo(13);
                make.width.mas_equalTo(60);
            }];

        //为什么取不到
//          double originY = CGRectGetMidY(companyLabel.bounds);
//          double height = CGRectGetHeight(companyLabel.bounds);
        
            UIView *animateView = [[UIView alloc] initWithFrame:CGRectMake(90, 34 * (i+1) + 13 * i, 0, 18)];
            [self.view addSubview:animateView];
            animateView.layer.cornerRadius = 8;
            animateView.backgroundColor = [UIColor colorWithRed:158/255.0 green:252/255.0 blue:238/255.0 alpha:1];
        
            UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(90+15, 34 * (i+1) + 13 * i, 50, 20)];
            [self.view addSubview:numberLabel];
            numberLabel.font = [UIFont systemFontOfSize:14];
            numberLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.55];
            numberLabel.text = self.numberOfPeopleArray[i];
        
            [UIView beginAnimations:@"animate" context:nil];
            [UIView setAnimationDuration:2];
            [animateView setWidth:[self.animateViewWidthArray[i] doubleValue]];
            [numberLabel setOrigin:CGPointMake(105 + [self.animateViewWidthArray[i] doubleValue], 34 * (i+1) + 13 * i)];
            [UIView commitAnimations];
        }
    }
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
