//
//  YouWenViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenViewController.h"
#import "YouWenTableViewCell.h"
#import "YouWenSortViewController.h"
@interface YouWenViewController ()
@property (strong, nonatomic) UIButton *askBtn;
@end

@implementation YouWenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _askBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_askBtn setImage:[UIImage imageNamed:@"AskQuestion"] forState:UIControlStateNormal];
    _askBtn.frame = CGRectMake(ScreenWidth - 100, SCREENHEIGHT - 100, 50, 50);
    [self.view addSubview:_askBtn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"inform"] style:UIBarButtonItemStylePlain target:self action:@selector(sdf)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sort"] style:UIBarButtonItemStylePlain target:self action:@selector(sdf)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
