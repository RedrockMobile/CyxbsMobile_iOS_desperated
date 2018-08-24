//
//  ShowVideoScroll.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ShowVideoScroll.h"
#import "MTVideo1.h"


@interface ShowVideoScroll ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *dataArray;  // 图片数据
@property (nonatomic, assign) float halfGap;   // 图片间距的一半
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) NSMutableArray *photosTitleArray;
@property (nonatomic, strong) NSMutableArray *photoUrlStrArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger imgcount;

@end

@implementation ShowVideoScroll

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
        
        self.scrollView.clipsToBounds = NO;
        
        /** 添加手势 */
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self.scrollView addGestureRecognizer:tap];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        /** 数据初始化 */
        
        
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
        
        UIImageView *videoView = [[UIImageView alloc] init];
        videoView.userInteractionEnabled = YES;
        videoView.tag = 400 + i ;
        videoView.layer.masksToBounds = YES;
        // 设置圆角大小
        videoView.layer.cornerRadius = 6.0 ;
        
        
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
        
        
      videoView.frame = CGRectMake((2 * i + 1) * self.halfGap + i * (self.scrollView.frame.size.width - 2 * self.halfGap), 0, (self.scrollView.frame.size.width - 2 * self.halfGap), self.frame.size.height);
        
        //从图片url设置图片
        if (i == 0) {
            NSString *url = [[dataArray[_imgcount - 1] objectForKey:@"video_pic"] objectForKey:@"url"];
             url = [NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",url];
            [videoView sd_setImageWithURL:[NSURL URLWithString:url]];
            
            self.index = _imgcount - 1;
            
            
        }else if (i == _imgcount+1) {
            NSString *url = [[dataArray[0] objectForKey:@"video_pic"] objectForKey:@"url"];
            url = [NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",url];
            [videoView sd_setImageWithURL:[NSURL URLWithString:url]];
            self.index = 0;
            
        }else {
            NSString *url = [[dataArray[i - 1] objectForKey:@"video_pic"] objectForKey:@"url"];
            url = [NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",url];
            [videoView sd_setImageWithURL:[NSURL URLWithString:url]];
            self.index = i - 1;
        }
        //NSLog(@"%@",[[_dataArray[self.index]objectForKey:@"video_pic"]objectForKey:@"name"]);
        UIView *bar = [self addbarOnImgView:videoView];
        [videoView addSubview:bar];
        
        [self.scrollView addSubview:videoView];
    }
    //设置轮播图当前的显示区域
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * (_imgcount + 2), 0);
    
}
- (UIView *)addbarOnImgView:(UIImageView *)videoView{
    //在图片上添加灰色的覆盖
    UIView *bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, videoView.frame.size.width, videoView.frame.size.height)];
    
    bar.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    //添加文字
    UILabel *barLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, videoView.frame.size.height-24, videoView.frame.size.width, 18)];
    //NSLog(@"%@",[[_dataArray[self.index]objectForKey:@"video_pic"]objectForKey:@"name"]);
    barLabel.text = [NSString stringWithFormat:@"%@",[_dataArray[self.index]objectForKey:@"name"]];
    barLabel.textColor = [UIColor whiteColor];
    [bar addSubview:barLabel];
    
    //添加点击按钮
    UIButton *playbutton = [[UIButton alloc]init];
   
    [playbutton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    
    [playbutton setSize:CGSizeMake(50*autoSizeScaleX, 50*autoSizeScaleY)];
    playbutton.centerX = bar.centerX;
    playbutton.centerY = bar.centerY;
    [playbutton addTarget:self action:@selector(loadVideo) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:playbutton];
    
    
    return bar;
}


- (void)loadVideo{
    [self.viewController.navigationController pushViewController:[[MTVideo1 alloc] initWithVideoUrlStr:[NSString stringWithFormat:@"%@",[_dataArray[self.index-1]objectForKey:@"url"]]] animated:YES];
    
}


#pragma mark - UIScrollViewDelegate 方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger curIndex = (long)roundf(scrollView.contentOffset.x  / scrollView.frame.size.width);
    if (curIndex == _imgcount + 1) {
        
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }else if (curIndex == 0){
        
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * _imgcount, 0);
    }
    
}

#pragma mark - 轻拍手势的方法
-(void)tapAction:(UITapGestureRecognizer *)tap{
    self.index = 0;
    
    if ([_dataArray isKindOfClass:[NSArray class]] && (_imgcount > 0)) {
        
        self.index = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
       
        [self loadVideo];
        
    }else{
        self.index = -1;
       
    }
    
}


@end

