//
//  LQQZhiLuChongYouViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/2.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "LQQXiaoYuanZhiYinViewController.h"

#import "FSScrollContentView.h"
#import "ChildViewController.h"
#import "LQQDataModel.h"
#import "LQQfirstChooseButtonView.h"
#import "InfiniteRollScrollView.h"
#import "LQQsubjectDataView.h"
#import "LQQpercentageOfStudent.h"
//#import "LQQimageModel.h"
#import "LQQchooseCollegeViewController.h"
#import "ExpressCompanyItem.h"
#import "SchoolNavigatorController.h"
#import "DiningHallAndDormitoryItem.h"
#import "DiningHallAndDormitoryController.h"


@interface LQQXiaoYuanZhiYinViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
//下方的滚动view
//@property(nonatomic,strong)UIScrollView*backgroundView;
//下方的滚动view
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
//数据
@property (nonatomic,strong) LQQDataModel*INeedData;

@property(nonatomic,strong) LQQfirstChooseButtonView * topButton;
@property (nonatomic, strong) FSPageContentView *fyhPageContentView;

@property (nonatomic, copy) NSArray<ExpressCompanyItem *> *companyArray;
@property(nonatomic, assign)BOOL firstChoose;
@property(nonatomic,strong)LQQchooseCollegeViewController*chooseCollegeTableViewController;
@property(nonatomic, strong) MBProgressHUD *hud;

@end

@implementation LQQXiaoYuanZhiYinViewController

- (void)viewDidLoad {

    //页面初始化工作
    [super viewDidLoad];
    _INeedData = [LQQDataModel sharedSingleton];
    self.hidesBottomBarWhenPushed = YES;
    [self buildMyNavigationbar];

    _choosedCollege = [[NSString alloc]init];
    //加载宿舍食堂快递数据揭秘按钮的View
    _topButton = [[LQQfirstChooseButtonView alloc]init];
     _topButton.frame = CGRectMake(0, 0,self.view.bounds.size.width, 49);
    _topButton.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_topButton];

    //数据初始化
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:247/255.0 blue:255/255.0 alpha:1];

    //一级选择

    
    [_topButton.dormitory addTarget:self action:@selector(clickDormitory) forControlEvents:UIControlEventTouchUpInside];
    [_topButton.dormitory setTitle:_INeedData.firstDataTitle[0] forState:UIControlStateNormal];
    
    
    [_topButton.shiTang addTarget:self action:@selector(clickFanTang) forControlEvents:UIControlEventTouchUpInside];
    [_topButton.shiTang setTitle:_INeedData.firstDataTitle[1] forState:UIControlStateNormal];
    
    
    [_topButton.kuaiDi addTarget:self action:@selector(clickKuaiDi) forControlEvents:UIControlEventTouchUpInside];
    [_topButton.kuaiDi setTitle:_INeedData.firstDataTitle[2] forState:UIControlStateNormal];
    
    
    [_topButton.shuJuJieMi addTarget:self action:@selector(clickShuJuJieMi) forControlEvents:UIControlEventTouchUpInside];
    [_topButton.shuJuJieMi setTitle:_INeedData.firstDataTitle[3] forState:UIControlStateNormal];
    
//二级选择标题
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, _topButton.height, CGRectGetWidth(self.view.bounds), 30/*self.view.height*60.0/1334*/) titles:@[@"明理苑",@"宁静苑",@"兴业苑",@"知行苑"] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    
    self.titleView.titleSelectFont = [UIFont systemFontOfSize:15];
    self.titleView.selectIndex = 0;

    [self.view addSubview:_titleView];
    _titleView.backgroundColor = [UIColor colorWithRed:246/255.0 green:253/255.0 blue:255/255.0 alpha:1];

    self.pageContentView.contentViewCurrentIndex = 0;
        //    self.pageContentView.contentViewCanScroll = NO;//设置滑动属性

    //第三部分的调色工作
    _titleView.titleNormalColor = [UIColor colorWithRed:122/255.0 green:118/255.0 blue:127/255.0 alpha:0.8];
    _titleView.titleSelectColor = [UIColor colorWithRed:11/255.0 green:18/255.0 blue:16/255.0 alpha:0.9];
    _titleView.indicatorColor = [UIColor clearColor];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"努力加载中";
    self.hud = hud;
}

