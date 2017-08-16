//
//  BigView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/10.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "BigView.h"
#import "PrefixHeader.pch"
@implementation BigView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self initTap];
    }
    return self;
}
- (void)initTap{
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBig)];
  

    [self addGestureRecognizer:recognizer];
}
-(void)tapBig{
    [self creactView];
    
    [UIImageView animateWithDuration:0.2 animations:^{
        _imagesView.frame = CGRectMake(0, ScreenHeight / 2 - 100, SCREENWIDTH, 200);
        _imagesView.width = _scrollView.width;
        _scrollView.backgroundColor = [UIColor whiteColor];

    }];
}
-(void)creactView{
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.window addSubview:_scrollView];
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    _imagesView = [[UIImageView alloc] initWithFrame:frame];
    _imagesView.contentMode = UIViewContentModeScaleAspectFill;
    _imagesView.image = self.image;
    
    _imagesView.userInteractionEnabled = YES;
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smallTap)];
    [_scrollView addGestureRecognizer:tap];
    [_scrollView addSubview:_imagesView];
}
- (void)smallTap{
    
    [UIView animateWithDuration:.3 animations:^{
        
        _imagesView.frame = self.frame;
        
    } completion:^(BOOL finished) {
        self.hidden = NO;
        [_scrollView removeFromSuperview];
        
    }];
}

@end
