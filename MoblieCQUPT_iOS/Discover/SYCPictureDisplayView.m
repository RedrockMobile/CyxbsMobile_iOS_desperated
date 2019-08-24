//
//  SYCPictureDisplay.m
//  SYCPictureDisplay
//
//  Created by 施昱丞 on 2018/9/20.
//  Copyright © 2018年 Shi Yucheng. All rights reserved.
//

#import "SYCPictureDisplayView.h"

#import <SDWebImage/UIImageView+WebCache.h>

/**  说明
 *   1. 设置完ScrollView的width, 那么分页的宽也为width.
 *   2. 图片宽为a间距为gap, 那么图片应该在ScrollView上居中, 距离ScrollView左右间距为halfGap.
 *   与 ScrollView的width关系为 width = halfGap + a + halfGap.
 *   3. distance : ScrollView距离父视图边界距离
 *   假设要露出上下页内容大小为m, m = distance - halfGap
 */
@interface SYCPictureDisplayView() <UIScrollViewDelegate>{
    CGFloat _picHeight;
    CGFloat _picWidth;
    CGFloat _picGap;
    CGFloat _picHalfGap;
    CGFloat _distance;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) NSMutableArray<UIButton *> *segmentArray;

@property (nonatomic, strong) NSArray<LZCarouselModel *> *dataArray;
@property (nonatomic, assign) NSInteger picCount;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat offsetX;

@end

@implementation SYCPictureDisplayView

- (instancetype)initWithData:(NSArray<LZCarouselModel *> *)dataArray{
    self = [super init];
    if (self) {
        _distance = SCREEN_WIDTH * 0.05;
        _picGap = SCREEN_WIDTH * 0.03;
        _picHalfGap = _picGap / 2;
        self.dataArray = dataArray;
        self.picCount = dataArray.count;
    }
    return self;
}

- (void)buildUI{
    //初始化ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_distance, 0, self.frame.size.width - 2 * _distance, self.frame.size.height)];
    [self addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    _picHeight = _scrollView.height * 0.8625;
    _picWidth = _scrollView.width - 2 * _picHalfGap;
    
        //循环创建添加轮播图片, 前后各添加一张
    for (int i = 0; i < _dataArray.count + 2; i++) {
        for (UIView *underView in self.scrollView.subviews) {
            if (underView.tag == 400 + i) {
                [underView removeFromSuperview];
            }
        }
        
        UIImageView *picImageView = [[UIImageView alloc] init];
        picImageView.userInteractionEnabled = YES;
        picImageView.tag = 400 + i;
        picImageView.centerY = _scrollView.centerY;
        picImageView.layer.masksToBounds = YES;
        picImageView.layer.cornerRadius = 15.0;
        picImageView.contentMode = UIViewContentModeScaleAspectFill;
        picImageView.clipsToBounds = YES;
        
        
        /*
         *  假如图像宽为a，两张图片之间的间距为Gap
         *  图片位置对应关系:
         *  0 -> 1 * halfGap ;
         *  1 -> 3 * halfGap + a ;
         *  2 -> 5 * halfGap + 2 * a ;
         *  i -> (2 * i + 1) * halfGap + i * a ;
         */
        picImageView.frame = CGRectMake((2 * i + 1) * _picHalfGap + i * _picWidth, (_scrollView.height - _picHeight) / 2, _picWidth, _picHeight);
        
        if (i == 0) {
            [picImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[self.picCount - 1].picture_url]
                            placeholderImage:[UIImage imageNamed:@"cqupt1.jpg"]];
            self.index = self.picCount - 1;
        }else if (i == self.picCount + 1) {
            [picImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[0].picture_url]
                            placeholderImage:[UIImage imageNamed:@"cqupt1.jpg"]];
            self.index = 0;
        }else {
            [picImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[i - 1].picture_url]
                            placeholderImage:[UIImage imageNamed:@"cqupt1.jpg"]];
            self.index = i - 1;
        }
        [_scrollView addSubview:picImageView];
    }
    
    //设置轮播图当前的显示区域
    self.scrollView.contentOffset = CGPointMake(self.scrollView.width, 0);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * (_picCount + 2), 0);
    [self changeImgViewFrame];
    _offsetX = _scrollView.contentOffset.x;
    
    //设置标签指示器
    CGFloat indicatorWidth = _scrollView.width / 2;
    CGFloat indocatorHeight = 2.5;
    CGFloat segmentWidth;
    UIButton *segment;
    _segmentArray = [[NSMutableArray alloc] initWithCapacity:_picCount];
    for (int i = 0; i < _picCount; ++i) {
        segmentWidth = indicatorWidth / _picCount;
        segment = [[UIButton alloc] initWithFrame:CGRectMake((self.width - indicatorWidth) / 2 + segmentWidth * i, _scrollView.mj_y + _scrollView.height + SCREEN_HEIGHT * 0.015, segmentWidth * 0.8, indocatorHeight)];
        segment.tag = i;
        [segment setBackgroundImage:[UIImage imageWithColor:RGBColor(224, 224, 225, 1.0)] forState:UIControlStateNormal];
        [segment setBackgroundImage:[UIImage imageWithColor:MAIN_COLOR] forState:UIControlStateSelected];
        [_segmentArray addObject:segment];
        [self addSubview:segment];
    }
    _segmentArray[0].selected = YES;
    
    //单击图片手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:tap];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger curIndex = (long)roundf(scrollView.contentOffset.x / scrollView.frame.size.width);
    
    if (curIndex == _picCount + 1) {
        _segmentArray[_picCount - 1].selected = NO;
        _segmentArray[0].selected = YES;
        scrollView.contentOffset = CGPointMake(self.scrollView.width, 0);
    }else if(curIndex == 0){
        _segmentArray[_picCount - 1].selected = YES;
        _segmentArray[0].selected = NO;
        scrollView.contentOffset = CGPointMake(self.scrollView.width * _picCount, 0);
    }else{
        for (UIButton *button in _segmentArray) {
            button.selected = NO;
        }
        _segmentArray[curIndex - 1].selected = YES;
    }
    
    _index = (long)roundf(_scrollView.contentOffset.x / _scrollView.width);
    _offsetX = _scrollView.contentOffset.x;
    [self changeImgViewFrame];
}

