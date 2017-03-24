//
//  LostViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/8.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LostViewController.h"
#import "SegmentView.h"
#import "PrefixHeader.pch"
#import "LostTableViewController.h"
#import "GraduateViewController.h"
#import "IssueTableViewController.h"
@interface LostViewController ()<SegmentViewScrollerViewDelegate>
@property UISegmentedControl *segmentedControl;
@end

@implementation LostViewController

- (void)viewDidAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"失物启示",@"招领启示"]];
    self.navigationItem.titleView = self.segmentedControl;
    self.segmentedControl.tintColor = [UIColor colorWithRed:65/255.f green:163/255.f blue:255/255.f alpha:1];
    [self.segmentedControl addTarget:self action:@selector(action:) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl setSelectedSegmentIndex:0];
    
    
    NSArray *array = @[@"全部",@"一卡通",@"钱包",@"钥匙",@"电子产品",@"雨伞",@"衣物",@"其它"];
    LostTableViewController *tc = [[LostTableViewController alloc]init];
    [self.view addSubview:tc.view];
    NSMutableArray *vcArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i<array.count; i++) {
        LostTableViewController *vc = [[LostTableViewController alloc]initWithTitle:array[i]];
        [self addChildViewController:vc];
        vcArray[i] = vc;
    }
    SegmentView *segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, ScreenHeight-64) withTitle:[NSArray arrayWithArray:vcArray]];
    [self.view addSubview:segmentView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)action:(UISegmentedControl *)segment{
    NSString *title = [segment titleForSegmentAtIndex:segment.selectedSegmentIndex];
    if ([title isEqualToString:@"失物启事"]) {
        
    }
    else if([title isEqualToString:@"招领启事"]){
        
    }
}
- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index{
    
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
