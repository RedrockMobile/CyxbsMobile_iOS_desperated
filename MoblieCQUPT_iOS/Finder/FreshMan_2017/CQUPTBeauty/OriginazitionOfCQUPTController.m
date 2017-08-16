//
//  OriginazitionOfCQUPTController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/11.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "OriginazitionOfCQUPTController.h"
#import "Originazition.h"
#import "SubSegementView.h"
#import "SegmentView.h"
#import "PrefixHeader.pch"
@interface OriginazitionOfCQUPTController ()

@end

@implementation OriginazitionOfCQUPTController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    Originazition *vc1 = [[Originazition alloc]init];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
    vc1.i = 0;
    vc1.title = @"团委部门";
    Originazition *vc2 = [[Originazition alloc]init];
    vc2.title = @"红岩网校";
    vc2.i = 1;
    Originazition *vc3 = [[Originazition alloc]init];
    vc3.i = 2;
    vc3.title = @"校学生会";
    Originazition *vc4 = [[Originazition alloc]init];
    vc4.i = 3;
    vc4.title = @"科联";
    Originazition *vc5 = [[Originazition alloc] init];
    vc5.i = 4;
    vc5.title = @"社联";
    Originazition *vc6 = [[Originazition alloc]init];
    vc6.title = @"校青协";
    vc6.i = 5;
    Originazition *vc7 = [[Originazition alloc]init];
    vc7.title = @"大艺团";
    vc7.i = 6;
    
    NSArray *str = @[vc1, vc2, vc3, vc4, vc5, vc6, vc7];
    SubSegementView *segement = [[SubSegementView alloc]initWithFrame:CGRectMake(0, 2, SCREENWIDTH, ScreenHeight) andControllers:str];
    [self.view addSubview:segement];
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
