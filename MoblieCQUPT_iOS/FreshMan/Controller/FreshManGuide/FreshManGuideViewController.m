//
//  FreshManGuideViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/8/15.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "FreshManGuideViewController.h"
#import "SegmentView.h"

#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "SevenViewController.h"
#import "EightViewController.h"

@interface FreshManGuideViewController ()<SegmentViewScrollerViewDelegate>

@property (assign, nonatomic) BOOL isLoadView3;
@property (assign, nonatomic) BOOL isLoadView6;
@property (assign, nonatomic) BOOL isLoadView7;
@property (assign, nonatomic) BOOL isLoadView8;

@property (strong, nonatomic) ThreeViewController *three;
@property (strong, nonatomic) SixViewController *six;
@property (strong, nonatomic) SevenViewController *seven;
@property (strong, nonatomic) EightViewController *eight;
@end

@implementation FreshManGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    OneViewController *one = [[OneViewController alloc]init];
    TwoViewController *two = [[TwoViewController alloc]init];
    _three = [[ThreeViewController alloc]init];
    FourViewController *four = [[FourViewController alloc]init];
    FiveViewController *five = [[FiveViewController alloc]init];
    _six = [[SixViewController alloc]init];
    _seven = [[SevenViewController alloc]init];
    _eight = [[EightViewController alloc]init];
    
    _isLoadView3 = NO;
    _isLoadView6 = NO;
    _isLoadView7 = NO;
    _isLoadView8 = NO;

    
    one.title = @"安全须知";
    two.title = @"须知路线";
    _three.title = @"寝室概况";
    four.title = @"必备清单";
    five.title = @"QQ群";
    _six.title = @"日常生活";
    _seven.title = @"周边美食";
    _eight.title = @"周边美景";
    
    NSArray *vcs = @[one,two,_three,four,five,_six,_seven,_eight];
    
    SegmentView *segment = [[SegmentView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) andControllers:vcs];
    segment.eventDelegate = self;
    [self.view addSubview:segment];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index {
//    NSLog(@"%ld", index);
    //3 6 7 8
    if (index == 2 && !_isLoadView3) {
        NSLog(@"222222");
        [_three dwonload];
        _isLoadView3 = YES;
    }else if (index == 5 && !_isLoadView6) {
        NSLog(@"5555");
        [_six download];
        _isLoadView6 = YES;
    }else if (index == 6 && !_isLoadView7) {
        NSLog(@"6666");
        [_seven download];
        _isLoadView7 = YES;
    }else if (index == 7 && !_isLoadView8) {
        NSLog(@"7777");
        [_eight download];
        _isLoadView8 = YES;
    }
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
