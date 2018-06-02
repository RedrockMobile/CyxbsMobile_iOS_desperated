//
//  LXAskViewController.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/5/30.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "LXAskViewController.h"
#import "SegmentView.h"
#import "LXAskDeatilViewController.h"

@interface LXAskViewController ()<SegmentViewDelegate>

@property (nonatomic, strong) SegmentView *segmentView;

@end

@implementation LXAskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    LXAskDeatilViewController *VC1 = [[LXAskDeatilViewController alloc] init];
    LXAskDeatilViewController *VC2 = [[LXAskDeatilViewController alloc] init];
    if (self.isAsk) {
        VC1.solvedProblem = @"solvedProblem";
        VC2.solvedProblem = @"notSolvedProblem";
        VC1.title = @"已解决";
        VC2.title = @"未解决";
        VC1.isAsk = YES;
        VC2.isAsk = YES;
    } else {
        VC1.solvedProblem = @"adoptedAnswers";
        VC2.solvedProblem = @"notAdoptedAnswers";
        VC1.title = @"已采纳";
        VC2.title = @"未采纳";
        VC1.isAsk = NO;
        VC2.isAsk = NO;
    }
    NSArray *VCArray = @[VC1, VC2];
    self.segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT) andControllers:VCArray];
    self.segmentView.eventDelegate = self;
    [self.view addSubview:self.segmentView];
}

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index {
    ;
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
