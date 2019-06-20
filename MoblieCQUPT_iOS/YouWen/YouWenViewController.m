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
    [self setUpUI];
}

//加载界面方法
- (void)setUpUI{
    //加载4个分类板块，并添加进SegmentView
    self.edgesForExtendedLayout = UIRectEdgeNone;
    YouWenSortViewController *emtionView = [[YouWenSortViewController alloc] initViewStyle:@"情感"];
    emtionView.title = @"情感";
    YouWenSortViewController *learningView = [[YouWenSortViewController alloc] initViewStyle:@"学习"];
    learningView.title = @"学习";
    YouWenSortViewController *otherView = [[YouWenSortViewController alloc] initViewStyle:@"其他"];
    otherView.title = @"其他";
    YouWenSortViewController *allView = [[YouWenSortViewController alloc] initViewStyle:@"全部"];
    allView.title = @"全部";
    NSArray *views = @[allView, emtionView, learningView, otherView];
    for (YouWenSortViewController *view in views) {
        view.superController = self;
    }
    SYCSegmentView *segView = [[SYCSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TOTAL_TOP_HEIGHT - TABBARHEIGHT) controllers:views type:SYCSegmentViewTypeNormal];
    
    [self.view addSubview:segView];
    
    //加载添加按钮
    CGFloat buttonRadius = 40;
    _askBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_askBtn setImage:[UIImage imageNamed:@"AskQuestion"] forState:UIControlStateNormal];
    [self.view addSubview:_askBtn];
    [_askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(buttonRadius * 2);
        make.height.mas_equalTo(buttonRadius * 2);
        make.bottom.equalTo(segView);
        make.right.equalTo(segView).with.offset(-10);
    }];
    [_askBtn addTarget:self action:@selector(setNewQuestion) forControlEvents:UIControlEventTouchUpInside];
    
}

//点击加载按钮调用的方法
- (void)setNewQuestion{
    YouWenTopicView *topicView = [[YouWenTopicView alloc]initTheWhiteViewHeight:283];
    [topicView setUpUI];
    topicView.topicDelegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:topicView];
    
}

//获取得到的话题类型的代理方法
- (void)topicStyle:(NSString *)style{
    YouWenAddViewController *addView = [[YouWenAddViewController alloc] initWithStyle:style];
    addView.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:addView animated:YES];
}

@end
