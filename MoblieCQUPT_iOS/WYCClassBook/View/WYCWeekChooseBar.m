//
//  WYCScrollViewBar.m
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/31.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCWeekChooseBar.h"
//#import "UIColor+Hex.h"
@interface WYCWeekChooseBar()
@property (nonatomic, strong) NSMutableArray <UIButton *> *btnArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *sliderView;

@property (nonatomic, assign) CGFloat btnWidth;
@property (nonatomic, assign) CGFloat scrollViewHeight;
@end

@implementation WYCWeekChooseBar

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array{
    self = [self initWithFrame:frame];
    if(self){
        _titleArray = array;
        [self setProperty];
        if (array.count >=_subviewCountInView) {
            _btnWidth = self.frame.size.width/_subviewCountInView;
            _scrollViewHeight = self.frame.size.height;
            
        }
        else{
            _btnWidth = self.frame.size.width/array.count;
            _scrollViewHeight = self.frame.size.height;
            
        }
        
        [self buildView];
        [self addBtn];
    }
    return self;
}
//设置属性，如果没有指定属性的值，则使用默认属性
- (void)setProperty{
    _index = 0;
    [self initializeSubviewCountInView];
    [self initializeBackgroundColor];
    [self initializeTitleFont];
    [self initializeTitleColor];
    [self initializeSelectedTitleColor];
}
//添加scrollView
-(void)buildView{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.contentSize = CGSizeMake(_btnWidth*_titleArray.count, _scrollViewHeight);
    _scrollView.backgroundColor = _backgroundColor;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, _scrollViewHeight-2, _btnWidth, 2)];
    _sliderView.backgroundColor = _selectedTitleColor;
    [_scrollView addSubview:_sliderView];
    [self addSubview:_scrollView];
}
//添加按钮
-(void)addBtn{
    for (int i = 0 ; i < _titleArray.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*_btnWidth, 0, _btnWidth, _scrollViewHeight)];
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
        [btn setTitleColor:_selectedTitleColor forState:UIControlStateSelected];
        btn.tag = i;
        btn.titleLabel.font = _font;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_btnArray addObject:btn];
        [_scrollView addSubview:btn];
    }
}
//按钮点击事件
-(void)clickBtn:(UIButton *)sender{
    
    if (sender.tag != _index) {
        
        _index = sender.tag;
        //NSLog(@"index:%ld",_index);
        [self updateScrollView];
        
    }
    
}
-(void)changeIndex:(NSInteger)index{
    _index = index;
    [self updateScrollView];
}
-(void)updateScrollView{
    CGFloat offSetX = (_index - (_subviewCountInView/2))*_btnWidth;
    //offSetX = (_index - (_subviewCountInView/2))*_btnWidth;
    if (   (_index - (_subviewCountInView/2))*_btnWidth < 0) {
        offSetX = 0;
    }
    if(  (_index + (_subviewCountInView/2))*_btnWidth >= _scrollView.contentSize.width){
        
        offSetX = _scrollView.contentSize.width - _subviewCountInView*_btnWidth;
    }
    [_scrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    [UIView animateWithDuration:0.2f animations:^{
        self->_sliderView.frame = CGRectMake(self->_index * self->_btnWidth, self->_scrollViewHeight - 2, self->_btnWidth, 2);
    } completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScrollViewBarChanged" object:nil];
    
}

//初始化属性方法
-(void)initializeSubviewCountInView{
    if (!_subviewCountInView) {
        _subviewCountInView = 5;
    }
}
-(void)initializeTitleFont{
    if (!_font) {
        _font = [UIFont systemFontOfSize:12];
        
    }
}
-(void)initializeTitleColor{
    if (!_titleColor) {
        _titleColor = [UIColor colorWithHexString:@"#999999"];
    }
}
-(void)initializeSelectedTitleColor{
    if (!_selectedTitleColor) {
        _selectedTitleColor = [UIColor colorWithHexString:@"#7196FA"];
    }
    
}
-(void)initializeBackgroundColor{
    if (!_backgroundColor) {
        _backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    
}


@end
