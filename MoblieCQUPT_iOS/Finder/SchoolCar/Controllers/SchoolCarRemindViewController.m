//
//  SchoolCarRemindViewController.m
//  SchoolCarDemo
//
//  Created by 周杰 on 2018/3/10.
//  Copyright © 2018年 周杰. All rights reserved.
//

#import "SchoolCarRemindViewController.h"
#import <Masonry.h>
@interface SchoolCarRemindViewController ()

@end
int _mark = 1;
@implementation SchoolCarRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Tips_view"]];
    [self.view addSubview:view];
    [view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
    }];
    if (self.backBlock) {
        self.backBlock(_mark);
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
