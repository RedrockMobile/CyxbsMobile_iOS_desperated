//
//  SYCActivityTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCActivityTableViewCell.h"
#import "SYCActivityManager.h"

@interface SYCActivityTableViewCell()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation SYCActivityTableViewCell

- (void)drawRect:(CGRect)rect{
    
    CGFloat backgroundViewWidth = [[UIScreen mainScreen] bounds].size.width - 20;
    CGFloat backgroundViewHeight = 500 - 30;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - backgroundViewWidth) / 2.0, (500 - backgroundViewHeight) / 2.0, backgroundViewWidth, backgroundViewHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.masksToBounds = YES;
    backgroundView.layer.cornerRadius = 8.0;
    [self.contentView addSubview:backgroundView];
    self.contentView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    
    if (self.row == 4) {
        self.activity = nil;
        backgroundView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    }else{
        self.activity = [SYCActivityManager sharedInstance].activityData[self.row];
        backgroundView.backgroundColor = [UIColor whiteColor];
    }
    
    
    
    
    
    CGFloat imageViewWidth = backgroundViewWidth * 0.93;
    CGFloat imageViewHeight = backgroundViewHeight * 0.45;
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((backgroundViewWidth - imageViewWidth) / 2.0, backgroundViewHeight * 0.035, imageViewWidth, imageViewHeight)];
//    imageView.image = self.activity.imagesArray[0];
//    imageView.layer.masksToBounds = YES;
//    imageView.layer.cornerRadius = 8.0;
//    [backgroundView addSubview:imageView];
    
    CGFloat labelWidth = backgroundViewWidth * 0.4;
    CGFloat labelHeight = backgroundViewHeight * 0.1;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(backgroundViewWidth * 0.04, backgroundViewHeight * 0.5, labelWidth, labelHeight)];
    nameLabel.text = self.activity.name;
    nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    [backgroundView addSubview:nameLabel];
    
    CGFloat textViewWidth = backgroundViewWidth * 0.95;
    CGFloat textViewHeight = backgroundViewHeight * 0.4;
    UITextView *detailText = [[UITextView alloc] initWithFrame:CGRectMake((backgroundViewWidth - textViewWidth) / 2.0, backgroundViewHeight * 0.578, textViewWidth, textViewHeight)];
    if (self.row == 4) {
        detailText.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    }
    detailText.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1.0];
    detailText.font = [UIFont systemFontOfSize:16 weight:UIFontWeightUltraLight];
    detailText.text = self.activity.detail;
    [backgroundView addSubview:detailText];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((backgroundViewWidth - imageViewWidth) / 2.0, backgroundViewHeight * 0.035, imageViewWidth, imageViewHeight)];
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    self.scrollView.layer.masksToBounds = YES;
    self.scrollView.layer.cornerRadius = 8.0;
    //图片的具体位置需要动态计算
    CGFloat imageY = 0;
    int i = 0;
    for (UIImage *image in self.activity.imagesArray) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        imageView.image = image;
        i++;
        [self.scrollView addSubview:imageView];
    }
    
    //设置滚动内容的尺寸
    CGFloat contentW= [self.activity.imagesArray count] * imageW;
    self.scrollView.contentSize=CGSizeMake(contentW, 0);
    
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.pageControl.enabled = YES;
    self.scrollView.delegate = self;
    
    //设置pageControl的总页数
    self.pageControl.numberOfPages = [self.activity.imagesArray count];
    
    //7.添加定时器
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    [backgroundView addSubview:self.scrollView];
    
    CGFloat pageControlWidth = imageViewWidth * 0.3;
    CGFloat pageControlHeight = imageViewHeight * 0.1;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((imageViewWidth - pageControlWidth) / 2.0, imageViewHeight * 0.8, pageControlWidth, pageControlHeight)];
    [self.backgroundView addSubview:self.pageControl];
}

-(void)nextImage{
    int page = 0;
    if(self.pageControl.currentPage == [self.activity.imagesArray count] - 1){
        //如果滚动到最后一页了，那下一页就是第一页
        page = 0;
    }
    else{
        //否则就是下一页
        page = (int)self.pageControl.currentPage+1;
    }
    
    //2.计算scrollView滚动的位置
    CGFloat offsetX=page*self.scrollView.frame.size.width;
    CGPoint offset=CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

//开始拖拽的时候调用
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //停止定时器
    [self.timer invalidate];
    self.timer=nil;
}

//停止拖拽的时候调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //再次开启定时器
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

//当scrollView正在滚动就会调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //根据scrollView的滚动位置决定pageControl显示第几页
    int page=(scrollView.contentOffset.x+self.scrollView.frame.size.width*0.5)/scrollView.frame.size.width;
    self.pageControl.currentPage=page;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
