//
//  LQQshuJuJieMiViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/8.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "LQQshuJuJieMiViewController.h"
#import "LQQsubjectDataView.h"
#import "LQQpercentageOfStudent.h"
#import "LQQDataModel.h"
#import "ChildViewController.h"
#import "FSScrollContentView.h"
#import "InfiniteRollScrollView.h"
#import "DGActivityIndicatorView.h"

@interface LQQshuJuJieMiViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property(nonatomic,strong)LQQDataModel*INeedData;
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property(nonatomic,strong) NSArray*currentSecondList;//当前的二级目录标题
@property(nonatomic,strong)NSMutableArray<ChildViewController*> *childVCs;
@property int x;

@end

@implementation LQQshuJuJieMiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//先拿到模型中获取的数据
    
    _INeedData = [LQQDataModel sharedSingleton];

    [self buildMyNavigationbar];
    self.navigationController.navigationBar.topItem.title = @"";
    _currentSecondList = _INeedData.shuJuJieMi;
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.view.height*60.0/1334) titles:_currentSecondList delegate:self indicatorType:FSIndicatorTypeEqualTitle];
       self.titleView.selectIndex = 0;
  [self.view addSubview:_titleView];
    _titleView.backgroundColor = [UIColor colorWithRed:246/255.0 green:253/255.0 blue:255/255.0 alpha:1];

    self.pageContentView.contentViewCurrentIndex = 0;
    _titleView.titleNormalColor = [UIColor colorWithRed:122/255.0 green:118/255.0 blue:127/255.0 alpha:0.8];
    _titleView.titleSelectColor = [UIColor colorWithRed:11/255.0 green:18/255.0 blue:16/255.0 alpha:0.9];
    _titleView.indicatorColor = _titleView.titleSelectColor;
    
    
    
//    加载数据时的动画
//    UIView*shadowView = [[UIView alloc]initWithFrame:self.view.frame];
//    shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    [self.view addSubview:shadowView];
//    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeLineScalePulseOutRapid tintColor:[UIColor blueColor]size:80.0f];
//
//    activityIndicatorView.frame = CGRectMake(self.view.width/2.0-50, self.view.height/2.0-100,100,100);
//
//    [shadowView addSubview:activityIndicatorView];
//    [activityIndicatorView startAnimating];
//
//
     [self buildSubjectDataView];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadNanNvBiLi) name:@"biliDataOK" object:nil];
    
    
}
- (void)buildMyNavigationbar{

    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"数据揭秘";
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
-(void)buildSubjectDataView{
    LQQsubjectDataView*znkm = [[LQQsubjectDataView alloc]initWithDictionary:_INeedData.subject];

    LQQpercentageOfStudent*nanNvBiLi = [[LQQpercentageOfStudent alloc]initWithArray:_INeedData.biLi userXueYuan:_userXueYuan];
//    NSLog(@"LQLQ,%@",_INeedData.biLi);
    
        _childVCs = [[NSMutableArray alloc]init];//此数组用来放每一个view
    [_pageContentView removeFromSuperview];
    
    [_titleView removeFromSuperview];
    _currentSecondList = _INeedData.shuJuJieMi;
    _titleView.titlesArr = _INeedData.shuJuJieMi;
    [self.view addSubview:_titleView];
    
    
    for (NSString *title in _INeedData.shuJuJieMi) {
        ChildViewController *vc = [[ChildViewController alloc]init];
                vc.title = title;
        vc.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        [_childVCs addObject:vc];
    }
    [_childVCs[0].backgroundView addSubview:znkm];
    [_childVCs[1].backgroundView addSubview:nanNvBiLi];
    //    childVCs[0].view.backgroundColor = [UIColor redColor];
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,100, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 90) childVCs:_childVCs parentVC:self delegate:self];//把ChildVCs数组中的界面展示在pageContentview上
    [self.view addSubview:_pageContentView];
    [self.pageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_width).multipliedBy(656.0/750);
        make.centerX.equalTo(self.view);
        //        make.centerY.equalTo(self.view.mas_centerY).offset(15);
        make.top.equalTo(_titleView.mas_bottom);
        
    }];

    [znkm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_childVCs[0].backgroundView).multipliedBy(0.85);
        make.height.equalTo(_childVCs[0].backgroundView).multipliedBy(0.85);
        make.top.equalTo(_childVCs[0].backgroundView).offset(30);
        make.centerX.equalTo(_childVCs[0].backgroundView);
        
    }];
    [nanNvBiLi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_childVCs[1].backgroundView).multipliedBy(0.85);
        make.height.equalTo(_childVCs[1].backgroundView).multipliedBy(0.85);
        make.top.equalTo(_childVCs[1].backgroundView).offset(30);
        make.centerX.equalTo(_childVCs[1].backgroundView);
        
    }];
}
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{

    self.pageContentView.contentViewCurrentIndex = endIndex;

}
//处理滑动后的回调数据
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{

    self.titleView.selectIndex = endIndex;
    if(startIndex!=0){
//        [_childVCs[endIndex].backgroundView removeAllSubviews];
        
    }
}
-(void)downLoadNanNvBiLi{
         [self buildSubjectDataView];

}

@end
