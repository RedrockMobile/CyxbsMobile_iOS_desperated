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


//默认数据
#define SELECTED_COLOR  [UIColor colorWithRed:84/255.0 green:172/255.0 blue:255/255.0 alpha:1]
#define TITLE_COLOR [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]

#import "SYCSegmentView.h"
#import "SYCSegmentViewButton.h"

@interface   SYCSegmentView() <UIScrollViewDelegate>

//内容视图
@property (nonatomic, strong) NSArray <UIViewController *> *controllers;
@property (nonatomic, strong) UIScrollView *mainView;
@property (nonatomic, assign) NSInteger currentIndex;

//滑动标签栏
@property (nonatomic, strong) NSMutableArray <UIButton *> *titleBtnArray;
@property (nonatomic, strong) UIScrollView *titleView;
@property (nonatomic) CGFloat titleBtnWidth;
@property (nonatomic, strong) UIView *sliderLinePart1;   //标题下小滑块
@property (nonatomic, strong) UIView *sliderLinePart2;
@property (nonatomic) CGFloat sliderWidth;
@property (nonatomic) CGFloat sliderHeight;
@property (nonatomic) CGFloat currentX;

@end


@implementation SYCSegmentView

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray<UIViewController *> *)controllers type:(SYCSegmentViewType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.controllers = controllers;
        if (type == SYCSegmentViewTypeButton) {
            if (controllers.count > 2) {
                self.titleBtnWidth = SCREEN_WIDTH / 3;
            }else{
                self.titleBtnWidth = SCREEN_WIDTH / controllers.count;
            }
        }else if(type == SYCSegmentViewTypeNormal){
            if (controllers.count > 3) {
                self.titleBtnWidth = SCREEN_WIDTH / 3;
            }else{
                self.titleBtnWidth = SCREEN_WIDTH / controllers.count;
            }
        }
        
        //默认属性
        self.titleBtnArray = [NSMutableArray array];
        self.currentIndex = 0;
        self.titleHeight = SCREEN_HEIGHT * 0.06;
        self.titleColor = TITLE_COLOR;
        self.selectedTitleColor = SELECTED_COLOR;
        self.titleFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
        self.segmentType = SYCSegmentViewTypeNormal;
        self.titleView.backgroundColor = [UIColor clearColor];
        self.currentX = 0;
        
        [self initViewWithType:type];
    }
    return self;
}

- (void)initViewWithType:(SYCSegmentViewType)type{
    self.titleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.titleHeight)];
    self.titleView.contentSize = CGSizeMake(self.titleBtnWidth * self.controllers.count, self.titleHeight);
    self.titleView.bounces = NO;
    self.titleView.showsVerticalScrollIndicator = NO;
    self.titleView.showsHorizontalScrollIndicator = NO;

    //加载滑动标签栏
    for (int i = 0; i < self.controllers.count; ++i) {
        if (type == SYCSegmentViewTypeNormal) {
            //创建按钮
            UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * self.titleBtnWidth, 0, self.titleBtnWidth, self.titleHeight)];
            titleBtn.tag = i;
            titleBtn.titleLabel.font = self.titleFont;
            [titleBtn setTitle:self.controllers[i].title forState:UIControlStateNormal];
            [titleBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
            [titleBtn setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
            [self.titleBtnArray addObject:titleBtn];
            [self.titleView addSubview:titleBtn];
            [titleBtn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0) {
                //创建滑块
                self.sliderWidth = self.titleBtnWidth * 0.7;
                self.sliderHeight = self.titleHeight * 0.08;
                self.sliderLinePart1 = [[UIView alloc] initWithFrame:CGRectMake((self.titleBtnWidth - self.sliderWidth) / 2.0 , self.titleHeight - self.sliderHeight, self.sliderWidth, self.sliderHeight)];
                self.sliderLinePart1.layer.cornerRadius = 2.0;
                self.sliderLinePart1.backgroundColor = self.selectedTitleColor;
                [self.titleView addSubview:self.sliderLinePart1];
                
                self.sliderLinePart2 = [[UIView alloc] initWithFrame:CGRectMake((self.titleBtnWidth - self.sliderWidth) / 2.0 , self.titleHeight - self.sliderHeight, self.sliderWidth, self.sliderHeight)];
                self.sliderLinePart2.layer.cornerRadius = 2.0;
                self.sliderLinePart2.backgroundColor = self.selectedTitleColor;
//                [self.titleView addSubview:self.sliderLinePart2];
                
            }
        }else if (type == SYCSegmentViewTypeButton){
            //创建按钮
            SYCSegmentViewButton *titleBtn = [[SYCSegmentViewButton alloc] initWithFrame:CGRectMake(i * self.titleBtnWidth, 0, self.titleBtnWidth, self.titleHeight)];
            titleBtn.tag = i;
            titleBtn.title = self.controllers[i].title;
            [titleBtn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
            self.titleView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
            [self.titleBtnArray addObject:titleBtn];
            [self.titleView addSubview:titleBtn];
        }
    }
    [self.titleBtnArray firstObject].selected = YES;
    self.titleView.backgroundColor = self.titleBackgroundColor;
    [self addSubview:self.titleView];
    
    //加载主视图
    self.mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.titleHeight)];
    self.mainView.contentSize = CGSizeMake(SCREEN_WIDTH * self.controllers.count, 0);
    self.mainView.showsVerticalScrollIndicator = NO;
    self.mainView.showsHorizontalScrollIndicator = NO;
    self.mainView.pagingEnabled = YES;
    self.mainView.bounces = NO;
    self.mainView.delegate = self;
    for (int i = 0; i < self.controllers.count; i++) {
        UIView *view = self.controllers[i].view;
        view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - _titleHeight);
        [self.mainView addSubview:view];
    }
    [self addSubview:self.mainView];
}

