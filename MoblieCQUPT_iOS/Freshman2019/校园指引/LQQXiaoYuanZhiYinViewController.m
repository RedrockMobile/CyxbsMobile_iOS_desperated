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
@interface LQQXiaoYuanZhiYinViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
//下方的滚动view
//@property(nonatomic,strong)UIScrollView*backgroundView;
//下方的滚动view
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
//数据
@property (nonatomic,strong) LQQDataModel*INeedData;
@property(nonatomic,strong) NSArray*currentSecondList;//当前的二级目录标题
//@property(nonatomic)int firstChoose;//当前选择的一级目录//0-3分别为宿舍、食堂、快递、数据揭秘
@property(nonatomic, strong)NSMutableArray<UILabel*>*titleLabelArr;//大标题
@property(nonatomic, strong)NSMutableArray<UILabel*>*contentLabelArr;//小标题
@property(nonatomic, strong)NSMutableArray<UILabel*>*contentLabelArrshiTang;//食堂的小标题
@property(nonatomic, strong)NSMutableArray<UILabel*>*contentLabelArrkuaiDi;//食堂的小标题

@property(nonatomic,strong) LQQfirstChooseButtonView * topButton;
@property(nonatomic,strong)NSMutableArray<InfiniteRollScrollView*>*scrollImageArr;//存放轮播图的数组
//@property(nonatomic,strong)InfiniteRollScrollView *scrollView;
//@property(nonatomic,strong) UIView* backgroundView;//背景框，图片命名为itemBackgroundImage
@property(nonatomic,strong)NSMutableArray<NSMutableArray<UIImage*>*>*suShePhoto;
@property(nonatomic,strong)NSMutableArray<NSMutableArray<UIImage*>*>*shiTangPhoto;
@property(nonatomic,strong)NSMutableArray<NSMutableArray<UIImage*>*>*kuaiDiPhoto;
@property(nonatomic)int flag0;//等于1时代表用户第一次点进宿舍;解决了反复加载图片的bug;
@property(nonatomic)int flag1;//等于1时代表用户第一次点进食堂;解决了反复加载图片的bug;
@property(nonatomic)int flag2;
//@property(nonatomic,strong)NSMutableArray<NSMutableArray<UIImage*>*>*suSheImageArray;
@end

@implementation LQQXiaoYuanZhiYinViewController

