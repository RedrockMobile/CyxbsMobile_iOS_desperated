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
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) NSMutableArray <UIButton *> *btnArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, assign) NSInteger titleCount;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *sliderView;

@property (nonatomic, assign) CGFloat btnWidth;
@property (nonatomic, assign) CGFloat scrollViewHeight;
@end

@implementation WYCWeekChooseBar

-(instancetype)initWithFrame:(CGRect)frame nowWeek:(NSNumber *)nowWeek{
    self = [self initWithFrame:frame];
    if(self){
        NSMutableArray *titleArray = [@[@"整学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周",@"第十九周",@"第二十周",@"第二十一周",@"第二十二周",@"第二十三周",@"第二十四周",@"第二十五周"] mutableCopy];
        
        titleArray[nowWeek.integerValue] = @"本周";
        self.titleArray = titleArray;
        self.titleCount = titleArray.count;
        
        [self setProperty];
        if (self.titleArray.count >=5) {
            _btnWidth = self.frame.size.width/5;
            _scrollViewHeight = self.frame.size.height;
            
        }
        else{
            _btnWidth = self.frame.size.width/self.titleCount;
            _scrollViewHeight = self.frame.size.height;
            
        }
        
        [self setupScrollView];
        [self addBtn];
    }
    return self;
}
//设置属性
- (void)setProperty{
    _index = 0;
    _backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    _selectedTitleColor = [UIColor colorWithHexString:@"#7196FA"];
     _titleColor = [UIColor colorWithHexString:@"#999999"];
    _font = [UIFont systemFontOfSize:12];
}
//添加scrollView
-(void)setupScrollView{
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
    CGFloat offSetX = (_index - (5/2))*_btnWidth;
    //offSetX = (_index - (_subviewCountInView/2))*_btnWidth;
    if (   (_index - (5/2))*_btnWidth < 0) {
        offSetX = 0;
    }
    if(  (_index + (5/2))*_btnWidth >= _scrollView.contentSize.width){
        
        offSetX = _scrollView.contentSize.width - 5*_btnWidth;
    }
    [_scrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    [UIView animateWithDuration:0.2f animations:^{
        self->_sliderView.frame = CGRectMake(self->_index * self->_btnWidth, self->_scrollViewHeight - 2, self->_btnWidth, 2);
    } completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScrollViewBarChanged" object:nil];
    
}



@end
