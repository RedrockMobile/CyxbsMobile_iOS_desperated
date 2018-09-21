//
//  WYCClassBookView.m
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCClassBookView.h"
#import "Masonry.h"
//#import "UIColor+Hex.h"
@interface WYCClassBookView()

@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIView *leftBar;
@property (nonatomic, strong) UIView *month;
@property (nonatomic, strong) UIView *dayBar;
@property (nonatomic, strong) UIView *rootView;
@property (nonatomic, strong) NSArray *dataArray;

@end
@implementation WYCClassBookView

-(void)initView:(BOOL)isFirst{
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    _month = [[UIView alloc]init];
    _month.backgroundColor = [UIColor clearColor];
    
    _dayBar = [[UIView alloc]init];
    _dayBar.backgroundColor = [UIColor clearColor];
    
    _topBar = [[UIView alloc]init];
    _topBar.backgroundColor = [UIColor colorWithHexString:@"#EEF6FD"];
    
    [_topBar addSubview:_month];
    [_topBar addSubview:_dayBar];
    
    [self addSubview:_topBar];
    
    _rootView = [[UIView alloc]init];
    
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.scrollEnabled = YES;
     _scrollView.contentSize = CGSizeMake(0,606*autoSizeScaleY);
    
    [_rootView addSubview:_scrollView];
    [self addSubview:_rootView];
    
    _leftBar = [[UIView alloc]init];
    
    _leftBar.backgroundColor = [UIColor colorWithHexString:@"#EEF6FD"];
    
    [_scrollView addSubview: _leftBar];
    
    
    
    
    
    
    
    [_month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_topBar.mas_top).offset(0);
        make.left.equalTo(self->_topBar.mas_left).offset(0);
        make.bottom.equalTo(self->_topBar.mas_bottom).offset(0);
        make.width.mas_equalTo(31*autoSizeScaleX);
        
    }];
    
    [_dayBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_topBar.mas_top).offset(0);
        make.left.equalTo(self->_month.mas_right).offset(0);
        make.bottom.equalTo(self->_topBar.mas_bottom).offset(0);
        make.right.equalTo(self->_topBar.mas_right).offset(0);
        
    }];
    
    [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(49*autoSizeScaleY);
        
    }];
    
    
    [_rootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_topBar.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_rootView.mas_top).offset(0);
        make.left.equalTo(self->_rootView.mas_left).offset(0);
        make.right.equalTo(self->_rootView.mas_right).offset(0);
        make.bottom.equalTo(self->_rootView.mas_bottom).offset(0);
        
    }];
    
    
    [_leftBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_scrollView.mas_top).offset(0);
        make.left.equalTo(self->_scrollView.mas_left).offset(0);
        make.height.mas_equalTo(606*autoSizeScaleY);
        make.width.mas_equalTo(31*autoSizeScaleX);
        
    }];
    
}
-(void)addBar:(NSArray *)date isFirst:(BOOL)isFirst{
    //NSLog(@"%lu",(unsigned long)date.count);
    //NSLog(@"%@",date[0]);
    [_dayBar layoutIfNeeded];
    
    NSArray *day = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    @autoreleasepool {
        if (isFirst) {
            
            for (int i = 0 ; i<7; i++) {
                UIView *dayItem = [[UIView alloc]init];
                CGFloat dayItemWidth = _dayBar.frame.size.width/7;
                CGFloat dayItemHeight = _dayBar.frame.size.height;
                [dayItem setFrame:CGRectMake(i*dayItemWidth, 0, dayItemWidth, dayItemHeight)];
                
                
                //添加星期几
                UILabel *weekLabel = [[UILabel alloc]init];
                weekLabel.text = day[i];
                weekLabel.font = [UIFont systemFontOfSize:12];
                weekLabel.textColor = [UIColor colorWithHexString:@"#7097FA"];
                weekLabel.textAlignment = NSTextAlignmentCenter;
                [weekLabel setFrame:CGRectMake(0, 0, dayItem.frame.size.width, dayItem.frame.size.height)];
                [dayItem addSubview:weekLabel];
                [_dayBar addSubview:dayItem];
            }
        }else{
            for (int i = 0 ; i<7; i++) {
                
                UIView *dayItem = [[UIView alloc]init];
                CGFloat dayItemWidth = _dayBar.frame.size.width/7;
                CGFloat dayItemHeight = _dayBar.frame.size.height;
                //NSLog(@"w:%f",dayItemWidth);
                //NSLog(@"h:%f",dayItemHeight);
                [dayItem setFrame:CGRectMake(i*dayItemWidth, 0, dayItemWidth, dayItemHeight)];
                
                //添加星期几
                UILabel *weekLabel = [[UILabel alloc]init];
                weekLabel.text = day[i];
                weekLabel.font = [UIFont systemFontOfSize:12];
                weekLabel.textColor = [UIColor colorWithHexString:@"#7097FA"];
                weekLabel.textAlignment = NSTextAlignmentCenter;
                [weekLabel setFrame:CGRectMake(0, dayItem.frame.size.height/2-11, dayItem.frame.size.width, 11)];
                [dayItem addSubview:weekLabel];
                //添加日期
                UILabel *dayLabel = [[UILabel alloc]init];
                NSString *dayNum = [NSString stringWithFormat:@"%@日",[date[i] objectForKey:@"day"]];
                dayLabel.text = dayNum;
                dayLabel.font = [UIFont systemFontOfSize:11];
                dayLabel.textColor = [UIColor colorWithHexString:@"#8395A4"];
                dayLabel.textAlignment = NSTextAlignmentCenter;
                [dayLabel setFrame:CGRectMake(0, dayItem.frame.size.height/2, dayItem.frame.size.width, dayItem.frame.size.height/2)];
                [dayItem addSubview:dayLabel];
                
                [_dayBar addSubview:dayItem];
            }
            [_dayBar layoutSubviews];
            
            [_month layoutIfNeeded];
            UILabel *monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _month.frame.size.width, _month.frame.size.height)];
            NSString *monthNum = [NSString stringWithFormat:@"%@月",[date[0] objectForKey:@"month"]];
            monthLabel.text = monthNum;
            monthLabel.font = [UIFont systemFontOfSize:11];
            monthLabel.textColor = [UIColor colorWithHexString:@"#7097FA"];
            monthLabel.textAlignment = NSTextAlignmentCenter;
            [_month addSubview:monthLabel];
            [_month layoutSubviews];
        }
    }
    [_leftBar layoutIfNeeded];
    @autoreleasepool {
        CGFloat numLabelWidth = _leftBar.frame.size.width;
        CGFloat numLabelHeight = 101*autoSizeScaleY/2;
        for (int i = 0; i < 12; i++) {
            UILabel *numLabel = [[UILabel alloc]init];
            [numLabel setFrame:CGRectMake(0, i*numLabelHeight, numLabelWidth, numLabelHeight)];
            numLabel.text = [NSString stringWithFormat:@"%d",i+1];
            numLabel.textAlignment = NSTextAlignmentCenter;
            numLabel.textColor = [UIColor colorWithHexString:@"#7097FA"];
            numLabel.font = [UIFont systemFontOfSize:13];
            [_leftBar addSubview:numLabel];
            
            
        }
    }
