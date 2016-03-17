//
//  PickView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/3/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "PickView.h"

@implementation PickView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
//    if (self) {
//        
//        
//    }
    self.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    _backView = [[UIView alloc]initWithFrame:CGRectZero];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.shadowColor = [UIColor grayColor].CGColor;
    _backView.layer.shadowOffset = CGSizeMake(1, 1);
    _backView.layer.shadowOpacity = 0.4;
    _backView.layer.shadowRadius = 3;
    _backView.frame = CGRectMake(0, 0, ScreenWidth/10*7.5, ScreenWidth/10*7.5-20);
    _backView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);

    if (ScreenWidth == 375) {//6
        _margin = 25;
        _margin1 = 15;
        _imageWidth = 20;
        _fontSize = 18;
    }else if (ScreenWidth == 320) {//5
        _margin = 20;
        _margin1 = 10;
        _imageWidth = 15;
        _fontSize = 16;
    }else {//6p
        _margin = 28;
        _margin1 = 20;
        _imageWidth = 23;
        _fontSize = 20;
    }
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.text = @"空教室查询";
    _titleLabel.font = [UIFont systemFontOfSize:_fontSize];
    _titleLabel.textColor = MAIN_COLOR;
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(_margin, _margin, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
    
    _timeImage = [[UIImageView alloc]init];
    _classImage = [[UIImageView alloc]init];
    _sectionImage = [[UIImageView alloc]init];
    
    _timeImage.image = [UIImage imageNamed:@"GQtime.png"];
    _classImage.image = [UIImage imageNamed:@"GQclass.png"];
    _sectionImage.image = [UIImage imageNamed:@"GQsection.png"];
    
    _timeImage.frame = CGRectMake(_margin, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+_margin, _imageWidth, _imageWidth);
    _classImage.frame = CGRectMake(_margin, _timeImage.frame.origin.y+_timeImage.frame.size.height+_margin, _imageWidth, _imageWidth);
    _sectionImage.frame = CGRectMake(_margin, _classImage.frame.origin.y+_classImage.frame.size.height+_margin, _imageWidth, _imageWidth);
    
    _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _classBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sectionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [_timeBtn setTitle:@"请选择周~请选择日期" forState:UIControlStateNormal];
    [_timeBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    _timeBtn.titleLabel.font = [UIFont systemFontOfSize:_fontSize-3];
    
    [_classBtn setTitle:@"请选择教学楼" forState:UIControlStateNormal];
    [_classBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    _classBtn.titleLabel.font = [UIFont systemFontOfSize:_fontSize-3];
    
    [_sectionBtn setTitle:@"请选择时间" forState:UIControlStateNormal];
    [_sectionBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    _sectionBtn.titleLabel.font = [UIFont systemFontOfSize:_fontSize-3];
    
    [_timeBtn sizeToFit];
    [_classBtn sizeToFit];
    [_sectionBtn sizeToFit];
    
    _timeBtn.frame = CGRectMake(_timeImage.frame.origin.x+_timeImage.frame.size.width+_margin1, _timeImage.frame.origin.y, _timeBtn.frame.size.width, _imageWidth);
    _classBtn.frame = CGRectMake(_classImage.frame.origin.x+_classImage.frame.size.width+_margin1, _classImage.frame.origin.y, _classBtn.frame.size.width, _imageWidth);
    _sectionBtn.frame = CGRectMake(_sectionImage.frame.origin.x+_sectionImage.frame.size.width+_margin1, _sectionImage.frame.origin.y, _sectionBtn.frame.size.width, _imageWidth);
    
    _tag1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 7)];
    _tag2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 7)];
    _tag3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 7)];
    
    _tag1.center = CGPointMake(_timeBtn.frame.origin.x+_timeBtn.frame.size.width+5+_tag1.frame.size.width/2, _timeBtn.frame.origin.y+_timeBtn.frame.size.height/2);
    _tag2.center = CGPointMake(_classBtn.frame.origin.x+_classBtn.frame.size.width+5+_tag2.frame.size.width/2, _classBtn.frame.origin.y+_classBtn.frame.size.height/2);
    _tag3.center = CGPointMake(_sectionBtn.frame.origin.x+_sectionBtn.frame.size.width+5+_tag3.frame.size.width/2, _sectionBtn.frame.origin.y+_sectionBtn.frame.size.height/2);
    
    [_tag1 setTintColor:[UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1]];
    [_tag2 setTintColor:[UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1]];
    [_tag3 setTintColor:[UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1]];
    
    _tag1.image = [UIImage imageNamed:@"emptyClassTag2.png"];
    _tag2.image = [UIImage imageNamed:@"emptyClassTag2.png"];
    _tag3.image = [UIImage imageNamed:@"emptyClassTag2.png"];
    
    _line1 = [[UIView alloc]init];
    _line2 = [[UIView alloc]init];
    _line3 = [[UIView alloc]init];
    
    _line1.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    _line2.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    _line3.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    
    _line1.frame = CGRectMake(_timeBtn.frame.origin.x, _timeBtn.frame.origin.y+_timeBtn.frame.size.height, _backView.frame.size.width-_margin*2-_margin1-_imageWidth, 1);
    _line2.frame = CGRectMake(_classBtn.frame.origin.x, _classBtn.frame.origin.y+_classBtn.frame.size.height, _backView.frame.size.width-_margin*2-_margin1-_imageWidth, 1);
    _line3.frame = CGRectMake(_sectionBtn.frame.origin.x, _sectionBtn.frame.origin.y+_sectionBtn.frame.size.height, _backView.frame.size.width-_margin*2-_margin1-_imageWidth, 1);
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchBtn setTitle:@"查找" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _searchBtn.backgroundColor = MAIN_COLOR;
    _searchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
    _searchBtn.layer.cornerRadius = 5.0;
    _searchBtn.frame = CGRectMake(15, _backView.frame.size.height-55, _backView.frame.size.width-30, 40);
    
    [self addSubview:_backView];
    [_backView addSubview:_titleLabel];
    [_backView addSubview:_timeImage];
    [_backView addSubview:_classImage];
    [_backView addSubview:_sectionImage];
    [_backView addSubview:_timeBtn];
    [_backView addSubview:_classBtn];
    [_backView addSubview:_sectionBtn];
    [_backView addSubview:_line1];
    [_backView addSubview:_line2];
    [_backView addSubview:_line3];
    [_backView addSubview:_tag1];
    [_backView addSubview:_tag2];
    [_backView addSubview:_tag3];
    [_backView addSubview:_searchBtn];
    return self;
}

