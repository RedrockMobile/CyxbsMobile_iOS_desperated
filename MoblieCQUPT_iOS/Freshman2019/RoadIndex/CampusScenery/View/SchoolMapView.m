//
//  SchoolMapView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/9.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "SchoolMapView.h"

@implementation SchoolMapView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    UIView *backgroundView = [[UIView alloc]initWithFrame:frame];
    UIImageView *backgroundImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SchoolMapBackgroundImg"]];
//    backgroundImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:backgroundImgView];
    [backgroundView addSubview:backgroundImgView];
    
    self.mapView = [[UIImageView alloc]init];

    self.mapView.layer.borderWidth = 1;
    self.mapView.layer.borderColor =  [UIColor colorWithHexString:@"d2deff"].CGColor;
    self.mapView.contentMode = UIViewContentModeScaleAspectFill;
    self.mapView.clipsToBounds = YES;
    [backgroundView addSubview:self.mapView];
    self.mapView.userInteractionEnabled = YES;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"重邮2D地图";
    titleLabel.textColor = RGBColor(51, 51, 51, 0.8);
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    [backgroundView addSubview:titleLabel];
    
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.textColor = RGBColor(51, 51, 51, 0.8);
    textLabel.text = @"重邮全景地图前往发现查看(发现→重邮地图)";
    CGFloat fontSize;
    if(SCREEN_WIDTH > 375){
        fontSize = 14;
    }else{
        fontSize = 13;
    }
    
    textLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightThin];
    [backgroundView addSubview:textLabel];
    
    [self addSubview:backgroundView];

    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(0);
    }];
    
    [backgroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).offset(0);
        make.left.equalTo(backgroundView).offset(0);
        make.right.equalTo(backgroundView).offset(0);
        make.bottom.equalTo(backgroundView).offset(0);
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).offset(15);
        make.left.equalTo(backgroundView).offset(15);
        make.right.equalTo(backgroundView).offset(-15);
        make.bottom.equalTo(backgroundView).offset(-65);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mapView.mas_bottom).offset(10);
        make.left.equalTo(backgroundView).offset(15);
        make.right.equalTo(backgroundView).offset(-15);
        make.height.mas_equalTo(14);
    }];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(-3);
        make.left.equalTo(backgroundView).offset(15);
        make.right.equalTo(backgroundView).offset(-15);
        make.bottom.equalTo(backgroundView).offset(-10);
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
