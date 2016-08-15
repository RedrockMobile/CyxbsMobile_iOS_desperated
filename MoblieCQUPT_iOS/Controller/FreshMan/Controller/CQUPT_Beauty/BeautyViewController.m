//
//  BeautyViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/8/15.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "BeautyViewController.h"
#import "BeautyOrganizationViewController.h"
#import "BeautyCreatViewController.h"
#import "BeautyCquptViewController.h"
#import "BeautyExcellentStudentViewController.h"
#import "BeautyExcellentTeacherVeiewController.h"
#import "SegmentView.h"

@interface BeautyViewController ()<SegmentViewScrollerViewDelegate>

@property (strong, nonatomic) BeautyCreatViewController *two;
@property (strong, nonatomic) BeautyCquptViewController *three;
@property (strong, nonatomic) BeautyExcellentStudentViewController *four;
@property (strong, nonatomic) BeautyExcellentTeacherVeiewController *five;

@property (assign, nonatomic) BOOL isLoadView1;
@property (assign, nonatomic) BOOL isLoadView2;
@property (assign, nonatomic) BOOL isLoadView3;
@property (assign, nonatomic) BOOL isLoadView4;

@end

@implementation BeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    BeautyOrganizationViewController *one = [[BeautyOrganizationViewController alloc]init];
    _two = [[BeautyCreatViewController alloc]init];
    _three = [[BeautyCquptViewController alloc]init];
    _four = [[BeautyExcellentStudentViewController alloc]init];
    _five = [[BeautyExcellentTeacherVeiewController alloc]init];
    
    one.title = @"学生组织";
    _two.title = @"原创重邮";
    _three.title = @"美在重邮";
    _four.title = @"优秀学子";
    _five.title = @"优秀教师";
    
    _isLoadView1 = NO;
    _isLoadView2 = NO;
    _isLoadView3 = NO;
    _isLoadView4 = NO;
    
    NSArray *array = @[one,_two,_three,_four,_five];
    SegmentView *segment = [[SegmentView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) withTitle:array];
    segment.eventDelegate = self;
    [self.view addSubview:segment];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index {
    if (index == 1 && !_isLoadView1) {
        [_two downLoad];
        _isLoadView2 = YES;
    }else if (index == 2 && !_isLoadView2) {
        [_three downLoad];
        _isLoadView3 = YES;
    }else if (index == 3 && !_isLoadView3) {
        [_four downLoad];
        _isLoadView4 = YES;
    }else if (index == 4 && !_isLoadView4) {
        [_five downLoad];
        _isLoadView4 = YES;
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
