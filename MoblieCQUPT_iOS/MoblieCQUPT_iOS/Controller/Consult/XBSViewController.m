//
//  XBSViewController.m
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/11/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "XBSViewController.h"

@interface XBSViewController ()

@end

@implementation XBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar = [[XBSNavigationBar alloc]initWithTitle:@"" Delegate:self];
    
    self.statusBar = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    self.statusBar.backgroundColor = MAIN_COLOR;
    
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.statusBar];
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
