//
//  RollView.m
//  picScrollView
//
//  Created by 王一成 on 2018/8/13.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "ShowPicScroll.h"



@interface ShowPicScroll ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) float halfGap;   // 图片间距的一半
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger imgcount;
@property (nonatomic, assign) CGFloat offsetX;

@end

@implementation ShowPicScroll

- (instancetype)initWithFrame:(CGRect)frame withDistanceForScroll:(float)distance withGap:(float)gap
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.halfGap = gap / 2;
        
        /** 设置 UIScrollView */
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(distance, 0, self.frame.size.width - 2 * distance, self.frame.size.height)];
        [self addSubview:self.scrollView];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        //self.scrollView.backgroundColor = [UIColor redColor];
        self.scrollView.clipsToBounds = NO;
        
        /** 添加手势 */
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self.scrollView addGestureRecognizer:tap];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        
        
    }
    
    
    return self;
}

#pragma mark - 视图数据

-(void)addScrollViewWithArray:(NSArray *)dataArray{
    
    
    self.dataArray = dataArray;
    self.imgcount = dataArray.count;
    
    
    //循环创建添加轮播图片, 前后各添加一张
    for (int i = 0; i < dataArray.count + 2; i++) {
        
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
        // 设置圆角大小
        picImageView.layer.cornerRadius = 6.0 ;
        
        
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
         .
         .
         *  i   -> (2 * i +1) *  halfGap + i *(width - 2 * halfGap )
         */
        CGFloat imgViewHeight = _scrollView.height*0.8625;
        
        picImageView.frame = CGRectMake((2 * i + 1) * self.halfGap + i * (self.scrollView.frame.size.width - 2 * self.halfGap), _scrollView.height/2 - imgViewHeight/2, (self.scrollView.frame.size.width - 2 * self.halfGap), imgViewHeight);
        
        
        //从图片url设置图片
        if (i == 0) {
            
            NSString *url = [dataArray[_imgcount - 1] objectForKey:@"url"];
            url = [NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018%@",url];
            [picImageView sd_setImageWithURL:[NSURL URLWithString:url]];
            
            self.index = _imgcount - 1;
            
            
        }else if (i == _imgcount+1) {
            
            NSString *url = [dataArray[0] objectForKey:@"url"];
            url = [NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018%@",url];
             [picImageView sd_setImageWithURL:[NSURL URLWithString:url]];
            self.index = 0;
            
        }else {
            
            NSString *url = [dataArray[i - 1] objectForKey:@"url"];
            url = [NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018%@",url];
            [picImageView sd_setImageWithURL:[NSURL URLWithString:url]];
            self.index = i - 1;
        }
        
        UIView *bar = [self addbarOnImgView:picImageView];
        [picImageView addSubview:bar];
      
        [self.scrollView addSubview:picImageView];
    }
    //设置轮播图当前的显示区域
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * (_imgcount + 2), 0);
    [self changeImgViewFrame];
    _offsetX = _scrollView.contentOffset.x ;
    
    
    
}
- (UIView *)addbarOnImgView:(UIImageView *)picImageView{
    //在图片上添加灰色的bar
    UIView *bar = [[UIView alloc]initWithFrame:CGRectMake(0, picImageView.frame.size.height-30, picImageView.frame.size.width, 30)];
    
    bar.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    //在bar上添加文字
    UILabel *barLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 6, 100, 18)];
    barLabel.text = [NSString stringWithFormat:@"%@",[_dataArray[self.index]objectForKey:@"name"]];
 
    barLabel.textColor = [UIColor whiteColor];
    
    [bar addSubview:barLabel];
    return bar;
}



