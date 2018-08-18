//
//  SYCDataAnaylseViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCDataAnaylseViewController.h"
#import "SYCSexRatioViewController.h"
#import "SYCSubjectViewController.h"
#import "SegmentView.h"

@interface SYCDataAnaylseViewController ()

@end

@implementation SYCDataAnaylseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    SYCSexRatioViewController *sexRatioVC = [[SYCSexRatioViewController alloc] init];
    sexRatioVC.title = @"男女比例";
    sexRatioVC.data = self.data;
    
    SYCSubjectViewController *subjectsVC = [[SYCSubjectViewController alloc] init];
    subjectsVC.title = @"最难科目";
    subjectsVC.data = self.data;
    
    NSArray *viewsArray = @[sexRatioVC, subjectsVC];
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT - HEADERHEIGHT) andControllers:viewsArray];
    [self.view addSubview:segmentView];
    
    self.title = self.data.name;
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