- (void)updateBtnFrame {
    [_timeBtn sizeToFit];
    [_classBtn sizeToFit];
    [_sectionBtn sizeToFit];
    
    _timeBtn.frame = CGRectMake(_timeImage.frame.origin.x+_timeImage.frame.size.width+_margin1, _timeImage.frame.origin.y, _timeBtn.frame.size.width, _imageWidth);
    _classBtn.frame = CGRectMake(_classImage.frame.origin.x+_classImage.frame.size.width+_margin1, _classImage.frame.origin.y, _classBtn.frame.size.width, _imageWidth);
    _sectionBtn.frame = CGRectMake(_sectionImage.frame.origin.x+_sectionImage.frame.size.width+_margin1, _sectionImage.frame.origin.y, _sectionBtn.frame.size.width, _imageWidth);
    
    _tag1.center = CGPointMake(_timeBtn.frame.origin.x+_timeBtn.frame.size.width+5+_tag1.frame.size.width/2, _timeBtn.frame.origin.y+_timeBtn.frame.size.height/2);
    _tag2.center = CGPointMake(_classBtn.frame.origin.x+_classBtn.frame.size.width+5+_tag2.frame.size.width/2, _classBtn.frame.origin.y+_classBtn.frame.size.height/2);
    _tag3.center = CGPointMake(_sectionBtn.frame.origin.x+_sectionBtn.frame.size.width+5+_tag3.frame.size.width/2, _sectionBtn.frame.origin.y+_sectionBtn.frame.size.height/2);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