#pragma mark - UIScrollViewDelegate 方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //NSInteger curIndex = scrollView.contentOffset.x  / scrollView.frame.size.width;
    
    NSInteger curIndex = (long)roundf(scrollView.contentOffset.x  / scrollView.frame.size.width);
    
    
    if (curIndex == _imgcount + 1) {
        
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
       
    }else if (curIndex == 0){
        
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * _imgcount, 0);
      
    }
    _index = (long)roundf(_scrollView.contentOffset.x  / _scrollView.frame.size.width);
    
    _offsetX = _scrollView.contentOffset.x ;
    [self changeImgViewFrame];
}
-(void)changeImgViewFrame{
    _index = (long)roundf(_scrollView.contentOffset.x  / _scrollView.frame.size.width);
    
    CGFloat imgViewHeight = _scrollView.height*0.8625;
    
    
    for (int i = 0; i < _scrollView.subviews.count - 1; i++) {
        if (i == _index) {
            UIImageView  *imgView = _scrollView.subviews[i];
            [imgView setFrame:CGRectMake(imgView.frame.origin.x, 0, imgView.frame.size.width, _scrollView.height)];
            [imgView.subviews[0] setOrigin:CGPointMake(imgView.subviews[0].frame.origin.x, imgView.frame.size.height - 30)];
            
        }else{
            UIImageView  *imgView = _scrollView.subviews[i];
            [imgView setFrame:CGRectMake(imgView.frame.origin.x, _scrollView.height/2 - imgViewHeight/2, imgView.frame.size.width, imgViewHeight)];
            [imgView.subviews[0] setOrigin:CGPointMake(imgView.subviews[0].frame.origin.x, imgView.frame.size.height - 30)];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat moveX = _scrollView.contentOffset.x-_offsetX;
    if (moveX > 0 ) {
        
        UIImageView  *imgView1 = _scrollView.subviews[_index+1];
        imgView1.height = _scrollView.height*0.8625 + moveX/_scrollView.width * (_scrollView.height*0.1475);
        imgView1.centerY = _scrollView.centerY;
        [imgView1.subviews[0] setOrigin:CGPointMake(imgView1.subviews[0].frame.origin.x, imgView1.frame.size.height - 30)];
        
        
        UIImageView  *imgView2 = _scrollView.subviews[_index];
        imgView2.height = _scrollView.height - moveX/_scrollView.width * (_scrollView.height*0.1475);
        imgView2.centerY = _scrollView.centerY;
        [imgView2.subviews[0] setOrigin:CGPointMake(imgView2.subviews[0].frame.origin.x, imgView2.frame.size.height - 30)];
    }else{
        
        UIImageView  *imgView1 = _scrollView.subviews[_index-1];
        imgView1.height = _scrollView.height*0.8625 + fabs(moveX)/_scrollView.width * (_scrollView.height*0.1475);
        imgView1.centerY = _scrollView.centerY;
        [imgView1.subviews[0] setOrigin:CGPointMake(imgView1.subviews[0].frame.origin.x, imgView1.frame.size.height - 30)];
        
        
        UIImageView  *imgView2 = _scrollView.subviews[_index];
        imgView2.height = _scrollView.height - fabs(moveX)/_scrollView.width * (_scrollView.height*0.1475);
        imgView2.centerY = _scrollView.centerY;
        [imgView2.subviews[0] setOrigin:CGPointMake(imgView2.subviews[0].frame.origin.x, imgView2.frame.size.height - 30)];
    }
}

#pragma mark - 轻拍手势的方法
-(void)tapAction:(UITapGestureRecognizer *)tap{
    
    
    if ([_dataArray isKindOfClass:[NSArray class]] && (_imgcount > 0)) {
   [self tapToWatch];
       
    }else{
        self.index = -1;
      
    }
   
}
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

-(void)tapToWatch{
    //初始化全屏view
   
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:999]) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:999] removeFromSuperview];
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    view.backgroundColor = [UIColor blackColor];
    //设置view的tag
    view.tag = 999;
    //添加手势
    UITapGestureRecognizer *tapToBackGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToBack)];
    [view addGestureRecognizer:tapToBackGesture];
    //往全屏view上添加内容
    CGFloat scrollViewHeight = SCREENWIDTH*0.5079;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT/2-scrollViewHeight/2, SCREENWIDTH, scrollViewHeight)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    for (int i = 0; i < _imgcount; i++) {
        UIImageView *tmp = _scrollView.subviews[i+1];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:tmp.image];
        [imgView setFrame:CGRectMake(i*scrollView.width, 0, scrollView.width, scrollView.height)];
        [scrollView addSubview:imgView];
    }
    scrollView.contentSize = CGSizeMake(_imgcount*scrollView.width, 0);
    
    NSLog(@"indexInWatch:%ld",(long)_index);
    scrollView.contentOffset = CGPointMake((_index-1)*scrollView.width,0);

    [view addSubview:scrollView];
    
//    [self.viewController.view addSubview:view];
//    [self shakeToShow:view];
    //显示全屏view
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
 //[self shakeToShow:view];
    
}


- (void)tapToBack {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *view = [window viewWithTag:999];
    [view removeFromSuperview];
}


@end