- (void)viewDidLoad {

    _flag0 = 1;
    _flag1 = 1;
    _flag2 = 1;
    //页面初始化工作
    [super viewDidLoad];
    _INeedData = [LQQDataModel sharedSingleton];
    self.hidesBottomBarWhenPushed = YES;
    [self buildMyNavigationbar];
    _scrollImageArr = [NSMutableArray array];
    _titleLabelArr = [NSMutableArray array];
    _contentLabelArr = [NSMutableArray array];
    _contentLabelArrshiTang = [NSMutableArray array];
    _contentLabelArrkuaiDi = [NSMutableArray array];
//    _suSheImageArray = [NSMutableArray array];
    for(int i = 0; i < _INeedData.suShe.count ;i++){
        _contentLabelArr[i] = [[UILabel alloc]init];
    }
    for(int i = 0; i < _INeedData.fanTang.count ;i++){
        _contentLabelArrshiTang[i] = [[UILabel alloc]init];
    }
    for(int i = 0; i < _INeedData.kuaiDi.count ;i++){
        _contentLabelArrkuaiDi[i] = [[UILabel alloc]init];
    }
    _choosedCollege = [[NSString alloc]init];
    //加载宿舍食堂快递数据揭秘按钮的View
    _topButton = [[LQQfirstChooseButtonView alloc]init];
     _topButton.frame = CGRectMake(0, 0,self.view.bounds.size.width, self.view.height*97.0/1334);
    _topButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topButton];

    //数据初始化
    NSArray<NSString*> *diningHall = [[NSArray alloc]initWithArray:_INeedData.fanTang];
    self.automaticallyAdjustsScrollViewInsets = NO;

    _currentSecondList = [[NSArray alloc]initWithArray:_INeedData.suShe];
    
    //一级选择

    
    [_topButton.dormitory addTarget:self action:@selector(clickDormitory) forControlEvents:UIControlEventTouchUpInside];
    [_topButton.dormitory setTitle:_INeedData.firstDataTitle[0] forState:UIControlStateNormal];
    
    
    [_topButton.shiTang addTarget:self action:@selector(clickFanTang) forControlEvents:UIControlEventTouchUpInside];
    [_topButton.shiTang setTitle:_INeedData.firstDataTitle[1] forState:UIControlStateNormal];
    
    
    [_topButton.kuaiDi addTarget:self action:@selector(clickKuaiDi) forControlEvents:UIControlEventTouchUpInside];
    [_topButton.kuaiDi setTitle:_INeedData.firstDataTitle[2] forState:UIControlStateNormal];
    
    
    [_topButton.shuJuJieMi addTarget:self action:@selector(clickShuJuJieMi) forControlEvents:UIControlEventTouchUpInside];
    [_topButton.shuJuJieMi setTitle:_INeedData.firstDataTitle[3] forState:UIControlStateNormal];
    
    
    //二级选择
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, _topButton.height, CGRectGetWidth(self.view.bounds), self.view.height*60.0/1334) titles:_currentSecondList delegate:self indicatorType:FSIndicatorTypeEqualTitle];

    
//    self.titleView.titleSelectFont = [UIFont systemFontOfSize:15];
    self.titleView.selectIndex = 0;
    [self.view addSubview:_titleView];
    _titleView.backgroundColor = [UIColor colorWithRed:246/255.0 green:253/255.0 blue:255/255.0 alpha:1];

    self.pageContentView.contentViewCurrentIndex = 0;
        //    self.pageContentView.contentViewCanScroll = NO;//设置滑动属性

    //第三部分的调色工作
    _titleView.titleNormalColor = [UIColor colorWithRed:122/255.0 green:118/255.0 blue:127/255.0 alpha:0.8];
    _titleView.titleSelectColor = [UIColor colorWithRed:11/255.0 green:18/255.0 blue:16/255.0 alpha:0.9];
    _titleView.indicatorColor = _titleView.titleSelectColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [_topButton.dormitory sendActionsForControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidAppear:(BOOL)animated{
    [_topButton.dormitory sendActionsForControlEvents:UIControlEventTouchUpInside];

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
    
    //未选择数据揭秘
//    _firstChoose = 0;
    //更新之前title的光标
    self.titleView.selectIndex = 0;
    //刷新下方title
    //1. 承载title的列表数据被替换
    [_titleView removeFromSuperview];
    _currentSecondList = _INeedData.suShe;
    _titleView.titlesArr = _INeedData.suShe;
    [self.view addSubview:_titleView];
    _topButton.dormitory.selected = YES;
    _topButton.shiTang.selected = NO;
    _topButton.kuaiDi.selected = NO;
    _topButton.shuJuJieMi.selected = NO;
    
    
    if(_flag0 == 1){
        _flag0++;
    //将传过来的URL转化为图片
    for(int i = 0; i < _INeedData.suShe.count;i++){
        for(int j = 0;j < 3;j++){
            [self.suShePhoto[i] addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:_INeedData.suShePhoto[i][j]]]];
            NSLog(@"QLLQ%@",_INeedData.suShePhoto[i][j]);
        }
//
    }
    }

    
    //刷新下方view
    [_pageContentView removeFromSuperview];
    NSMutableArray<ChildViewController*> *childVCs = [[NSMutableArray alloc]init];//此数组用来放第四部分的每一个view
    for (NSString *title in _INeedData.suShe) {
        ChildViewController *vc = [[ChildViewController alloc]init];
        //        vc.title = title;
        vc.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:246/255.0 blue:255/255.0 alpha:1];
        [childVCs addObject:vc];
    }
    
    //hhhhhhhhhhhhhhh



    for(int i = 0; i < _INeedData.suShe.count ;i++){
    InfiniteRollScrollView*view =[[InfiniteRollScrollView alloc]init];
    _scrollImageArr[i] = view;
//        [_scrollImageArr addObject:view];
    [childVCs[i].backgroundView addSubview:_scrollImageArr[i]];
    _scrollImageArr[i].backgroundColor = [UIColor redColor];
    [_scrollImageArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(childVCs[i].backgroundView).offset(30);
        make.width.equalTo(childVCs[i].backgroundView).offset(-60);
        make.height.equalTo(childVCs[i].backgroundView).multipliedBy(0.45);
        make.centerX.equalTo(childVCs[i].backgroundView);
    }];
    _scrollImageArr[i].delegate = self;
        _scrollImageArr[i].pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
