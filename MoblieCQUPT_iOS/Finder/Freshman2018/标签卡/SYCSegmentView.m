//
//  SYCSegmentView.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/23.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCSegmentView.h"
#import "SYCSegmentViewButton.h"

@interface SYCSegmentView() <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray <UIButton *> *btnArray;
@property (nonatomic, copy) NSArray <UIViewController *> *controllers;
@property (nonatomic, strong) UIScrollView *mainView;
@property (nonatomic, strong) UIScrollView *titleView;
@property (nonatomic, strong) UIView *sliderLine;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat titleBtnWidth;
@property (nonatomic) CGFloat sliderWidth;
@property (nonatomic) CGFloat sliderHeight;

@end

@implementation SYCSegmentView

- (instancetype)initWithFrame:(CGRect)frame andControllers:(NSArray<UIViewController *> *)controllers andType:(SYCSegmentViewType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.controllers = controllers;
        if (type == SYCSegmentViewTypeButton) {
            if (controllers.count > 2) {
                self.titleBtnWidth = self.width / 3;
            }else{
                self.titleBtnWidth = self.width / controllers.count;
            }
        }else{
            if (controllers.count > 3) {
                self.titleBtnWidth = self.width / 4;
            }else{
                self.titleBtnWidth = self.width / controllers.count;
            }
        }
        [self initPrivate];
        [self initMainView];
        [self initTitleViewWithType:type];
    }
    return self;
}

- (void)initPrivate{
    self.btnArray = [NSMutableArray array];
    self.currentIndex = 0;
    self.titleHeight = SCREENHEIGHT * 0.06;
    self.titleColor = RGBColor(153, 153, 153, 1.0);
    self.selectedTitleColor = MAIN_COLOR;
    self.titleFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    self.segmentType = SYCSegmentViewTypeNormal;
}

- (void)initTitleViewWithType:(SYCSegmentViewType)type{
    self.titleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.titleHeight)];
    self.titleView.contentSize = CGSizeMake(self.titleBtnWidth * self.controllers.count, self.titleHeight);
    self.titleView.bounces = NO;
    self.titleView.showsVerticalScrollIndicator = NO;
    self.titleView.showsHorizontalScrollIndicator = NO;
    
    //选项卡View的边界线
    UIView *borderline = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight - 1, self.titleView.contentSize.width, 1)];
    borderline.backgroundColor = [UIColor colorWithRed:226/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    
    self.sliderWidth = self.titleBtnWidth * 0.6;
    self.sliderHeight = self.titleHeight * 0.07;
    self.sliderLine = [[UIView alloc] initWithFrame:CGRectMake((self.titleBtnWidth - self.sliderWidth) / 2.0 , self.titleHeight - self.sliderHeight, _sliderWidth, _sliderHeight)];
    self.sliderLine.layer.cornerRadius = 3.0;
    self.sliderLine.backgroundColor = self.selectedTitleColor;
    
    for (int i = 0; i < self.controllers.count; ++i) {
        if (type == SYCSegmentViewTypeNormal) {
            UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * self.titleBtnWidth, 0, self.titleBtnWidth, self.titleHeight)];
            titleBtn.tag = i;
            titleBtn.titleLabel.font = self.titleFont;
            [titleBtn setTitle:self.controllers[i].title forState:UIControlStateNormal];
            [titleBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
            [titleBtn setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
            [titleBtn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnArray addObject:titleBtn];
            [self.titleView addSubview:titleBtn];
            
            [self.titleView addSubview:self.sliderLine];
            [self.titleView addSubview:borderline];
        }else if (type == SYCSegmentViewTypeButton){
            SYCSegmentViewButton *titleBtn = [[SYCSegmentViewButton alloc] initWithFrame:CGRectMake(i * self.titleBtnWidth, 0, self.titleBtnWidth, self.titleHeight)];
            titleBtn.backgroundColor = [UIColor clearColor];
            titleBtn.title = self.controllers[i].title;

            [titleBtn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnArray addObject:titleBtn];
            [self.titleView addSubview:titleBtn];
            self.titleView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
        }
    }

    
    
    [self.btnArray firstObject].selected = YES;
    [self addSubview:self.titleView];
}

- (void)clickTitleBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        [self.mainView setContentOffset:CGPointMake(sender.tag * self.width, 0)];
    }];
}

- (void)initMainView{
    self.mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.width, self.height - self.titleHeight)];
    self.mainView.contentSize = CGSizeMake(self.width * self.controllers.count, 0);
    self.mainView.showsVerticalScrollIndicator = NO;
    self.mainView.showsHorizontalScrollIndicator = NO;
    self.mainView.pagingEnabled = YES;
    self.mainView.bounces = NO;
    self.mainView.delegate = self;
    
    for (int i = 0; i < self.controllers.count; i++) {
        UIView *view = self.controllers[i].view;
        view.frame = CGRectMake(i * self.width, 0, self.width, self.height-_titleHeight);
        [self.mainView addSubview:view];
    }
    [self addSubview:self.mainView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentIndex = round(_mainView.contentOffset.x / self.width);
    if (currentIndex != _currentIndex) {
        _btnArray[_currentIndex].selected = NO;
        _currentIndex = currentIndex;
        _btnArray[_currentIndex].selected = YES;
        
        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _sliderLine.frame = CGRectMake(currentIndex * _titleBtnWidth + (_titleBtnWidth - _sliderWidth) / 2.0, _titleHeight - _sliderHeight, _sliderWidth, _sliderHeight);
            if (_btnArray[currentIndex].frame.origin.x < self.width/2) {
                [_titleView setContentOffset:CGPointMake(0, 0) animated:YES];
                //在屏幕中线左边的情况
            } else if (_titleView.contentSize.width - _btnArray[currentIndex].frame.origin.x <= self.width/2) {
                [_titleView setContentOffset:CGPointMake(_controllers.count * _titleBtnWidth - self.width, 0) animated:YES];
                //在最右边的情况
            } else {
                [_titleView setContentOffset:CGPointMake(self.btnArray[currentIndex].frame.origin.x - self.width / 2.0 + _titleBtnWidth / 2.0, 0) animated:YES];
                //在中间的情况
            }
        } completion:nil];
        
        if ([self.eventDelegate respondsToSelector:@selector(scrollEventWithIndex:)]){
            [self.eventDelegate scrollEventWithIndex:currentIndex];
        }
    }
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    for (UIButton * btn in self.btnArray) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    _selectedTitleColor = selectedTitleColor;
    for (UIButton * btn in self.btnArray) {
        [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    _sliderLine.backgroundColor = selectedTitleColor;
}

- (void)setFont:(UIFont *)font{
    _titleFont = font;
    for (UIButton * btn in self.btnArray) {
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
