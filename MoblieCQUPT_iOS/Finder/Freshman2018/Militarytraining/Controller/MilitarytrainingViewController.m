//
//  MilitarytrainingViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "MilitarytrainingViewController.h"

#import "MilitarytrainingShowViewController.h"
#import "MilitarytrainingTipsViewController.h"

#import "SegmentView.h"
@interface MilitarytrainingViewController ()
@property (nonatomic, strong) SegmentView *MainSegmentView;
@property (nonatomic, strong) UIView *MainView;
@end

@implementation MilitarytrainingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"军训特辑";
    
    
    //将军训风采和小贴士初始化并添加到军训特辑根视图上
    NSMutableArray *Array = [NSMutableArray arrayWithCapacity:2];
    MilitarytrainingShowViewController *vc1 = [[MilitarytrainingShowViewController alloc]init];
    vc1.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self addChildViewController:vc1];
    Array[0] = vc1;
    
    MilitarytrainingTipsViewController *vc2 = [[MilitarytrainingTipsViewController alloc]init];
    vc2.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self addChildViewController:vc2];
    Array[1] = vc2;
    
    
    self.MainSegmentView =  [[SegmentView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-HEADERHEIGHT) andControllers:[NSArray arrayWithArray:Array]];
    self.MainSegmentView.titleColor = [UIColor colorWithHexString:@"999999"];
    self.MainSegmentView.selectedTitleColor = [UIColor colorWithHexString:@"54acff"];
    [self.MilitarytrainingRootView addSubview:self.MainSegmentView];
    
    
    //添加军训特辑根视图
    self.MilitarytrainingRootView.frame = CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT-HEADERHEIGHT);
    [self.view addSubview:_MilitarytrainingRootView];
    
    // Do any additional setup after loading the view from its nib.
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
