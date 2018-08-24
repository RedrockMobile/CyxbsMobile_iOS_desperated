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

@interface SYCDataAnaylseViewController ()

@property (nonatomic, strong)SYCSexRatioViewController *sexRatioVC;
@property (nonatomic, strong)SYCSubjectViewController *subjectsVC;

@end

@implementation SYCDataAnaylseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.sexRatioVC = [[SYCSexRatioViewController alloc] init];
    self.sexRatioVC.title = @"男女比例";
    self.sexRatioVC.data = self.data;
    
    self.subjectsVC = [[SYCSubjectViewController alloc] init];
    self.subjectsVC.title = @"最难科目";
    self.subjectsVC.data = self.data;
    
    NSArray *viewsArray = @[self.sexRatioVC, self.subjectsVC];
    SYCSegmentView *segmentView = [[SYCSegmentView alloc] initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT - HEADERHEIGHT) andControllers:viewsArray andType:SYCSegmentViewTypeNormal];
    [self.view addSubview:segmentView];
    
    self.title = self.data.name;
    self.tabBarController.tabBar.hidden = YES;
    segmentView.eventDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollEventWithIndex:(NSInteger)index{
    if (index == 1) {
        [self.subjectsVC reflesh];
    }else{
        [self.sexRatioVC reflesh];
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
