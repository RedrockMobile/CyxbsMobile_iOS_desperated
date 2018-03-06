//
//  SegmentView.m
//  GGSgmentView
//
//  Created by GQuEen on 16/8/7.
//  Copyright © 2016年 GegeChen. All rights reserved.
//
#import "SegmentView.h"
@interface SegmentView()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray <UIButton *> *btnArray;
@property (nonatomic, copy) NSArray <UIViewController *> *controllers;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat titleBtnWidth;
@end

@implementation SegmentView
- (instancetype)initWithFrame:(CGRect)frame andControllers:(NSArray <UIViewController *> *)controllers{
    self = [self initWithFrame:frame];
    if(self){
        self.controllers = controllers;
        if (controllers.count >=4) {
            self.titleBtnWidth = self.width/4;
        }
        else{
            self.titleBtnWidth = self.width/controllers.count;
        }
        [self setupState];
        [self setupTitleView];
        [self setupMainView];
    }
    return self;
}

- (void)setupState{
    _btnArray = [NSMutableArray<UIButton *> array];
    _currentIndex = 0;
    _titleViewHeight = kSegmentViewTitleHeight;
    _titleColor = [UIColor blackColor];
    _selectedTitleColor = MAIN_COLOR;
    _font = [UIFont systemFontOfSize:15];
}

- (void)setupTitleView{
    _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, _titleViewHeight)];
    _titleScrollView.contentSize = CGSizeMake(_titleBtnWidth * _controllers.count,_titleViewHeight);
    _titleScrollView.bounces = NO;
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.showsVerticalScrollIndicator = NO;
//    [_titleScrollView flashScrollIndicators];
    
    UIView *cuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, _titleViewHeight-1, _titleScrollView.contentSize.width, 1)];
    cuttingLine.backgroundColor = [UIColor colorWithRed:226/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    
    for (int i = 0; i < _controllers.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*_titleBtnWidth, 0, _titleBtnWidth, _titleViewHeight);
        btn.tag = i;
        btn.titleLabel.font = _font;
        [btn setTitle:_controllers[i].title forState:UIControlStateNormal];
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
        [btn setTitleColor:_selectedTitleColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_titleScrollView addSubview:btn];
        [_btnArray addObject:btn];
    }
    [_btnArray firstObject].selected = YES;
    
    _sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, _titleViewHeight-2, _titleBtnWidth, 2)];
    _sliderView.backgroundColor = _selectedTitleColor;
    
    [_titleScrollView addSubview:cuttingLine];
    [_titleScrollView addSubview:_sliderView];
    [self addSubview:_titleScrollView];
}

- (void)setupMainView {
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _titleViewHeight, self.width, self.height-_titleViewHeight)];
    _mainScrollView.contentSize = CGSizeMake(_controllers.count*self.width, 0);

    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    
    for (int i = 0; i < _controllers.count; i++) {
        UIView *view = self.controllers[i].view;
        view.frame = CGRectMake(i * self.width, 0, self.width, self.height-_titleViewHeight);
        [_mainScrollView addSubview:view];
    }
    [self addSubview:_mainScrollView];
}

- (void)clickBtn:(UIButton *)sender {
    if (sender.tag != _currentIndex) {
        [_mainScrollView setContentOffset:CGPointMake(sender.tag * self.width, 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentIndex = round(_mainScrollView.contentOffset.x / self.width);
    if (currentIndex != _currentIndex) {
        _btnArray[_currentIndex].selected = NO;
        _currentIndex = currentIndex;
        _btnArray[_currentIndex].selected = YES;
        [UIView animateWithDuration:0.2f animations:^{
            _sliderView.frame = CGRectMake(currentIndex * _titleBtnWidth, _titleViewHeight - 2, _titleBtnWidth, 2);
            if (_btnArray[currentIndex].frame.origin.x < self.width/2) {
                [_titleScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                //在屏幕中线左边的情况
            } else if (_titleScrollView.contentSize.width - _btnArray[currentIndex].frame.origin.x <= self.width/2) {
                [_titleScrollView setContentOffset:CGPointMake(_controllers.count*_titleBtnWidth-self.width, 0) animated:YES];
                //在最右边的情况
            } else {
                [_titleScrollView setContentOffset:CGPointMake(_btnArray[currentIndex].frame.origin.x-self.width/2+_titleBtnWidth/2, 0) animated:YES];
                //在中间的情况
            }
        } completion:nil];
        if ([self.eventDelegate respondsToSelector:@selector(eventWhenScrollSubViewWithIndex:)]) {
            [self.eventDelegate eventWhenScrollSubViewWithIndex:currentIndex];
        }
    }
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    for (UIButton * btn in _btnArray) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    _selectedTitleColor = selectedTitleColor;
    for (UIButton * btn in _btnArray) {
        [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    _sliderView.backgroundColor = selectedTitleColor;
}

- (void)setFont:(UIFont *)font{
    _font = font;
    for (UIButton * btn in _btnArray) {
        btn.titleLabel.font = font;
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