//    _scrollImage.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        
    //需要显示的所有图片对应的信息
    _scrollImageArr[i].imageModelInfoArray = [NSMutableArray array];

    [childVCs[i].scrollImage removeFromSuperview];
        _titleLabelArr[i] = [[UILabel alloc]init];
        [childVCs[i].view addSubview:_titleLabelArr[i]];
//        _titleLabelArr[i].backgroundColor = [UIColor redColor];
        [_titleLabelArr[i] setFont:[UIFont fontWithName:@"PingFang-SC-Bold" size:14.0f]];
         _titleLabelArr[i].textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.7f];
        _titleLabelArr[i].text = _INeedData.suShe[i];
            [_titleLabelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_scrollImageArr[i].mas_bottom).offset(10);
                make.width.equalTo(childVCs[i].view).multipliedBy((144.0+150)/750);
                make.height.equalTo(childVCs[i].view).multipliedBy(26.0/(1334-129-97-60));
                make.left.equalTo(_scrollImageArr[i]);
            }];
    

    //iiiiiiiiiiiiiiiiiiiiiii
    [childVCs[i].view addSubview:_contentLabelArr[i]];
    _contentLabelArr[i].backgroundColor = [UIColor clearColor];
    [_contentLabelArr[i] setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:14.0f]];
        _contentLabelArr[i].textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.65f];
        
        
        
        _contentLabelArr[i].text = _INeedData.suSheDetail[i];
        _contentLabelArr[i].numberOfLines = 0;
    [_contentLabelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabelArr[i].mas_bottom).offset(5);
        make.width.equalTo(_scrollImageArr[i]);
        make.height.equalTo(childVCs[i].view).multipliedBy((218.0+85)/(1334-129-97-60));
        make.left.equalTo(_scrollImageArr[i]);
    }];
      
//        _suSheImageArray[i] = self.suShePhoto[i];
        
        _scrollImageArr[i].imageArray = self.suShePhoto[i];
        NSLog(@"%@LQLQLQ",self.suShePhoto);
//
        
        
    }
    //下面的可以删掉
    
    
    
//
//
//    _scrollImageArr[0].imageArray =@[
//                                     [UIImage imageNamed:@"LQQ0"],
//                                     [UIImage imageNamed:@"LQQ1"],
//                                     [UIImage imageNamed:@"LQQ2"],
//                                     [UIImage imageNamed:@"LQQ3"],
//                                     [UIImage imageNamed:@"LQQ4"]
//                                     ];
//    _scrollImageArr[1].imageArray =@[
//                                     [UIImage imageNamed:@"LQQ0"],
//
//                                     [UIImage imageNamed:@"LQQ4"]
//                                     ];
    //到这里
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,100, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 90) childVCs:childVCs parentVC:self delegate:self];//把ChildVCs数组中的界面展示在pageContentview上
    self.pageContentView.contentViewCurrentIndex = 0;
    //    self.pageContentView.contentViewCanScroll = NO;//设置滑动属性
    [self.view addSubview:_pageContentView];
    [self.pageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.75);
        make.top.equalTo(_titleView.mas_bottom);
        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.view.mas_centerY).offset(15);
    }];
    }
    
    
    