- (void)clickTitleBtn:(UIButton *)sender {
    [self.mainView setContentOffset:CGPointMake(sender.tag * SCREEN_WIDTH, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger currentIndex = floor(_mainView.contentOffset.x / SCREEN_WIDTH);
    
    CGFloat offSetX = scrollView.contentOffset.x; //主页面相对起始位置的位移
    CGFloat reletiveOffSetX = offSetX - self.currentX; //主页面相对上一次移动后的位移
    
    
    
    self.sliderLinePart1.frame = CGRectMake(offSetX / SCREEN_WIDTH * self.titleBtnWidth + (self.titleBtnWidth - self.sliderWidth) / 2.0, self.titleHeight - self.sliderHeight, self.sliderWidth, self.sliderHeight);
//    if (reletiveOffSetX >= SCREEN_WIDTH / 2.0) {
//        self.sliderLinePart2.frame = CGRectMake(currentIndex * self.titleBtnWidth + ((self.titleBtnWidth - self.sliderWidth) / 2.0) + ((fabs(reletiveOffSetX) - (SCREEN_WIDTH / 2.0)) / SCREEN_WIDTH / 2.0) * self.titleBtnWidth, self.titleHeight - self.sliderHeight, self.sliderWidth, self.sliderHeight);
//        NSLog(@"%f", (fabs(reletiveOffSetX) - (SCREEN_WIDTH / 2.0)));
//    }else if (reletiveOffSetX <= -SCREEN_WIDTH / 2.0){
//        self.sliderLinePart2.frame = CGRectMake((self.titleBtnWidth - self.sliderWidth) / 2.0 - (reletiveOffSetX - SCREEN_WIDTH / 2.0) / (SCREEN_WIDTH / 2.0) * self.titleBtnWidth, self.titleHeight - self.sliderHeight, self.sliderWidth, self.sliderHeight);
//    }
    
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
        [self.titleBtnArray[currentIndex].layer addAnimation:scale forKey:@"transform.scale"];
        
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
        
        if ([self.eventDelegate respondsToSelector:@selector(scrollEventWithIndex:)]){
            [self.eventDelegate scrollEventWithIndex:currentIndex];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%f", self.mainView.contentOffset.x);
    self.currentX = self.mainView.contentOffset.x;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    for (UIButton *btn in self.titleBtnArray) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    _selectedTitleColor = selectedTitleColor;
    for (UIButton *btn in self.titleBtnArray) {
        [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    _sliderLinePart1.backgroundColor = selectedTitleColor;
}

- (void)setFont:(UIFont *)font{
    _titleFont = font;
    for (UIButton *btn in self.titleBtnArray) {
        btn.titleLabel.font = font;
    }
}

- (void)setTitleBackgroundColor:(UIColor *)titleBackgroundColor{
    _titleBackgroundColor = titleBackgroundColor;
    self.titleView.backgroundColor = _titleBackgroundColor;
}

@end
