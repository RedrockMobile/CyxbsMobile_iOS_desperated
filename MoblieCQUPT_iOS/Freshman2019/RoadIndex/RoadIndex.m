//
//  DirectingTheWayInCQUPT.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/3.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "RoadIndex.h"
#import "BusRoutes.h"
#import "CampusScenery.h"
#import "SYCSegmentView.h"
@interface RoadIndex ()

@end

@implementation RoadIndex

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"指路重邮";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    BusRoutes *busRoutes = [[BusRoutes alloc]init];
    busRoutes.title = @"公交线路";
    [self addChildViewController:busRoutes];
    CampusScenery *campusScenery = [[CampusScenery alloc]init];
    campusScenery.title = @"校园风采";
    [self addChildViewController:campusScenery];
    NSArray *viewcontrollers = @[busRoutes, campusScenery];
    SYCSegmentView *segView = [[SYCSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TOTAL_TOP_HEIGHT - TABBARHEIGHT) controllers:viewcontrollers type:SYCSegmentViewTypeNormal];
    segView.isHiddenLine = YES;
    [segView setSelectedTitleColor:RGBColor(70, 114, 255, 0.9)];
    [segView setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
    
    [self.view addSubview:segView];
    // Do any additional setup after loading the view.
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