-(void)clickFanTang{
    //未选择数据揭秘
    //    _firstChoose = 1;
    //更新之前title的光标
    self.titleView.selectIndex = 0;
    //刷新下方title
    //1. 承载title的列表数据被替换
    [_titleView removeFromSuperview];
    _currentSecondList = _INeedData.fanTang;
    _titleView.titlesArr = _INeedData.fanTang;
    [self.view addSubview:_titleView];
    _topButton.dormitory.selected = NO;
    _topButton.shiTang.selected = YES;
    _topButton.kuaiDi.selected = NO;
    _topButton.shuJuJieMi.selected = NO;

    
    
    if(_flag1 == 1){
        _flag1++;
        //将传过来的URL转化为图片
        for(int i = 0; i < _INeedData.fanTang.count;i++){
            for(int j = 0;j < 3;j++){
                [self.shiTangPhoto[i] addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:_INeedData.shiTangPhoto[i][j]]]];
            }
            //
        }
    }
    
    
    //刷新下方view
    [_pageContentView removeFromSuperview];
    NSMutableArray<ChildViewController*> *childVCs = [[NSMutableArray alloc]init];//此数组用来放第四部分的每一个view
    for (NSString *title in _INeedData.fanTang) {
        ChildViewController *vc = [[ChildViewController alloc]init];
        //        vc.title = title;
        vc.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:246/255.0 blue:255/255.0 alpha:1];
        [childVCs addObject:vc];
    }
    
    //hhhhhhhhhhhhhhh
    
    
    
    for(int i = 0; i < _INeedData.fanTang.count ;i++){
        InfiniteRollScrollView*view =[[InfiniteRollScrollView alloc]init];
        _scrollImageArr[i] = view;
        //        [_scrollImageArr addObject:view];
        [childVCs[i].backgroundView addSubview:_scrollImageArr[i]];
        _scrollImageArr[i].backgroundColor = [UIColor redColor];
        [_scrollImageArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(childVCs[i].backgroundView).offset(30);
            make.width.equalTo(childVCs[i].backgroundView).offset(-60);
            make.height.equalTo(childVCs[i].backgroundView).multipliedBy(0.45);
            make.centerX.equalTo(childVCs[i].backgroundView);
        }];
        _scrollImageArr[i].delegate = self;
        _scrollImageArr[i].pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        //    _scrollImage.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        
        //需要显示的所有图片对应的信息
        _scrollImageArr[i].imageModelInfoArray = [NSMutableArray array];
        
        [childVCs[i].scrollImage removeFromSuperview];
        _titleLabelArr[i] = [[UILabel alloc]init];
        [childVCs[i].view addSubview:_titleLabelArr[i]];
        //        _titleLabelArr[i].backgroundColor = [UIColor redColor];
        [_titleLabelArr[i] setFont:[UIFont fontWithName:@"PingFang-SC-Bold" size:14.0f]];
        _titleLabelArr[i].textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.7f];
        _titleLabelArr[i].text = _INeedData.fanTang[i];
        [_titleLabelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollImageArr[i].mas_bottom).offset(10);
            make.width.equalTo(childVCs[i].view).multipliedBy((144.0+150)/750);
            make.height.equalTo(childVCs[i].view).multipliedBy(26.0/(1334-129-97-60));
            make.left.equalTo(_scrollImageArr[i]);
        }];
        
        
        //iiiiiiiiiiiiiiiiiiiiiii
        [childVCs[i].view addSubview:_contentLabelArrshiTang[i]];
        _contentLabelArrshiTang[i].backgroundColor = [UIColor clearColor];
        [_contentLabelArrshiTang[i] setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:14.0f]];
        _contentLabelArrshiTang[i].textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.65f];
        
        
        
        _contentLabelArrshiTang[i].text = _INeedData.shiTangDetail[i];
        _contentLabelArrshiTang[i].numberOfLines = 0;
        [_contentLabelArrshiTang[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabelArr[i].mas_bottom).offset(5);
            make.width.equalTo(_scrollImageArr[i]);
            make.height.equalTo(childVCs[i].view).multipliedBy((218.0+85)/(1334-129-97-60));
            make.left.equalTo(_scrollImageArr[i]);
        }];
        
        //        _suSheImageArray[i] = self.suShePhoto[i];
        
        _scrollImageArr[i].imageArray = self.shiTangPhoto[i];
        //
        
        
    }
    //下面的可以删掉
    
    
    
    //
    //
    //    _scrollImageArr[0].imageArray =@[
    //                                     [UIImage imageNamed:@"LQQ0"],
    //                                     [UIImage imageNamed:@"LQQ1"],
    //                                     [UIImage imageNamed:@"LQQ2"],
    //                                     [UIImage imageNamed:@"LQQ3"],
    //                                     [UIImage imageNamed:@"LQQ4"]
    //                                     ];
    //    _scrollImageArr[1].imageArray =@[
    //                                     [UIImage imageNamed:@"LQQ0"],
    //
    //                                     [UIImage imageNamed:@"LQQ4"]
    //                                     ];
    //到这里
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,100, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 90) childVCs:childVCs parentVC:self delegate:self];//把ChildVCs数组中的界面展示在pageContentview上
    self.pageContentView.contentViewCurrentIndex = 0;
    //    self.pageContentView.contentViewCanScroll = NO;//设置滑动属性
    [self.view addSubview:_pageContentView];
    [self.pageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.75);
        make.top.equalTo(_titleView.mas_bottom);
        make.centerX.equalTo(self.view);
        //        make.centerY.equalTo(self.view.mas_centerY).offset(15);
    }];
    
    
    
}

    
    
    


