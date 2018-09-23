//
//  WYCShowDetailView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/9/22.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "WYCShowDetailView.h"
#import "WYCClassDetailView.h"
#import "DLChooseClassListViewController.h"
@interface WYCShowDetailView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *rootView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *array;

@end

@implementation WYCShowDetailView


- (void)initViewWithArray:(NSArray *)array{
    _index = 0;
    self.array = array;
    self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    self.rootView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2 - 135, SCREENHEIGHT/2 - 170, 270, 360)];
    self.rootView.backgroundColor = [UIColor whiteColor];
    [self.rootView layoutIfNeeded];
    
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.rootView.width,self.rootView.height)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(array.count*self.rootView.width, self.rootView.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < array.count; i++) {
        WYCClassDetailView *view = [WYCClassDetailView initViewFromXib];
        [view initWithDic:array[i]];
        [view setFrame:CGRectMake(i*self.rootView.width, 0,self.rootView.width,self.rootView.height)];
        view.chooseClassList.tag = i;
        [view.chooseClassList addTarget:self action:@selector(chooseClassList:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:view];
    }
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.rootView.height - 30, self.rootView.width, 30)];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = array.count;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#5599FF"];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#C4C4C4"];
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rootView addSubview:self.scrollView];
    [self.rootView addSubview:self.pageControl];
    [self addSubview:self.rootView];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"showChooseClassList" object:nil];
    
}
-(void)chooseClassList:(UIButton *)sender{
    NSString *classNum = [self.array[sender.tag] objectForKey:@"course_num"];
    NSLog(@"clickStuList,tag:%ld",sender.tag);
    NSLog(@"clickStuList:%@",classNum);
    
    DLChooseClassListViewController *vc = [[DLChooseClassListViewController alloc]init];
    [vc initWithClassNum:classNum];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _index = self.scrollView.contentOffset.x/self.rootView.width;
    self.pageControl.currentPage = _index;
    NSLog(@"index:%ld",_index);
}

-(void)changePage:(id)sender{
    NSInteger i = _pageControl.currentPage;
    [_scrollView setContentOffset:CGPointMake(i*self.rootView.width, 0) animated:YES];
}

@end
