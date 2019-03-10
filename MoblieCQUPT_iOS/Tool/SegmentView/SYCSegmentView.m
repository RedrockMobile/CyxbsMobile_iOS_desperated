//
//  SYCSegmentView.m
//  SYCSegmentView
//
//  Created by 施昱丞 on 2018/8/28.
//  Copyright © 2018年 Shi Yucheng. All rights reserved.
//

//屏幕长宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//默认颜色
#define SELECTED_COLOR  [UIColor colorWithRed:84/255.0 green:172/255.0 blue:255/255.0 alpha:1]
#define TITLE_COLOR [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]

#import "SYCSegmentView.h"
#import "SYCSegmentViewButton.h"

@interface   SYCSegmentView() <UIScrollViewDelegate>

//内容视图
@property (nonatomic, copy) NSArray <UIViewController *> *controllers;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) SYCSegmentViewType type;

//滑动标签栏
@property (nonatomic, strong) NSMutableArray <UIButton *> *titleBtnArray;
@property (nonatomic, strong) UIScrollView *titleView;
@property (nonatomic) CGFloat titleBtnWidth;
@property (nonatomic, strong) UIView *sliderLinePart1;  //标题下小滑块第一部分
@property (nonatomic, strong) UIView *sliderLinePart2;  //标题下小滑块第二部分
@property (nonatomic) CGFloat sliderWidth;  //标题下小滑块宽
@property (nonatomic) CGFloat sliderHeight;  //标题下小滑块高
@property (nonatomic) CGFloat currentX;

@end


@implementation SYCSegmentView

//默认初始化方法
- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray<UIViewController *> *)controllers type:(SYCSegmentViewType)type{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        _controllers = controllers;
        if (_type == SYCSegmentViewTypeButton) {
            _titleBtnWidth = controllers.count > 2 ? SCREEN_WIDTH / 3 : SCREEN_WIDTH / controllers.count;
        }else if(_type == SYCSegmentViewTypeNormal){
            _titleBtnWidth = controllers.count > 3 ? SCREEN_WIDTH / 3 : SCREEN_WIDTH / controllers.count;
        }
        
        //默认属性
        _titleBtnArray = [NSMutableArray array];
        _currentIndex = 0;
        _titleHeight = SCREEN_HEIGHT * 0.06;
        _titleColor = TITLE_COLOR;
        _selectedTitleColor = SELECTED_COLOR;
        _titleFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
        _segmentType = SYCSegmentViewTypeNormal;
        _titleView.backgroundColor = [UIColor clearColor];
        _currentX = 0;
        
        _titleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.titleHeight)];
        _titleView.contentSize = CGSizeMake(self.titleBtnWidth * self.controllers.count, self.titleHeight);
        _titleView.bounces = NO;
        _titleView.showsVerticalScrollIndicator = NO;
        _titleView.showsHorizontalScrollIndicator = NO;
        
    }
    
    [self setUpView];
    return self;
}


- (void)setUpView{
    //加载滑动标签栏
    if (_type == SYCSegmentViewTypeNormal) {
        for (int i = 0; i < self.controllers.count; ++i) {
                //创建按钮
            UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * _titleBtnWidth, 0, _titleBtnWidth, _titleHeight)];
            titleBtn.tag = i;
            titleBtn.titleLabel.font = _titleFont;
            [titleBtn setTitle:_controllers[i].title forState:UIControlStateNormal];
            [titleBtn setTitleColor:_titleColor forState:UIControlStateNormal];
            [titleBtn setTitleColor:_selectedTitleColor forState:UIControlStateSelected];
            [_titleBtnArray addObject:titleBtn];
            [_titleView addSubview:titleBtn];
            [titleBtn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0) {
                //创建滑块
                _sliderWidth = _titleBtnWidth * 0.7;
                _sliderHeight = _titleHeight * 0.08;
                
                _sliderLinePart1 = [[UIView alloc] initWithFrame:CGRectMake((_titleBtnWidth - _sliderWidth) / 2.0 , _titleHeight - _sliderHeight, _sliderWidth, _sliderHeight)];
                _sliderLinePart1.layer.cornerRadius = 2.0;
                _sliderLinePart1.backgroundColor = _selectedTitleColor;
                [_titleView addSubview:_sliderLinePart1];
                _sliderLinePart2 = [[UIView alloc] initWithFrame:_sliderLinePart1.frame];
                _sliderLinePart2.layer.cornerRadius = 2.0;
                _sliderLinePart2.backgroundColor = _selectedTitleColor;
                [_titleView addSubview:_sliderLinePart2];
            }
        }
    }else if (_type == SYCSegmentViewTypeButton){
        for (int i = 0; i < self.controllers.count; ++i) {
            //创建按钮
            SYCSegmentViewButton *titleBtn = [[SYCSegmentViewButton alloc] initWithFrame:CGRectMake(i * _titleBtnWidth, 0, _titleBtnWidth, _titleHeight)];
            titleBtn.tag = i;
            titleBtn.title = _controllers[i].title;
            [titleBtn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
            _titleView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
            [_titleBtnArray addObject:titleBtn];
            [_titleView addSubview:titleBtn];
        }
    }
    
    [_titleBtnArray firstObject].selected = YES;
    _titleView.backgroundColor = _titleBackgroundColor;
    [self addSubview:_titleView];
    
    //加载主视图
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.titleHeight)];
    _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.controllers.count, 0);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    for (int i = 0; i < _controllers.count; i++) {
        UIView *view = _controllers[i].view;
        view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - _titleHeight);
        [_mainScrollView addSubview:view];
    }
    [self addSubview:_mainScrollView];
}


