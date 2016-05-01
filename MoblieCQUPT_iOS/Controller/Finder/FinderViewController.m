//
//  FinderViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/25.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "FinderViewController.h"
#import "ShopViewController.h"
#import "WebViewController.h"
#import "ChuangyeViewController.h"
#import "ShakeViewController.h"
#import "CommunityViewController.h"
#import "MapViewController.h"

#define kCount 3

@interface FinderViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) UIView *buttonsView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;


@property (weak, nonatomic) IBOutlet UIButton *redrockBtn;
@property (weak, nonatomic) IBOutlet UIButton *mapBtn;
@property (weak, nonatomic) IBOutlet UIButton *shakeForShopBtn;
@property (weak, nonatomic) IBOutlet UIButton *communityBtn;
@property (weak, nonatomic) IBOutlet UIButton *chuangyeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;

@property (weak, nonatomic) IBOutlet UIView *redrockView;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UIView *shakeForShopView;
@property (weak, nonatomic) IBOutlet UIView *communityView;
@property (weak, nonatomic) IBOutlet UIView *chuangyeView;
@property (weak, nonatomic) IBOutlet UIView *shopView;
@property (weak, nonatomic) IBOutlet UIView *shopOfView;
@property (weak, nonatomic) IBOutlet UIView *chuangyeOfView;
@property (weak, nonatomic) IBOutlet UIView *communityOfView;
@property (weak, nonatomic) IBOutlet UIView *shakeForShopOfView;
@property (weak, nonatomic) IBOutlet UIView *mapOfView;
@property (weak, nonatomic) IBOutlet UIView *redrockOfView;

@end

