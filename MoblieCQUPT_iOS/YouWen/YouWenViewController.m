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
#import "YouWenAddViewController.h"
#import "YouWenTopicView.h"
#import "ReportViewController.h"
#import "SYCSegmentView.h"
#import "LoginViewController.h"

@interface YouWenViewController () <whatTopic>
//添加新问题按钮
@property (strong, nonatomic) UIButton *askBtn;

@end


@implementation YouWenViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    if (![UserDefaultTool getStuNum]) {
        [self tint:self];
        return;
    }else{
        [self setUpUI];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    if (![UserDefaultTool getStuNum]) {
        [self tint:self];
        return;
    }
}

//加载界面方法
- (void)setUpUI{
    //加载4个分类板块，并添加进SegmentView
    self.edgesForExtendedLayout = UIRectEdgeNone;
    YouWenSortViewController *emtionView = [[YouWenSortViewController alloc] initViewStyle:@"情感"];
    emtionView.title = @"情感";
    YouWenSortViewController *otherView = [[YouWenSortViewController alloc] initViewStyle:@"其他"];
    otherView.title = @"其他";
    YouWenSortViewController *learningView = [[YouWenSortViewController alloc] initViewStyle:@"学习"];
    learningView.title = @"学习";
    YouWenSortViewController *allView = [[YouWenSortViewController alloc] initViewStyle:@"全部"];
    allView.title = @"全部";
    NSArray *views = @[emtionView, otherView, learningView, allView];
    for (YouWenSortViewController *view in views) {
        view.superController = self;
    }
    SYCSegmentView *segView = [[SYCSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - HEADERHEIGHT - TABBARHEIGHT - SAFE_AREA_BOTTOM) controllers:views type:SYCSegmentViewTypeNormal];
    [self.view addSubview:segView];
    
    //加载添加按钮
    _askBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_askBtn setImage:[UIImage imageNamed:@"AskQuestion"] forState:UIControlStateNormal];
    _askBtn.frame = CGRectMake(SCREEN_WIDTH - 28 - 58 * autoSizeScaleX, segView.height - 58 * autoSizeScaleX - 20, 58 * autoSizeScaleX, 58 * autoSizeScaleX);
    [_askBtn addTarget:self action:@selector(setNewQuestion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_askBtn];
}

//点击加载按钮调用的方法
- (void)setNewQuestion{
    YouWenTopicView *topicView = [[YouWenTopicView alloc]initTheWhiteViewHeight:283];
    [topicView addDetail];
    topicView.topicDelegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:topicView];
    
}

//获取得到的话题类型的代理方法
- (void)topicStyle:(NSString *)style{
    YouWenAddViewController *addView = [[YouWenAddViewController alloc] initWithStyle:style];
    addView.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:addView animated:YES];
}

//登陆弹窗
- (void)tint:(UIViewController *)controller{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否登录？" message:@"登录后才能查看更多信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *LVC = [[LoginViewController alloc] init];
        LVC.loginSuccessHandler = ^(BOOL success) {
            if (success) {
                [self setUpUI];
            }
        };
        [weakSelf presentViewController:LVC animated:YES completion:nil];
    }];
    [alertC addAction:cancel];
    [alertC addAction:confirm];
    [self presentViewController:alertC animated:YES completion:nil];
}

@end