//    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width,_leftBar.frame.size.height);
    
}
-(void)addBtn:(NSArray *)array{
    _dataArray = array;
    @autoreleasepool {
        [_dayBar layoutIfNeeded];
        [_leftBar layoutIfNeeded];
        CGFloat btnWidth = _dayBar.frame.size.width/7;
        CGFloat btnHeight = 101*autoSizeScaleY;
        for (int i = 0; i < 7; i++) {
            for (int j = 0; j < 6; j++) {
                
                UIColor *viewColor = [[UIColor alloc]init];
                if (j<2) {
                    viewColor = [UIColor colorWithHexString:@"#FF89A5"];
                }else if(j>=2&&j<4){
                    viewColor = [UIColor colorWithHexString:@"#FFBF7B"];
                }else{
                    viewColor = [UIColor colorWithHexString:@"#81B6FE"];
                }
                UIView *btnView = [[UIView alloc]init];
                [btnView setFrame:CGRectMake(_leftBar.frame.size.width +  i*btnWidth, j*btnHeight, btnWidth, btnHeight)];
                
                UIButton *btn = [[UIButton alloc]init];
                btn.layer.cornerRadius = 3.0 ;
                
                if ([[NSString stringWithFormat:@"%@",_dataArray[j][i]] isEqualToString:@""]) {
                    btn.backgroundColor = [UIColor whiteColor];
                    [btn setFrame:CGRectMake(1, 1, btnWidth-2, btnHeight-2)];
                    [btnView addSubview:btn];
                }else{
                    
                    btn.backgroundColor = viewColor;
                    [btn setFrame:CGRectMake(1, 1, btnWidth-2, btnHeight-2)];
                    
                    
                    UILabel *classRoomNumLabel = [[UILabel alloc]init];
                    [classRoomNumLabel setFrame:CGRectMake(0, btn.frame.size.height-20, btn.frame.size.width, 10)];
                    classRoomNumLabel.text = [NSString stringWithFormat:@"%@", [_dataArray[j][i] objectForKey:@"classroom"]];
                    
                    classRoomNumLabel.textAlignment = NSTextAlignmentCenter;
                    classRoomNumLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
                    classRoomNumLabel.font = [UIFont systemFontOfSize:12];
                    
                    UILabel *classNameLabel = [[UILabel alloc]init];
                    CGFloat classNameLabelHeight = [self calculateRowHeight:[NSString stringWithFormat:@"%@", [_dataArray[j][i] objectForKey:@"course"]] fontSize:12 width:btn.frame.size.width - 10];
                    if (classNameLabelHeight > btn.frame.size.height-30) {
                        classNameLabelHeight = btn.frame.size.height-30;
                    }
                    
                    [classNameLabel setFrame:CGRectMake(5, 9, btn.frame.size.width - 10, classNameLabelHeight)];
                    classNameLabel.text = [NSString stringWithFormat:@"%@", [_dataArray[j][i] objectForKey:@"course"]];
                    classNameLabel.textAlignment = NSTextAlignmentCenter;
                    classNameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
                    classNameLabel.font = [UIFont systemFontOfSize:12];
                    [classNameLabel setNumberOfLines:0];
                    classNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    
                    
                    [btn addSubview:classRoomNumLabel];
                    [btn addSubview:classNameLabel];
                    [btnView addSubview:btn];
                }
                [_scrollView addSubview:btnView];
                
            }
        }
        
    }
    //NSLog(@"subcount:%lu",(unsigned long)_scrollView.subviews.count);
}
-(void)chackBigLesson{
    @autoreleasepool {
        [_dayBar layoutIfNeeded];
        [_leftBar layoutIfNeeded];
        CGFloat btnWidth = _dayBar.frame.size.width/7;
        CGFloat btnHeight = 101*autoSizeScaleY;
        for (int i = 0; i < 7; i++) {
            for (int j = 0; j < 6; j++) {
                
                if (![[NSString stringWithFormat:@"%@",_dataArray[j][i]] isEqualToString:@""]) {
                    
                    
                    
                    NSNumber *tmp = [_dataArray[j][i] objectForKey:@"period"];
                    if (tmp.integerValue != 2) {
                        //NSLog(@"biglesson:%ld,i:%d,j:%d",tmp.integerValue,i,j);
                        btnHeight = 101*autoSizeScaleY*(tmp.integerValue/2);
                        
                        
                        UIColor *viewColor = [[UIColor alloc]init];
                        if (j<2) {
                            viewColor = [UIColor colorWithHexString:@"#FF89A5"];
                        }else if(j>=2&&j<4){
                            viewColor = [UIColor colorWithHexString:@"#FFBF7B"];
                        }else{
                            viewColor = [UIColor colorWithHexString:@"#81B6FE"];
                        }
                        UIView *btnView = [[UIView alloc]init];
                        
                        [btnView setFrame:CGRectMake(_leftBar.frame.size.width +  i*btnWidth, j*101*autoSizeScaleY, btnWidth, btnHeight)];
                        
                        UIButton *btn = [[UIButton alloc]init];
                        btn.layer.cornerRadius = 3.0 ;
                        
                        if ([[NSString stringWithFormat:@"%@",_dataArray[j][i]] isEqualToString:@""]) {
                            btn.backgroundColor = [UIColor whiteColor];
                            [btn setFrame:CGRectMake(1, 1, btnWidth-2, btnHeight-2)];
                            [btnView addSubview:btn];
                        }else{
                            
                            btn.backgroundColor = viewColor;
                            [btn setFrame:CGRectMake(1, 1, btnWidth-2, btnHeight-2)];
                            [btn layoutIfNeeded];
                            
                            UILabel *classRoomNumLabel = [[UILabel alloc]init];
                            [classRoomNumLabel setFrame:CGRectMake(0, btn.frame.size.height-20, btn.frame.size.width, 10)];
                            classRoomNumLabel.text = [NSString stringWithFormat:@"%@", [_dataArray[j][i] objectForKey:@"classroom"]];
                            
                            classRoomNumLabel.textAlignment = NSTextAlignmentCenter;
                            classRoomNumLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
                            classRoomNumLabel.font = [UIFont systemFontOfSize:12];
                            
                            UILabel *classNameLabel = [[UILabel alloc]init];
                            CGFloat classNameLabelHeight = [self calculateRowHeight:[NSString stringWithFormat:@"%@", [_dataArray[j][i] objectForKey:@"course"]] fontSize:12 width:btn.frame.size.width - 10];
                            if (classNameLabelHeight > btn.frame.size.height-20) {
                                classNameLabelHeight = btn.frame.size.height-20;
                            }
                            
                            [classNameLabel setFrame:CGRectMake(5, 9, btn.frame.size.width - 10, classNameLabelHeight)];
                            classNameLabel.text = [NSString stringWithFormat:@"%@", [_dataArray[j][i] objectForKey:@"course"]];
                            classNameLabel.textAlignment = NSTextAlignmentCenter;
                            classNameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
                            classNameLabel.font = [UIFont systemFontOfSize:12];
                            [classNameLabel setNumberOfLines:0];
                            classNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
                            
                            
                            [btn addSubview:classRoomNumLabel];
                            [btn addSubview:classNameLabel];
                            [btnView addSubview:btn];
                        }
                        [_scrollView addSubview:btnView];
                    }
                }
            }
        }
        
    }
    
}

- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize width:(CGFloat)width{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}
-(void)changeScrollViewContentSize:(CGSize)contentSize{
    _scrollView.contentSize = contentSize;
}

@end
