//
//  IntroductionViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/25.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "IntroductionViewController.h"

#define kCount 3

@interface IntroductionViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation IntroductionViewController
-(UIScrollView *)scrollView
{
    if(_scrollView==nil){
        //初始化scrollView
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_W, MAIN_SCREEN_W/1.5)];
        _scrollView.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:_scrollView];
        //设置scrollView的相关属性
        _scrollView.contentSize=CGSizeMake(kCount*_scrollView.bounds.size.width, 0);
        _scrollView.bounces=NO;
        _scrollView.pagingEnabled=YES;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
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
        _pageControl.center=CGPointMake(self.view.center.x, 64 + MAIN_SCREEN_W/1.5 - 15);
        //相关的属性
//        _pageControl.pageIndicatorTintColor=[UIColor grayColor];
//        _pageControl.currentPageIndicatorTintColor=[UIColor blackColor];
        //添加控件
        [self.view addSubview:_pageControl];
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
-(void) viewDidLoad
{
    [super viewDidLoad];
    //设置图片
    for(int i=0;i<kCount;i++){
        NSString *imageName=[NSString stringWithFormat:@"重邮美景%d.jpg",i+1];
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
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTime];
}

@end
