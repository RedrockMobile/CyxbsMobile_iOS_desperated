//
//  LZIssueSucceedViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/4/4.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZIssueSucceedViewController.h"
#import "IssueTableViewController.h"
@interface LZIssueSucceedViewController ()

@end

@implementation LZIssueSucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    NSInteger index=0;
    NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
    //得到当前视图控制器中的所有控制器
    for (int i = 0; i<self.navigationController.viewControllers.count; i++) {
        if ([self.navigationController.viewControllers[i] isKindOfClass:[IssueTableViewController class]]) {
            index = i;
        }
    }
    [array removeObjectAtIndex:index];
    //把B从里面删除

    [self.navigationController setViewControllers:[array copy] animated:YES];
    //把删除后的控制器数组再次赋值

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
