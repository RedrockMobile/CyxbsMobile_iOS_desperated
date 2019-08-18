//
//  RecommendedRouteHeaderView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/9.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "RecommendedRouteHeaderView.h"

@implementation RecommendedRouteHeaderView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = [UIColor colorWithHexString:@"f9fcff"];
//    backgroundView.layer.borderWidth = 1;
//    backgroundView.layer.borderColor =  [UIColor colorWithHexString:@"d2deff"].CGColor;
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = RGBColor(51, 51, 51, 1);
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [backgroundView addSubview:titleLabel];
    
    UIImageView *img = [[UIImageView alloc]init];
    if(tag == 0){
        [img setImage:[UIImage imageNamed:@"BusRouteDownArrow"]];
    }else{
        [img setImage:[UIImage imageNamed:@"BusRouteUpArrow"]];
    }
    [backgroundView addSubview:img];
    [self addSubview:backgroundView];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
    }];
    [titleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).with.offset(19);
        make.left.equalTo(backgroundView).offset(19);
        make.right.equalTo(img.mas_left).offset(-5);
        make.bottom.equalTo(backgroundView).offset(-15);
    }];
    [img  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).offset(20);
        make.right.equalTo(backgroundView).offset(-24);
        //        make.centerY.mas_equalTo(self.centerY);
        make.height.mas_equalTo(8);
        make.width.mas_equalTo(12);
        
    }];
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
