//
//  WYCShowDetailView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/9/22.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "WYCShowDetailView.h"
#import "WYCClassDetailView.h"
@interface WYCShowDetailView()
@property (nonatomic, strong) UIView *rootView;
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation WYCShowDetailView


- (void)initViewWithArray:(NSArray *)array{
    
    self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    self.rootView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2 - 135, SCREENHEIGHT/2 - 170, 270, 340)];
    self.rootView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2 - 135, SCREENHEIGHT/2 - 170, 270, 340)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    WYCClassDetailView *view = [WYCClassDetailView initViewFromXib];
    [view initWithDic:array[0]];
    [self.rootView addSubview:view];
    
    
    //[self.rootView addSubview:self.scrollView];
    [self addSubview:self.rootView];
    
    
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
