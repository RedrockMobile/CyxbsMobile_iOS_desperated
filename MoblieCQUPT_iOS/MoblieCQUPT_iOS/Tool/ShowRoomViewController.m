//
//  ShowRoomViewController.m
//  ConsultingTest
//
//  Created by RainyTunes on 8/22/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "ShowRoomViewController.h"
#import "We.h"

@interface ShowRoomViewController ()

@end

@implementation ShowRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *submitButton = [We getButtonWithTitle:@"教室查询" Color:BlueLight];
    [self.view addSubview:submitButton];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 100, 30)];
    [label setText:@"教室"];
    [label setBackgroundColor:[We getColor:Grey]];
    [self.view addSubview:label];
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
