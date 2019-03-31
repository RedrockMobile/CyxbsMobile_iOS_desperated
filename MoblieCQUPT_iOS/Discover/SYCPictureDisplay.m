//
//  SYCPictureDisplay.m
//  SYCPictureDisplay
//
//  Created by 施昱丞 on 2018/9/20.
//  Copyright © 2018年 Shi Yucheng. All rights reserved.
//

#import "SYCPictureDisplay.h"
#import "LZCarouselModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SYCPictureDisplay() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *slider1;
@property (nonatomic, strong) UIView *slider2;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, assign) float halfGap;   // 图片间距的一半
@property (nonatomic, strong) NSArray<LZCarouselModel *> *dataArray;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger imgcount;
@property (nonatomic, assign) CGFloat offsetX;

@end

@implementation SYCPictureDisplay

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat distance = SCREENWIDTH * 0.05;
        CGFloat gap = SCREENWIDTH * 0.03;
        self.halfGap = gap / 2;
        
        //初始化ScrollView
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(distance, 0, self.frame.size.width - 2 * distance, self.frame.size.height - 20)];
        [self addSubview:self.scrollView];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.clipsToBounds = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        //单击图片手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self.scrollView addGestureRecognizer:tap];
        
        self.dataArray = data;
        self.imgcount = data.count;
        
    }
    [self addScrollView];
    return self;
}

- (void)addScrollView{
    if ([_dataArray count] == 0) {
        return;
    }
    
    //循环创建添加轮播图片, 前后各添加一张
    for (int i = 0; i < _dataArray.count + 2; i++) {
        for (UIView *underView in self.scrollView.subviews) {
            if (underView.tag == 400 + i) {
                [underView removeFromSuperview];
            }
        }
        
        UIImageView *picImageView = [[UIImageView alloc] init];
        
        picImageView.userInteractionEnabled = YES;
        picImageView.tag = 400 + i ;
        picImageView.centerY = _scrollView.centerY;
        picImageView.layer.masksToBounds = YES;
        picImageView.layer.cornerRadius = 10.0;
        picImageView.contentMode = UIViewContentModeScaleAspectFill;
        picImageView.clipsToBounds = YES;
        
        
        /**  说明
         *   1. 设置完 ScrollView的width, 那么分页的宽也为 width.
         *   2. 图片宽为a 间距为 gap, 那么 图片应该在ScrollView上居中, 距离ScrollView左右间距为halfGap.
         *   与 ScrollView的width关系为 width = halfGap + a + halfGap.
         *   3. distance : Scroll距离 底层视图View两侧距离.
         *   假设 要露出上下页内容大小为 m ,   distance = m + halfGap
         *
         *  图片位置对应关系 :
         *  0 ->  1 * halfGap ;
         *  1 ->  3 * halfGap + a ;
         *  2 ->  5 * halfGap + 2 * a ;
         *  i   -> (2 * i +1) *  halfGap + i *(width - 2 * halfGap )
         */
        CGFloat imgViewHeight = _scrollView.height * 0.8625;
        
        picImageView.frame = CGRectMake((2 * i + 1) * self.halfGap + i * (self.scrollView.frame.size.width - 2 * self.halfGap), _scrollView.height/2 - imgViewHeight/2, (self.scrollView.frame.size.width - 2 * self.halfGap), imgViewHeight);
        
        
        if (i == 0) {
            [picImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[self.imgcount - 1].picture_url]
                            placeholderImage:[UIImage imageNamed:@"cqupt1.jpg"]];
            self.index = self.imgcount - 1;
        }else if (i == self.imgcount + 1) {
            [picImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[0].picture_url]
                            placeholderImage:[UIImage imageNamed:@"cqupt2.jpg"]];
            self.index = 0;
        }else {
            [picImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[i - 1].picture_url]
                            placeholderImage:[UIImage imageNamed:@"cqupt3.jpg"]];
            self.index = i - 1;
        }
        
        [self.scrollView addSubview:picImageView];
    }
    
    //设置轮播图当前的显示区域
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * (_imgcount + 2), 0);
    [self changeImgViewFrame];
    _offsetX = _scrollView.contentOffset.x;
    
    //底部标示条
    CGFloat lineWidth = self.imgcount * 20;
    CGFloat lineHeight = 2;
    self.line = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - lineWidth) / 2, self.scrollView.size.height + 15, lineWidth, lineHeight)];
    self.line.backgroundColor = [UIColor colorWithRed:223.0 / 255.0 green:224.0 / 255.0 blue:225.0 / 255.0 alpha:1.0];
    [self addSubview:self.line];
    
    CGFloat sliderWidth = 20;
    CGFloat sliderHeight = lineHeight * 2;
    self.slider1 = [[UIView alloc] initWithFrame:CGRectMake(self.line.origin.x, self.line.origin.y - 0.5, sliderWidth, sliderHeight)];
    self.slider1.backgroundColor = MAIN_COLOR;
    self.slider1.layer.masksToBounds = YES;
    self.slider1.layer.cornerRadius = 2.0;
    [self addSubview:self.slider1];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger curIndex = (long)roundf(scrollView.contentOffset.x  / scrollView.frame.size.width);
    
    
    if (curIndex == _imgcount + 1) {
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }else if(curIndex == 0){
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * _imgcount, 0);
    }
    _index = (long)roundf(_scrollView.contentOffset.x  / _scrollView.frame.size.width);
    
    _offsetX = _scrollView.contentOffset.x ;
    [self changeImgViewFrame];
}