- (void)viewWillAppear:(BOOL)animated{
//    [_topButton.kuaiDi sendActionsForControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidAppear:(BOOL)animated{
    if(!_firstChoose){
    [_topButton.dormitory sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}
//展示导航栏
- (void)buildMyNavigationbar{

    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];

    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"校园指引";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:19];
    [titleView addSubview:titleLabel];

   
    self.navigationItem.titleView = titleView;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerX.equalTo(titleView);
        make.centerY.equalTo(titleView);
    }];
}

//展示下方背景图片的view


-(void)clickDormitory{
    
    
    if(self.chooseCollegeTableViewController)
    {
        [_chooseCollegeTableViewController removeFromParentViewController];
        [_chooseCollegeTableViewController.view removeFromSuperview];
    }
    //更新之前title的光标
    self.titleView.selectIndex = 0;
    //刷新下方title
    //1. 承载title的列表数据被替换
    [_titleView removeFromSuperview];
    
//    _titleView.titlesArr = @[@"test1",@"test2",@"test3",@"test4"];


    _topButton.dormitory.selected = YES;
    _topButton.shiTang.selected = NO;
    _topButton.kuaiDi.selected = NO;
    _topButton.shuJuJieMi.selected = NO;
    
    if (self.fyhPageContentView) {
        [self.fyhPageContentView removeFromSuperview];
        self.fyhPageContentView = nil;
    }
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:DININGHALLANDDORMITORYAPI method:HttpRequestGet parameters:nil prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *dormitoryItems = [NSMutableArray array];
        NSMutableArray*array = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"text"][0][@"message"]) {
            DiningHallAndDormitoryItem *dormitory = [DiningHallAndDormitoryItem diningHallWithDict:dict];
            [array addObject:dormitory.name];
            [dormitoryItems addObject:dormitory];
        }
        self.titleView.titlesArr = array;
        [self.view addSubview:self.titleView];

        NSMutableArray *childVC = [NSMutableArray array];
        for (DiningHallAndDormitoryItem *item in dormitoryItems) {
            DiningHallAndDormitoryController *vc = [[DiningHallAndDormitoryController alloc] init];
            vc.model = item;
            [childVC addObject:vc];
        }
        self.fyhPageContentView = [[FSPageContentView alloc] initWithFrame:CGRectMake(0, 94 - 15, MAIN_SCREEN_W, MAIN_SCREEN_H - TOTAL_TOP_HEIGHT - 94 + 15) childVCs:childVC parentVC:self delegate:self];
        [self.view addSubview:self.fyhPageContentView];
        
        [self.hud hide:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];


}
    
