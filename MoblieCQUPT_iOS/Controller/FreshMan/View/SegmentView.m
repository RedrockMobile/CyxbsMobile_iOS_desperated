//
//  SegmentView.m
//  GGSgmentView
//
//  Created by GQuEen on 16/8/7.
//  Copyright © 2016年 GegeChen. All rights reserved.
//

#import "SegmentView.h"

#define titleHeight 50
//#define titleWidth ([UIScreen mainScreen].bounds.size.width)/4

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define MainThemeColor [UIColor colorWithRed:128/255.0 green:173 /255.0 blue:241/255.0 alpha:1]

@interface SegmentView ()<UIScrollViewDelegate>
@property (assign, nonatomic) CGFloat kTitileBtnWidth;
@property (strong, nonatomic) NSArray<UIViewController *> *subviewControllers;
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIScrollView *titleScrollView;

@property (strong, nonatomic) NSMutableArray<UIButton *> *btnArray;

@property (strong, nonatomic) UIView *sliderView;

@property (assign, nonatomic) NSInteger currentIndex;

@property (strong, nonatomic) UIButton *currentSelectBtn;

@end

@implementation SegmentView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray *)subviewControllers{
    self = [super initWithFrame:frame];
    if (self) {
        _subviewControllers = [[NSArray<UIViewController *> alloc]initWithArray:subviewControllers];
        CGFloat titleWidth = ScreenWidth/4;
        if (subviewControllers.count > 3) {
            _kTitileBtnWidth = titleWidth;
        }else {
            _kTitileBtnWidth = ScreenWidth/subviewControllers.count;
        }
        [self initWithTitleView];
        [self initWithScrollView];
//        _kTitileBtnWidth = subviewControllers.count > 3 ? titleWidth : (SCREEN_WIDTH/subviewControllers.count);
        
    }
    return self;
}

- (void)initWithTitleView {
    
    _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, titleHeight)];
    _titleScrollView.contentSize = CGSizeMake(_kTitileBtnWidth * self.subviewControllers.count, 40);
    _titleScrollView.bounces = NO;
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.showsVerticalScrollIndicator = NO;
    [_titleScrollView flashScrollIndicators];
    
    UIView *cuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, titleHeight-1, _titleScrollView.contentSize.width, 1)];
    cuttingLine.backgroundColor = [UIColor colorWithRed:226/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    
    _btnArray = [NSMutableArray<UIButton *> array];
    for (int i = 0; i < _subviewControllers.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*_kTitileBtnWidth, 0, _kTitileBtnWidth, titleHeight);
        [btn setTitle:self.subviewControllers[i].title forState:UIControlStateNormal];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            _currentSelectBtn = btn;
            btn.selected = YES;
        }
        [_titleScrollView addSubview:btn];
        [_btnArray addObject:btn];
        NSLog(@"%@ %f", _subviewControllers[i].title,_kTitileBtnWidth);
    }
    _sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, titleHeight-2, _kTitileBtnWidth, 2)];
    _sliderView.backgroundColor = MAIN_COLOR;
    
    [_titleScrollView addSubview:cuttingLine];
    [_titleScrollView addSubview:self.sliderView];
    [self addSubview:self.titleScrollView];
    NSLog(@"%@", _titleScrollView.subviews);
}

- (void)initWithScrollView {
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, titleHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64-titleHeight)];
    
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.contentSize = CGSizeMake(_subviewControllers.count*375, 0);
    
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    
    for (int i = 0; i < _subviewControllers.count; i++) {
        NSLog(@"%p", self.subviewControllers[i].view);
        UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
        view = self.subviewControllers[i].view;
        view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20-_kTitileBtnWidth);
        [_mainScrollView addSubview:view];
    }
    
    [self addSubview:self.mainScrollView];
    
}

- (void)clickBtn:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2f animations:^{
        _mainScrollView.contentOffset = CGPointMake(sender.tag * SCREEN_WIDTH, 0);
        _sliderView.frame = CGRectMake(sender.tag * _kTitileBtnWidth, titleHeight - 2, _kTitileBtnWidth, 2);
        _currentSelectBtn.selected = NO;
        _currentSelectBtn = sender;
        _currentSelectBtn.selected = YES;
        CGRect rect = [sender.superview convertRect:sender.frame toView:self];
        CGPoint contentOffset = self.titleScrollView.contentOffset;
        if (contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-_kTitileBtnWidth/2)<=0) {
            [_titleScrollView setContentOffset:CGPointMake(0, contentOffset.y) animated:YES];
        } else if (contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-_kTitileBtnWidth/2)+SCREEN_WIDTH>=self.subviewControllers.count*_kTitileBtnWidth) {
            [_titleScrollView setContentOffset:CGPointMake(self.subviewControllers.count*_kTitileBtnWidth-SCREEN_WIDTH, contentOffset.y) animated:YES];
        } else {
            [_titleScrollView setContentOffset:CGPointMake(contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-_kTitileBtnWidth/2), contentOffset.y) animated:YES];
        }

    } completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    _currentIndex = (NSInteger)(_mainScrollView.contentOffset.x / SCREEN_WIDTH + 0.5);
    if ([self.eventDelegate respondsToSelector:@selector(eventWhenScrollSubViewWithIndex:)]) {
        [self.eventDelegate eventWhenScrollSubViewWithIndex:self.currentIndex];
    }

    if (_currentIndex != self.currentSelectBtn.tag) {
        [UIView animateWithDuration:0.2f animations:^{
            _sliderView.frame = CGRectMake(self.btnArray[self.currentIndex].tag * _kTitileBtnWidth, titleHeight - 2, _kTitileBtnWidth, 2);
            _currentSelectBtn.selected = NO;
            _currentSelectBtn = self.btnArray[self.currentIndex];
            _currentSelectBtn.selected = YES;
            
            CGRect rect = [self.btnArray[self.currentIndex].superview convertRect:self.btnArray[self.currentIndex].frame toView:self];
            CGPoint contentOffset = self.titleScrollView.contentOffset;
            if (contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-_kTitileBtnWidth/2)<=0) {
                [_titleScrollView setContentOffset:CGPointMake(0, contentOffset.y) animated:YES];
            } else if (contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-_kTitileBtnWidth/2)+SCREEN_WIDTH>=self.subviewControllers.count*_kTitileBtnWidth) {
                [_titleScrollView setContentOffset:CGPointMake(self.subviewControllers.count*_kTitileBtnWidth-SCREEN_WIDTH, contentOffset.y) animated:YES];
            } else {
                [_titleScrollView setContentOffset:CGPointMake(contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-_kTitileBtnWidth/2), contentOffset.y) animated:YES];
            }
        } completion:nil];
        _currentSelectBtn = self.btnArray[self.currentIndex];
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
