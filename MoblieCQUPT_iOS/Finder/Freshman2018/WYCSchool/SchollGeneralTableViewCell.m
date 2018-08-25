//
//  SchollGeneralTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/17.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SchollGeneralTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation SchollGeneralTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initWithDic:(NSDictionary *)dataDic{
    //自定义初始化
    _backView.layer.masksToBounds = NO;
    // 设置圆角大小
    _backView.layer.cornerRadius = 6.0 ;
    //添加阴影
    _backView.layer.shadowOffset=CGSizeMake(0, 0);//往x方向偏移0，y方向偏移0
    _backView.layer.shadowColor= [UIColor blackColor].CGColor;//设置阴影颜色
    _backView.layer.shadowRadius= 3;//设置阴影半径
    _backView.layer.shadowOpacity= .1f;//设置阴影透明度

    
    //添加scrollview
    _index = 0;
   
    _scrollView.layer.masksToBounds = YES;
    // 设置圆角大小
    _scrollView.layer.cornerRadius = 6.0 ;
    //[_scrollView setFrame:CGRectMake(0, 0, _RootView.frame.size.width, 164*autoSizeScaleY)];
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToWatch)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:tap];
    [_scrollView layoutIfNeeded];
    
    
   
    int i = 0;
    _imgArray = [[NSMutableArray alloc]init];
    _picUrl = [[NSArray alloc]init];
    _picUrl = [dataDic objectForKey:@"picture"];
    @autoreleasepool{
    for (NSString __strong *url in _picUrl) {
        url = [NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018%@",url];
        UIImageView *view = [[UIImageView alloc]init];
        [_imgArray addObject:view];
        [view sd_setImageWithURL:[NSURL URLWithString:url]];
        
        view.frame = CGRectMake(_scrollView.frame.size.width*i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        
        view.userInteractionEnabled = YES;
        
        [_scrollView addSubview:view];
        i++;
    }
    }
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*_picUrl.count, 0);
    
    [_RootView addSubview:_scrollView];
    
    
    //设置Label内容
    
    //[_nameLabel setFrame:CGRectMake(0, _scrollView.frame.size.height + 8*autoSizeScaleY, _RootView.frame.size.width, 14*(SCREENHEIGHT/667))];
    _nameLabel.text = [[NSString alloc]initWithFormat:@"%@",[dataDic objectForKey:@"name"]];
    _nameLabel.font = [UIFont adaptFontSize:15];
    [_RootView addSubview:_nameLabel];
    
    
    
    
    //设置自动行数与字符换行
    
    [_contentLabel setNumberOfLines:0];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.text = [[NSString alloc]initWithFormat:@"%@",[dataDic objectForKey:@"content"]];
    _contentLabel.textColor = [UIColor darkGrayColor];
    [_RootView addSubview:_contentLabel];
    NSInteger fontSize;
    fontSize = 14;
//    if (SCREENWIDTH >=375) {
//        fontSize = 14;
//        _contentLabel.font = [UIFont adaptFontSize:fontSize];
//    }else{
//        fontSize = 14;
//        _contentLabel.font = [UIFont adaptFontSize:fontSize];
//    }
    _contentLabel.font = [UIFont adaptFontSize:fontSize];
    [_RootView layoutIfNeeded];
    
    CGFloat contenLableHeight = [self calculateRowHeight:[[NSString alloc]initWithFormat:@"%@",[dataDic objectForKey:@"content"]] fontSize:fontSize];
    CGFloat scrollViewHeight = _RootView.width * 0.5189;
    [self setSize:CGSizeMake(self.width, 113*autoSizeScaleY + scrollViewHeight + contenLableHeight)];

    [self layoutIfNeeded];
    [self layoutSubviews];


    //_contentLabelHeight.constant = contenLableHeight + 20*autoSizeScaleY;;

   
    
    
    
    _pageControl = [[UIPageControl alloc]init];
    //[_pageControl setFrame:CGRectMake(0, _scrollView.height - 30*autoSizeScaleY, _scrollView.frame.size.width, 30*autoSizeScaleY)];
    _pageControl.numberOfPages = _picUrl.count;
    _pageControl.currentPage = _index;
    _pageControl.hidesForSinglePage = YES;
    
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    
    [_RootView addSubview:_pageControl];
    
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.superview.mas_left).offset(15*autoSizeScaleX);
        make.right.equalTo(_backView.superview.mas_right).offset(-15*autoSizeScaleX);
        make.top.equalTo(_backView.superview.mas_top).offset(15*autoSizeScaleY);
        make.bottom.equalTo(_backView.superview.mas_bottom).offset(-15*autoSizeScaleY);
        
    }];
    [_backView layoutIfNeeded];
    
    [_RootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_RootView.superview.mas_left).offset(15*autoSizeScaleX);
        make.right.equalTo(_RootView.superview.mas_right).offset(-15*autoSizeScaleX);
        make.top.equalTo(_RootView.superview.mas_top).offset(15*autoSizeScaleY);
        make.bottom.equalTo(_RootView.superview.mas_bottom).offset(-15*autoSizeScaleY);
    }];
    [_RootView layoutIfNeeded];
   
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_RootView.mas_left).offset(0);
        make.right.equalTo(_RootView.mas_right).offset(0);
        make.top.equalTo(_RootView.mas_top).offset(0);
        make.height.mas_equalTo(scrollViewHeight);
    }];
    [_scrollView layoutIfNeeded];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scrollView.mas_left).offset(0);
        make.right.equalTo(_scrollView.mas_right).offset(0);
        make.bottom.equalTo(_scrollView.mas_bottom).offset(0);
        make.height.mas_equalTo(30*autoSizeScaleY);
    }];
    [_pageControl layoutIfNeeded];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_RootView.mas_left).offset(0);
        make.right.equalTo(_RootView.mas_right).offset(0);
        make.top.equalTo(_scrollView.mas_bottom).offset(18*autoSizeScaleY);
        make.height.mas_equalTo(14*autoSizeScaleY);
    }];
    [_nameLabel layoutIfNeeded];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_RootView.mas_left).offset(0);
        make.right.equalTo(_RootView.mas_right).offset(0);
        make.top.equalTo(_nameLabel.mas_bottom).offset(0);
        make.bottom.equalTo(_RootView.mas_bottom).offset(0);
        //make.height.mas_equalTo(contenLableHeight);
    }];
    [_contentLabel layoutIfNeeded];
    
    
    
    
}
- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.RootView.width, 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _index = _scrollView.contentOffset.x/_scrollView.frame.size.width;
    
    [self updatePageControlOnView];
}
-(void)updatePageControlOnView{
    
    _pageControl.currentPage = _index;
    
}
-(void)changePage:(id)sender{
    NSInteger i = _pageControl.currentPage;
    [_scrollView setContentOffset:CGPointMake(i*316*autoSizeScaleX, 0) animated:YES];
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
    
    @autoreleasepool{
    for (int i = 0; i < _picUrl.count; i++) {
  
        UIImageView *tmp = _imgArray[i];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:tmp.image];

        [imgView setFrame:CGRectMake(i*scrollView.width, 0, scrollView.width, scrollView.height)];
        [scrollView addSubview:imgView];
    }
    }
    scrollView.contentSize = CGSizeMake(_picUrl.count*scrollView.width, 0);
    
    //NSLog(@"indexInWatch:%ld",(long)_index);
    scrollView.contentOffset = CGPointMake((_index)*scrollView.width,0);
    
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