- (void)clickTitleBtn:(UIButton *)sender {
    [self.mainScrollView setContentOffset:CGPointMake(sender.tag * SCREEN_WIDTH, 0) animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentIndex = floor(_mainScrollView.contentOffset.x / SCREEN_WIDTH);
    CGFloat offSetX = scrollView.contentOffset.x; //主页面相对起始位置的位移
    CGFloat reletiveOffSetX = offSetX - _currentX; //主页面相对上一次移动后的位移
    
    //滑块第一部分的位移变化
    _sliderLinePart1.frame = CGRectMake(offSetX / SCREEN_WIDTH * _titleBtnWidth + (_titleBtnWidth - _sliderWidth) / 2.0, _titleHeight - _sliderHeight, _sliderWidth, _sliderHeight);
    //滑块第二部分的位移变化
    float part2X = 0;
    if (reletiveOffSetX >= SCREEN_WIDTH / 2.0) {
        part2X = ((reletiveOffSetX - (SCREEN_WIDTH / 2)) / (SCREEN_WIDTH / 2)) * _titleBtnWidth;
        _sliderLinePart2.frame = CGRectMake(part2X + _currentIndex * _titleBtnWidth + (_titleBtnWidth - _sliderWidth) / 2.0, _titleHeight - _sliderHeight, _sliderWidth, _sliderHeight);
    }else if(reletiveOffSetX <= -SCREEN_WIDTH / 2.0){
        part2X = -((-reletiveOffSetX - (SCREEN_WIDTH / 2)) / (SCREEN_WIDTH / 2)) * _titleBtnWidth;
        _sliderLinePart2.frame = CGRectMake(part2X + (_currentIndex + 1) * _titleBtnWidth + (_titleBtnWidth - _sliderWidth) / 2.0, _titleHeight - _sliderHeight, _sliderWidth, _sliderHeight);
    }
    
    
    if (currentIndex != _currentIndex) {
        _titleBtnArray[_currentIndex].selected = NO;
        _currentIndex = currentIndex;
        _titleBtnArray[_currentIndex].selected = YES;
        
        CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        NSArray *shapes = @[@1.1, @1.2, @1.2, @1.2, @1.1, @1];
        [scale setDuration:0.5];
        [scale setValues:shapes];
        [scale setRemovedOnCompletion:NO];
        [scale setFillMode:kCAFillModeBoth];
        [_titleBtnArray[currentIndex].layer addAnimation:scale forKey:@"transform.scale"];
        
        [UIView animateWithDuration:0.7f animations:^{
            self.titleBtnArray[currentIndex].alpha = 0.4;
            self.titleBtnArray[currentIndex].alpha = 1.0;
        }];
        
        [UIView animateWithDuration:0.25f animations:^{
            //当标题栏超出屏幕时移动标题栏
            if (self.titleBtnArray[currentIndex].frame.origin.x < SCREEN_WIDTH / 2) {
                [self.titleView setContentOffset:CGPointMake(0, 0)];
            } else if (self.titleView.contentSize.width - self.titleBtnArray[currentIndex].frame.origin.x <= SCREEN_WIDTH / 2) {
                [self.titleView setContentOffset:CGPointMake(self.controllers.count * self.titleBtnWidth - SCREEN_WIDTH, 0)];
            } else {
                [self.titleView setContentOffset:CGPointMake(self.titleBtnArray[currentIndex].frame.origin.x - SCREEN_WIDTH / 2.0 + self.titleBtnWidth / 2.0, 0)];
            }
        }];
        
        if ([_eventDelegate respondsToSelector:@selector(scrollEventWithIndex:)]){
            [self.eventDelegate scrollEventWithIndex:currentIndex];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _currentX = _mainScrollView.contentOffset.x;
    _sliderLinePart1.frame = CGRectMake(_currentIndex * _titleBtnWidth + (_titleBtnWidth - _sliderWidth) / 2.0, _titleHeight - _sliderHeight, _sliderWidth, _sliderHeight);
    _sliderLinePart2.frame = CGRectMake(_currentIndex * _titleBtnWidth + (_titleBtnWidth - _sliderWidth) / 2.0, _titleHeight - _sliderHeight, _sliderWidth, _sliderHeight);
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    for (UIButton *btn in _titleBtnArray) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    _selectedTitleColor = selectedTitleColor;
    for (UIButton *btn in _titleBtnArray) {
        [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    _sliderLinePart1.backgroundColor = selectedTitleColor;
}

- (void)setFont:(UIFont *)font{
    _titleFont = font;
    for (UIButton *btn in _titleBtnArray) {
        btn.titleLabel.font = font;
    }
}

- (void)setTitleBackgroundColor:(UIColor *)titleBackgroundColor{
    _titleBackgroundColor = titleBackgroundColor;
    self.titleView.backgroundColor = _titleBackgroundColor;
}

@end
