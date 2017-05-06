//
//  LZListView.m
//  FreshManFeature
//
//  Created by 李展 on 16/8/14.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "LZListView.h"
#import "UIImage+FillColor.h"

@interface LZListView()
@property CGFloat height;
@property NSArray *titlesArray;
@end
@implementation LZListView

-(instancetype) initWithFrame:(CGRect)frame andStringArray:(NSArray *)array andBtnHeight:(CGFloat)height{
    if(self = [super initWithFrame:frame]){
        self.layer.borderColor = [[UIColor colorWithRed:204.f/255 green:204.f/255  blue:204.f/255  alpha:1] CGColor];
        self.layer.borderWidth = 0.5;
        _titlesArray = array;
        _height = height;
        [self createMenu];
    }
    return self;
}

-(void) createMenu{
    CGFloat height = _titlesArray.count > 5? 5*_height : _titlesArray.count*_height;
    _scrollView = [[LZScorllView alloc]initWithFrame:CGRectMake(0,  0, self.frame.size.width, height)];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, _titlesArray.count*_height);
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    
    for (int i =0 ; i<_titlesArray.count; i++) {
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0, i*_height, self.frame.size.width,_height)];
        bt.tag = i;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, i*_height, self.frame.size.width, 0.5)];
        view.backgroundColor = [UIColor colorWithCGColor:[[UIColor colorWithRed:204.f/255 green:204.f/255  blue:204.f/255  alpha:1] CGColor]];
        
        bt.titleLabel.textAlignment = NSTextAlignmentCenter;
        [bt setTitle:_titlesArray[i] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        bt.backgroundColor = [UIColor whiteColor];
        [bt setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:184/255.f green:230/255.f blue:253/255.f alpha:1]] forState:UIControlStateHighlighted];
        
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:bt];
        [_scrollView addSubview:view];
    }
   
    [_scrollView setHidden:YES];
}

-(void) click:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(eventWhenClickListViewBtn:)])
    {
     [self.delegate eventWhenClickListViewBtn:sender];
    }
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:self.frame byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: CGSizeMake(5, 5)];
    [rectanglePath closePath];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextRestoreGState(context);
}


@end