- (void)changeImgViewFrame{
    _index = (long)roundf(_scrollView.contentOffset.x / _scrollView.frame.size.width);
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
            [imgView setFrame:CGRectMake(imgView.frame.origin.x, _scrollView.height / 2 - _picHeight / 2, imgView.frame.size.width, _picHeight)];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat moveX = _scrollView.contentOffset.x - _offsetX;
    if (moveX > 0 && moveX < SCREEN_WIDTH) {
        UIImageView  *imgView1 = _scrollView.subviews[_index + 1];
        imgView1.height = _picHeight + (moveX / SCREEN_WIDTH * (_scrollView.height * 0.1475) + 1.6);
        imgView1.centerY = _scrollView.centerY;
        
        UIImageView  *imgView2 = _scrollView.subviews[_index];
        imgView2.height = _scrollView.height - (moveX / SCREEN_WIDTH * (_scrollView.height * 0.1475) + 1.6);
        imgView2.centerY = _scrollView.centerY;
    }else if(moveX > -SCREEN_WIDTH){
        UIImageView  *imgView1 = _scrollView.subviews[_index - 1];
        imgView1.height = _picHeight + (fabs(moveX) / SCREEN_WIDTH * (_scrollView.height * 0.1475) + 1.6);
        imgView1.centerY = _scrollView.centerY;
        
        UIImageView  *imgView2 = _scrollView.subviews[_index];
        imgView2.height = _scrollView.height - (fabs(moveX) / SCREEN_WIDTH * (_scrollView.height * 0.1475) + 1.6);
        imgView2.centerY = _scrollView.centerY;
    }
}

//点击触发的方法
- (void)tapAction:(UITapGestureRecognizer *)tap{
    if ([_dataArray isKindOfClass:[NSArray class]] && (self.picCount > 0)) {
        [self.delegate didClicked:_index];
    }else{
        self.index = -1;
    }
}

@end
