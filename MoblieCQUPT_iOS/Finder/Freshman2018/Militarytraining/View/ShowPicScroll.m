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

@end

@implementation ShowPicScroll

- (instancetype)initWithFrame:(CGRect)frame withDistanceForScroll:(float)distance withGap:(float)gap
{
    
    self = [super initWithFrame:frame];
    if (self) {
        //self.index = 1;
        self.halfGap = gap / 2;
        
        /** 设置 UIScrollView */
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(distance, 0, self.frame.size.width - 2 * distance, self.frame.size.height)];
        [self addSubview:self.scrollView];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        
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
        
        
        picImageView.frame = CGRectMake((2 * i + 1) * self.halfGap + i * (self.scrollView.frame.size.width - 2 * self.halfGap), 0, (self.scrollView.frame.size.width - 2 * self.halfGap), self.frame.size.height);
        
        
        //从图片url设置图片
        if (i == 0) {
            
            NSString *url = [dataArray[_imgcount - 1] objectForKey:@"url"];
            url = [NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",url];
            [picImageView sd_setImageWithURL:[NSURL URLWithString:url]];
            
            self.index = _imgcount - 1;
            
            
        }else if (i == _imgcount+1) {
            
            NSString *url = [dataArray[0] objectForKey:@"url"];
            url = [NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",url];
             [picImageView sd_setImageWithURL:[NSURL URLWithString:url]];
            self.index = 0;
            
        }else {
            
            NSString *url = [dataArray[i - 1] objectForKey:@"url"];
            url = [NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",url];
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
    
    NSInteger curIndex = scrollView.contentOffset.x  / scrollView.frame.size.width;

    
    
    if (curIndex == _imgcount + 1) {
        
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
       
    }else if (curIndex == 0){
        
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * _imgcount, 0);
      
    }
     _index = _scrollView.contentOffset.x  / _scrollView.frame.size.width;
   

}

#pragma mark - 轻拍手势的方法
-(void)tapAction:(UITapGestureRecognizer *)tap{
    
    
    if ([_dataArray isKindOfClass:[NSArray class]] && (_imgcount > 0)) {
   [self tapToWatch];
       
    }else{
        self.index = -1;
      
    }
   
}
-(void)tapToWatch{
    //初始化全屏view
    if (_index == 0) {
    _index = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    }
    NSLog(@"index:%f",self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:999]) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:999] removeFromSuperview];
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    //设置view的tag
    view.tag = 999;
    //添加手势
    UITapGestureRecognizer *tapToBackGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToBack)];
    [view addGestureRecognizer:tapToBackGesture];
    //往全屏view上添加内容
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipetoRight)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    [scrollView addGestureRecognizer:swiperight];
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipetoLeft)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    [scrollView addGestureRecognizer:swipeleft];
    
    UILabel *numLable = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-50, 50, 100, 20)];
    numLable.textColor = [UIColor whiteColor];
    numLable.text = [NSString stringWithFormat:@"%ld/%ld",(long)self.index,(long)self.imgcount];
    numLable.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:numLable];
    UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-50, SCREENHEIGHT/2+150, 100, 20)];
    nameLable.textColor = [UIColor whiteColor];
    nameLable.text = [NSString stringWithFormat:@"%@",[_dataArray[self.index-1]objectForKey:@"name"]];
    nameLable.textAlignment = NSTextAlignmentCenter;
    
    
    [scrollView addSubview:nameLable];
    
    UIImageView  *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT/2-100, SCREENWIDTH, 250)];
    imgView.backgroundColor = [UIColor whiteColor];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[[_dataArray[self.index-1]objectForKey:@"url"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]]];
    [scrollView addSubview:imgView];
    
    
    [view addSubview:scrollView];
    
    
    //显示全屏view
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
    
    
}
-(void)swipetoLeft{
    if (self.index < self.imgcount) {
        self.index++;
        
    }else{
        self.index = 1;
    }
    [self tapToWatch];
    _scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * _index, 0);
    
}
-(void)swipetoRight{
    if (self.index >1) {
        self.index--;
    }else{
        self.index = self.imgcount;
    }
    [self tapToWatch];
    _scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * _index, 0);
}


- (void)tapToBack {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *view = [window viewWithTag:999];
    [view removeFromSuperview];
}


@end

