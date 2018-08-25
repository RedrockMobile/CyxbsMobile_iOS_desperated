//
//  SchollGeneralTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/17.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SchollGeneralTableViewCell.h"

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
    self.layer.masksToBounds = YES;
    // 设置圆角大小
    self.layer.cornerRadius = 6.0 ;
    
    self.backgroundColor = [UIColor whiteColor];
    _RootView.backgroundColor = [UIColor clearColor];
    
    //添加scrollview
    
    _index = 0;
    
    _scrollView.layer.masksToBounds = YES;
    // 设置圆角大小
    _scrollView.layer.cornerRadius = 6.0 ;
    [_scrollView setFrame:CGRectMake(0, 0, _RootView.frame.size.width, 164*autoSizeScaleY)];
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [_scrollView layoutIfNeeded];
    
    
   
    int i = 0;
    _picUrl = [[NSArray alloc]init];
    _picUrl = [dataDic objectForKey:@"picture"];
    
    for (NSString __strong *url in _picUrl) {
        url = [NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",url];
        UIImageView *view = [[UIImageView alloc]init];
        
        [view sd_setImageWithURL:[NSURL URLWithString:url]];
        
        view.frame = CGRectMake(_scrollView.frame.size.width*i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        
        view.userInteractionEnabled = YES;
        
        [_scrollView addSubview:view];
        i++;
    }
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*_picUrl.count, 0);
    
    [_RootView addSubview:_scrollView];
    
    [self updatePageControlOnView];
    
    //设置Label内容
    
    
    [_nameLabel setFrame:CGRectMake(0, _scrollView.frame.size.height + 8*autoSizeScaleY, _RootView.frame.size.width, 14*(SCREENHEIGHT/667))];
    _nameLabel.text = [[NSString alloc]initWithFormat:@"%@",[dataDic objectForKey:@"name"]];
    _nameLabel.font = [UIFont adaptFontSize:16];
    [_RootView addSubview:_nameLabel];
    
    
    
    
    //设置自动行数与字符换行
    
    [_contentLabel setNumberOfLines:0];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.text = [[NSString alloc]initWithFormat:@"%@",[dataDic objectForKey:@"content"]];
    _contentLabel.textColor = [UIColor darkGrayColor];
    NSInteger fontSize;
    if (SCREENWIDTH >=375) {
        fontSize = 14;
        _contentLabel.font = [UIFont adaptFontSize:fontSize];
    }else{
        fontSize = 12;
        _contentLabel.font = [UIFont adaptFontSize:fontSize];
    }
    
    [_RootView layoutIfNeeded];
    
    CGFloat contenLableHeight = [self calculateRowHeight:[[NSString alloc]initWithFormat:@"%@",[dataDic objectForKey:@"content"]] fontSize:fontSize];
    
    [self setSize:CGSizeMake(self.width, 240*autoSizeScaleY + contenLableHeight)];
    
    [self layoutIfNeeded];
    [self layoutSubviews];
    
  
    _contentLabelHeight.constant = contenLableHeight + 20*autoSizeScaleY;;

    
    [_RootView addSubview:_contentLabel];
    
    
    
    _pageControl = [[UIPageControl alloc]init];
    [_pageControl setFrame:CGRectMake(0, 164* autoSizeScaleY - 30*autoSizeScaleY, _scrollView.frame.size.width, 30*autoSizeScaleY)];
    _pageControl.numberOfPages = _picUrl.count;
    _pageControl.currentPage = _index;
    _pageControl.hidesForSinglePage = YES;
    
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [_RootView addSubview:_pageControl];
    
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
@end