-(void)clickFanTang{
    
    if(self.chooseCollegeTableViewController)
    {
        [_chooseCollegeTableViewController removeFromParentViewController];
        [_chooseCollegeTableViewController.view removeFromSuperview];
    }
    
    //更新之前title的光标
    self.titleView.selectIndex = 0;
    //刷新下方title
    //1. 承载title的列表数据被替换
    [_titleView removeFromSuperview];
    
    //    self.
    [self.view addSubview:_titleView];
//    _titleView.userInteractionEnabled = NO;
    _topButton.dormitory.selected = NO;
    _topButton.shiTang.selected = YES;
    _topButton.kuaiDi.selected = NO;
    _topButton.shuJuJieMi.selected = NO;
    
    if (self.fyhPageContentView) {
        [self.fyhPageContentView removeFromSuperview];
        self.fyhPageContentView = nil;
    }
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:DININGHALLANDDORMITORYAPI method:HttpRequestGet parameters:nil prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *diningHallItems = [NSMutableArray array];
         NSMutableArray*array = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"text"][1][@"message"]) {
            DiningHallAndDormitoryItem *diningHall = [DiningHallAndDormitoryItem diningHallWithDict:dict];
            [diningHallItems addObject:diningHall];
              [array addObject:diningHall.name];
            
            
        }
        _titleView.titlesArr = array;
        NSMutableArray *childVC = [NSMutableArray array];
        for (DiningHallAndDormitoryItem *item in diningHallItems) {
            DiningHallAndDormitoryController *vc = [[DiningHallAndDormitoryController alloc] init];
            vc.model = item;
            [childVC addObject:vc];
        }
        self.fyhPageContentView = [[FSPageContentView alloc] initWithFrame:CGRectMake(0, 94 - 15, MAIN_SCREEN_W, MAIN_SCREEN_H - TOTAL_TOP_HEIGHT - 94 + 15) childVCs:childVC parentVC:self delegate:self];
        [self.view addSubview:self.fyhPageContentView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

    
    
    

-(void)clickKuaiDi{
    
    
    if(self.chooseCollegeTableViewController)
    {
        [_chooseCollegeTableViewController removeFromParentViewController];
        [_chooseCollegeTableViewController.view removeFromSuperview];
    }
    _topButton.dormitory.selected = NO;
    _topButton.shiTang.selected = NO;
    _topButton.kuaiDi.selected = YES;
    _topButton.shuJuJieMi.selected = NO;
    
    
    //更新之前title的光标
    self.titleView.selectIndex = 0;
    //刷新下方title
    //1. 承载title的列表数据被替换
    [_titleView removeFromSuperview];
    
    //    self.
    [self.view addSubview:_titleView];
//    _titleView.userInteractionEnabled = NO;

    if (self.fyhPageContentView) {
        [self.fyhPageContentView removeFromSuperview];
        self.fyhPageContentView = nil;
    }
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:EXPRESSAPI method:HttpRequestGet parameters:nil prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *tempArray = [NSMutableArray array];
        NSMutableArray*array = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"text"]) {
            ExpressCompanyItem *item = [ExpressCompanyItem companyWithDict:dict];
            [tempArray addObject:item];
            [array addObject:item.companyName];
        }
        _titleView.titlesArr = array;

        self.companyArray = tempArray;
        
        NSMutableArray *childVCArray = [NSMutableArray array];
        for (ExpressCompanyItem *company in self.companyArray) {
            
            SchoolNavigatorController *vc = [[SchoolNavigatorController alloc] init];
            vc.company = company;
            [childVCArray addObject:vc];
        }
        self.fyhPageContentView = [[FSPageContentView alloc] initWithFrame:CGRectMake(0, 94 - 15, MAIN_SCREEN_W, MAIN_SCREEN_H - TOTAL_TOP_HEIGHT - 94 + 15) childVCs:childVCArray parentVC:self delegate:self];
        [self.view addSubview:self.fyhPageContentView];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)clickShuJuJieMi{
    
    _firstChoose = YES;
    
    _topButton.dormitory.selected = NO;
    _topButton.shiTang.selected = NO;
    _topButton.kuaiDi.selected = NO;
    _topButton.shuJuJieMi.selected = YES;
//    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//    [self.view addSubview:view];
//    view.backgroundColor = [UIColor redColor];
    [_titleView removeFromSuperview];
    [_fyhPageContentView removeAllSubviews];
    
    
    LQQchooseCollegeViewController*chooseCollegeTableViewController = [[LQQchooseCollegeViewController alloc]init];
//    chooseCollegeTableViewController.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:chooseCollegeTableViewController];
    [self.view addSubview:chooseCollegeTableViewController.view];
    chooseCollegeTableViewController.view.frame = CGRectMake(0,49, self.view.width, self.view.height-49);
//    chooseCollegeTableViewController.view.backgroundColor = [UIColor redColor];
    self.chooseCollegeTableViewController =chooseCollegeTableViewController;
//    [self.navigationController pushViewController:chooseCollegeTableViewController animated:YES];

}



#pragma mark --
//代理：处理点击后的回调数据
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.fyhPageContentView.contentViewCurrentIndex = endIndex;
//    self.fyhPageContentView.conte
}
//处理滑动后的回调数据
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{

    self.titleView.selectIndex = endIndex;

}


@end