-(void)clickKuaiDi{
    //未选择数据揭秘
//    _firstChoose = 2;
    //更新之前title的光标
    self.titleView.selectIndex = 0;
    //刷新下方title
    //1. 承载title的列表数据被替换
    [_titleView removeFromSuperview];
    _currentSecondList = _INeedData.kuaiDi;
    _titleView.titlesArr = _INeedData.kuaiDi;
    [self.view addSubview:_titleView];
    _topButton.dormitory.selected = NO;
    _topButton.shiTang.selected = NO;
    _topButton.kuaiDi.selected = YES;
    _topButton.shuJuJieMi.selected = NO;
    
    if(_flag2 == 1){
        _flag2++;
        //将传过来的URL转化为图片
        for(int i = 0; i < _INeedData.kuaiDi.count;i++){
            for(int j = 0;j < 1;j++){
//                [self.kuaiDiPhoto[i] addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:_INeedData.kuaiDiPhoto[i][j]]]];
            }
            //
        }
    }
    
    
    //刷新下方view
    [_pageContentView removeFromSuperview];
    NSMutableArray<ChildViewController*> *childVCs = [[NSMutableArray alloc]init];//此数组用来放第四部分的每一个view
    for (NSString *title in _INeedData.kuaiDi) {
        ChildViewController *vc = [[ChildViewController alloc]init];
        //        vc.title = title;
        vc.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:246/255.0 blue:255/255.0 alpha:1];
        [childVCs addObject:vc];
    }
    
    //hhhhhhhhhhhhhhh
    
    
    
    for(int i = 0; i < _INeedData.kuaiDi.count ;i++){
        InfiniteRollScrollView*view =[[InfiniteRollScrollView alloc]init];
        _scrollImageArr[i] = view;
        //        [_scrollImageArr addObject:view];
        [childVCs[i].backgroundView addSubview:_scrollImageArr[i]];
        _scrollImageArr[i].backgroundColor = [UIColor redColor];
        [_scrollImageArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(childVCs[i].backgroundView).offset(30);
            make.width.equalTo(childVCs[i].backgroundView).offset(-60);
            make.height.equalTo(childVCs[i].backgroundView).multipliedBy(0.45);
            make.centerX.equalTo(childVCs[i].backgroundView);
        }];
        _scrollImageArr[i].delegate = self;
        _scrollImageArr[i].pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        //    _scrollImage.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        
        //需要显示的所有图片对应的信息
        _scrollImageArr[i].imageModelInfoArray = [NSMutableArray array];
        
        [childVCs[i].scrollImage removeFromSuperview];
        _titleLabelArr[i] = [[UILabel alloc]init];
        [childVCs[i].view addSubview:_titleLabelArr[i]];
        //        _titleLabelArr[i].backgroundColor = [UIColor redColor];
        [_titleLabelArr[i] setFont:[UIFont fontWithName:@"PingFang-SC-Bold" size:14.0f]];
        _titleLabelArr[i].textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.7f];
        _titleLabelArr[i].text = _INeedData.kuaiDi[i];
        [_titleLabelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollImageArr[i].mas_bottom).offset(10);
            make.width.equalTo(childVCs[i].view).multipliedBy((144.0+150)/750);
            make.height.equalTo(childVCs[i].view).multipliedBy(26.0/(1334-129-97-60));
            make.left.equalTo(_scrollImageArr[i]);
        }];
        
        
        //iiiiiiiiiiiiiiiiiiiiiii
        [childVCs[i].view addSubview:_contentLabelArrkuaiDi[i]];
        _contentLabelArrkuaiDi[i].backgroundColor = [UIColor clearColor];
        [_contentLabelArrkuaiDi[i] setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:14.0f]];
        _contentLabelArrkuaiDi[i].textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.65f];
        
        
        
        _contentLabelArrkuaiDi[i].text = _INeedData.kuaiDiDetail[i];
        _contentLabelArrkuaiDi[i].numberOfLines = 0;
        [_contentLabelArrkuaiDi[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabelArr[i].mas_bottom).offset(5);
            make.width.equalTo(_scrollImageArr[i]);
            make.height.equalTo(childVCs[i].view).multipliedBy((218.0+85)/(1334-129-97-60));
            make.left.equalTo(_scrollImageArr[i]);
        }];
        
        //        _suSheImageArray[i] = self.suShePhoto[i];
        
        _scrollImageArr[i].imageArray = self.kuaiDiPhoto[i];
        //
        
        
    }
    //下面的可以删掉
    
    
    
    //
    //
    //    _scrollImageArr[0].imageArray =@[
    //                                     [UIImage imageNamed:@"LQQ0"],
    //                                     [UIImage imageNamed:@"LQQ1"],
    //                                     [UIImage imageNamed:@"LQQ2"],
    //                                     [UIImage imageNamed:@"LQQ3"],
    //                                     [UIImage imageNamed:@"LQQ4"]
    //                                     ];
    //    _scrollImageArr[1].imageArray =@[
    //                                     [UIImage imageNamed:@"LQQ0"],
    //
    //                                     [UIImage imageNamed:@"LQQ4"]
    //                                     ];
    //到这里
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,100, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 90) childVCs:childVCs parentVC:self delegate:self];//把ChildVCs数组中的界面展示在pageContentview上
    self.pageContentView.contentViewCurrentIndex = 0;
    //    self.pageContentView.contentViewCanScroll = NO;//设置滑动属性
    [self.view addSubview:_pageContentView];
    [self.pageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.75);
        make.top.equalTo(_titleView.mas_bottom);
        make.centerX.equalTo(self.view);
        //        make.centerY.equalTo(self.view.mas_centerY).offset(15);
    }];
    


}
-(void)clickShuJuJieMi{
    LQQchooseCollegeViewController*chooseCollegeTableViewController = [[LQQchooseCollegeViewController alloc]init];
    [self.navigationController pushViewController:chooseCollegeTableViewController animated:YES];
    
}



#pragma mark --
//代理：处理点击后的回调数据
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    //    dataModel* INeedData = [[dataModel alloc]init];
    //    NSArray<NSString*> *FoodTang = [[NSArray alloc]initWithArray:INeedData.fanTang];
    self.pageContentView.contentViewCurrentIndex = endIndex;
    //    self.title = FoodTang[endIndex];
}
//处理滑动后的回调数据
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    //    dataModel* INeedData = [[dataModel alloc]init];
    //    NSArray<NSString*> *FoodTang = [[NSArray alloc]initWithArray:INeedData.fanTang];
    self.titleView.selectIndex = endIndex;
    //    self.title = FoodTang[endIndex];
}

//hhhhhhhh

-(void)buildInfiniteRollView{
    
    
    
    
    
    
}

@end