@implementation FinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
    _mainScrollView.showsVerticalScrollIndicator = NO;
    if (MAIN_SCREEN_W == 320 && MAIN_SCREEN_H == 480) {
        _mainScrollView.contentSize = CGSizeMake(MAIN_SCREEN_W, MAIN_SCREEN_H*1.2);
    }else{
        _mainScrollView.contentSize = CGSizeMake(MAIN_SCREEN_W, MAIN_SCREEN_H);
    }
    [self.view addSubview:_mainScrollView];
    
    //图片轮播
    self.automaticallyAdjustsScrollViewInsets = NO;//防止出现20或64的下移
    self.view.backgroundColor = [UIColor whiteColor];

    
    //设置图片
    for(int i=0;i<kCount;i++){
        NSString *imageName=[NSString stringWithFormat:@"cqupt%d.jpg",i+1];
        UIImage *image=[UIImage imageNamed:imageName];
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        imageView.image=image;
        [self.scrollView addSubview:imageView];
    }
    //设置每个imageView的位置
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        CGRect frame=imageView.frame;
        frame.origin.x=idx*frame.size.width;
        imageView.frame=frame;
    }];
    
    self.pageControl.currentPage=0;
    //时钟开始
    [self startTime];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
    _buttonsView = [nib objectAtIndex:0];
    _buttonsView.frame = CGRectMake(0, _scrollView.frame.size.height+64 , MAIN_SCREEN_W, MAIN_SCREEN_W/3*2);
    [self.mainScrollView addSubview:_buttonsView];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_W/3, 0, 1, _buttonsView.frame.size.height)];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_W/3*2, 0, 1, _buttonsView.frame.size.height)];
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, _buttonsView.frame.size.height/2, MAIN_SCREEN_W, 1)];
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, _buttonsView.frame.size.height, MAIN_SCREEN_W, 1)];
    
    line1.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    line2.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    line3.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    line4.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    [_buttonsView addSubview:line1];
    [_buttonsView addSubview:line2];
    [_buttonsView addSubview:line3];
    [_buttonsView addSubview:line4];
    
    [_shopBtn addTarget:self
                 action:@selector(enterShop)
       forControlEvents:UIControlEventTouchUpInside];
    [_shopBtn addTarget:self
                 action:@selector(enterShop)
       forControlEvents:UIControlEventTouchUpOutside];
    [_shopBtn addTarget:self
                 action:@selector(clickShop)
       forControlEvents:UIControlEventTouchDown];
    
    [_redrockBtn addTarget:self
                    action:@selector(enterWeb)
          forControlEvents:UIControlEventTouchUpInside];
    [_redrockBtn addTarget:self
                    action:@selector(enterWeb)
          forControlEvents:UIControlEventTouchUpOutside];
    [_redrockBtn addTarget:self
                    action:@selector(clickRedrock)
          forControlEvents:UIControlEventTouchDown];
    
    [_chuangyeBtn addTarget:self
                     action:@selector(enterIntroduction)
           forControlEvents:UIControlEventTouchUpInside];
    [_chuangyeBtn addTarget:self
                     action:@selector(enterIntroduction)
           forControlEvents:UIControlEventTouchUpOutside];
    [_chuangyeBtn addTarget:self
                     action:@selector(clickChuangye)
           forControlEvents:UIControlEventTouchDown];
    
    [_mapBtn addTarget:self
                action:@selector(enterMap)
      forControlEvents:UIControlEventTouchUpInside];
    [_mapBtn addTarget:self
                action:@selector(enterMap)
      forControlEvents:UIControlEventTouchUpOutside];
    [_mapBtn addTarget:self
                action:@selector(clickMap)
      forControlEvents:UIControlEventTouchDown];
    
    [_shakeForShopBtn addTarget:self
                         action:@selector(enterShake)
               forControlEvents:UIControlEventTouchUpInside];
    [_shakeForShopBtn addTarget:self
                         action:@selector(enterShake)
               forControlEvents:UIControlEventTouchUpOutside];
    [_shakeForShopBtn addTarget:self
                         action:@selector(clickShake)
               forControlEvents:UIControlEventTouchDown];
    
    [_communityBtn addTarget:self
                      action:@selector(enterCommunity)
            forControlEvents:UIControlEventTouchUpInside];
    [_communityBtn addTarget:self
                      action:@selector(enterCommunity)
            forControlEvents:UIControlEventTouchUpOutside];
    [_communityBtn addTarget:self
                      action:@selector(clickCommunity)
            forControlEvents:UIControlEventTouchDown];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)enterShop{
    ShopViewController *svc = [[ShopViewController alloc] init];
    [self.navigationController pushViewController:svc
                                         animated:YES];
    _shopView.backgroundColor = [UIColor clearColor];
    _shopOfView.backgroundColor = [UIColor clearColor];
}
- (void)clickShop {
    _shopView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _shopOfView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

- (void)enterWeb{
    WebViewController *wvc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    [self.navigationController pushViewController:wvc
                                         animated:YES];
    _redrockView.backgroundColor = [UIColor clearColor];
    _redrockOfView.backgroundColor = [UIColor clearColor];
}

- (void)clickRedrock {
    _redrockView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _redrockOfView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

- (void)enterIntroduction{
    ChuangyeViewController *cvc = [[ChuangyeViewController alloc] init];
    [self.navigationController pushViewController:cvc
                                         animated:YES];
    _chuangyeView.backgroundColor = [UIColor clearColor];
    _chuangyeOfView.backgroundColor = [UIColor clearColor];
}

- (void)clickChuangye {
    _chuangyeView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _chuangyeOfView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

- (void)enterMap{
    MapViewController *mvc = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mvc
                                         animated:YES];
    _mapView.backgroundColor = [UIColor clearColor];
    _mapOfView.backgroundColor = [UIColor clearColor];
}

- (void)clickMap {
    _mapView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _mapOfView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

- (void)enterShake{
    ShakeViewController *svc = [[ShakeViewController alloc] init];
    [self.navigationController pushViewController:svc
                                         animated:YES];
    _shakeForShopView.backgroundColor = [UIColor clearColor];
    _shakeForShopOfView.backgroundColor = [UIColor clearColor];
}

- (void)clickShake {
    _shakeForShopView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _shakeForShopOfView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

- (void)enterCommunity{
    CommunityViewController *cvc = [[CommunityViewController alloc] init];
    [self.navigationController pushViewController:cvc
                                         animated:YES];
    _communityView.backgroundColor = [UIColor clearColor];
    _communityOfView.backgroundColor = [UIColor clearColor];
}

- (void)clickCommunity {
    _communityView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _communityOfView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

#pragma mark - 图片轮播
-(UIScrollView *)scrollView
{
    if(_scrollView==nil){
        //初始化scrollView
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_W, MAIN_SCREEN_W*0.56)];
        _scrollView.backgroundColor=[UIColor clearColor];
        [self.mainScrollView addSubview:_scrollView];
        //设置scrollView的相关属性
        _scrollView.contentSize=CGSizeMake(kCount*_scrollView.bounds.size.width, 0);
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        //添加代理方法
        _scrollView.delegate=self;
    }
    return _scrollView;
}
-(UIPageControl *)pageControl
{
    if(_pageControl==nil){
        _pageControl=[[UIPageControl alloc] init];
        //分页数
        _pageControl.numberOfPages=kCount;
        //控件的尺寸
        CGSize size=[_pageControl sizeForNumberOfPages:kCount];
        _pageControl.bounds=CGRectMake(0, 0, size.width, size.height);
        _pageControl.center=CGPointMake(MAIN_SCREEN_W - 50,  MAIN_SCREEN_W/1.4 - 10);
        //相关的属性
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:25/255.0 green:170/255.0 blue:254/255.0 alpha:1];
        //添加控件
        [self.mainScrollView addSubview:_pageControl];
        //添加事件
        [_pageControl addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}
-(void) valueChange:(UIPageControl *)page
{
    CGFloat x=page.currentPage*self.scrollView.bounds.size.width;
    [_scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

-(void) startTime
{
    self.timer=[NSTimer timerWithTimeInterval:2.5 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    //添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
//时钟所需要做的事情
-(void) updateTime
{
    int page=(self.pageControl.currentPage+1)%kCount;
    self.pageControl.currentPage=page;
    [self valueChange:self.pageControl];
}
//拖拽的时候时钟停止
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}


//停止拖拽的时候时钟开始
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self startTime];
    int distance = _scrollView.frame.size.width;
    int num = floor((_scrollView.contentOffset.x+0.5*distance)/distance);
    _pageControl.currentPage = num;
    
}

@end