-(void)changeImgViewFrame{
    _index = (long)roundf(_scrollView.contentOffset.x  / _scrollView.frame.size.width);
    
    CGFloat imgViewHeight = _scrollView.height * 0.8625;
    
    for (int i = 0; i < _scrollView.subviews.count - 1; i++) {
        if (i == _index) {
            UIImageView  *imgView = _scrollView.subviews[i];
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            imgView.clipsToBounds = YES;
            [imgView setFrame:CGRectMake(imgView.frame.origin.x, 0, imgView.frame.size.width, _scrollView.height)];
        }else{
            UIImageView  *imgView = _scrollView.subviews[i];
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            imgView.clipsToBounds = YES;
            [imgView setFrame:CGRectMake(imgView.frame.origin.x, _scrollView.height/2 - imgViewHeight/2, imgView.frame.size.width, imgViewHeight)];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat moveX = _scrollView.contentOffset.x - _offsetX;
    if (moveX > 0 && moveX < SCREENWIDTH) {
        UIImageView  *imgView1 = _scrollView.subviews[_index + 1];
        imgView1.height = self.scrollView.height * 0.8625 + (moveX / SCREENWIDTH * (_scrollView.height * 0.1475) + 1.6);
        imgView1.centerY = _scrollView.centerY;
        
        UIImageView  *imgView2 = _scrollView.subviews[_index];
        imgView2.height = self.scrollView.height - (moveX / SCREENWIDTH * (_scrollView.height * 0.1475) + 1.6);
        imgView2.centerY = _scrollView.centerY;
    }else if(moveX > -SCREENWIDTH){
        UIImageView  *imgView1 = _scrollView.subviews[_index - 1];
        imgView1.height = self.scrollView.height * 0.8625 + (fabs(moveX) / SCREENWIDTH * (_scrollView.height * 0.1475) + 1.6);
        imgView1.centerY = _scrollView.centerY;
        
        UIImageView  *imgView2 = _scrollView.subviews[_index];
        imgView2.height = self.scrollView.height - (fabs(moveX) / SCREENWIDTH * (_scrollView.height * 0.1475) + 1.6);
        imgView2.centerY = _scrollView.centerY;
    }
    
    if (moveX >= -SCREENWIDTH && moveX <= SCREENWIDTH) {
        if (self.index == 1) {
            if (moveX + 0.5 < 0) {
                self.slider1.frame = CGRectMake(self.line.origin.x, self.slider1.frame.origin.y, self.line.width, self.slider1.frame.size.height);
            }else{
                self.slider1.frame = CGRectMake(self.line.origin.x, self.slider1.frame.origin.y, (self.index) * 20 + (moveX / SCREENWIDTH) * 20, self.slider1.frame.size.height);
            }
        }else if (self.index == self.imgcount){
            if (moveX - 0.5 > 0) {
                self.slider1.frame = CGRectMake(self.line.origin.x, self.slider1.frame.origin.y, 20, self.slider1.frame.size.height);
            }else{
                self.slider1.frame = CGRectMake(self.line.origin.x, self.slider1.frame.origin.y, (self.index) * 20 + (moveX / SCREENWIDTH) * 20, self.slider1.frame.size.height);
            }
        }else{
            self.slider1.frame = CGRectMake(self.line.origin.x, self.slider1.frame.origin.y, (self.index) * 20 + (moveX / SCREENWIDTH) * 20, self.slider1.frame.size.height);
        }
    }
}

//点击触发的方法
-(void)tapAction:(UITapGestureRecognizer *)tap{
    if ([_dataArray isKindOfClass:[NSArray class]] && (self.imgcount > 0)) {
        NSLog(@"%li", (long)self.index - 1);
    }else{
        self.index = -1;
    }
}

@end
