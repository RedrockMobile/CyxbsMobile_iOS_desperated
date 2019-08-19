//
//  SchoolAdressView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/8.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "SchoolAdressView.h"

@implementation SchoolAdressView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    UIView *backgroundView = [[UIView alloc]initWithFrame:frame];
    UIImageView *backgroundImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SchoolAdressBackgroundImg"]];
    [backgroundView addSubview:backgroundImgView];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"重庆邮电大学地址：";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = RGBColor(51, 51, 51, 1);
    UILabel *schoolAdressLabel = [[UILabel alloc] init];
    schoolAdressLabel.text = @"重庆市南岸区南山街道崇文路二号重庆邮电大学";
    schoolAdressLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    schoolAdressLabel.textColor = RGBColor(82, 82, 82, 1);
    
    CGFloat fontSize;
    if(SCREEN_WIDTH > 375){
        fontSize = 16;
    }else{
        fontSize = 14;
    }
        
    schoolAdressLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightThin];
    [backgroundView addSubview:titleLabel];
    [backgroundView addSubview:schoolAdressLabel];
    
    self.schoolAdressBtn = [[UIButton alloc]init];
    [self.schoolAdressBtn setTitle:@"复制地址" forState:UIControlStateNormal];
    [self.schoolAdressBtn setTitleColor:[UIColor colorWithHexString:@"7390ff"] forState:UIControlStateNormal];
    self.schoolAdressBtn.titleLabel.font = [UIFont systemFontOfSize:(fontSize - 1) weight:UIFontWeightRegular];
    [backgroundView addSubview:self.schoolAdressBtn];
    
    [self addSubview:backgroundView];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(15);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-15);
    }];
    [backgroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).offset(0);
        make.left.equalTo(backgroundView).offset(0);
        make.right.equalTo(backgroundView).offset(0);
        make.bottom.equalTo(backgroundView).offset(0);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(backgroundView).offset(23);
        make.left.equalTo(backgroundView).offset(19);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
        
    }];
    [schoolAdressLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(backgroundView).offset(-23);
        make.left.equalTo(backgroundView).offset(19);
        make.width.mas_equalTo(backgroundView.width - 38);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.schoolAdressBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(backgroundView).offset(-10);
        make.centerY.equalTo(titleLabel);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(15);
        
    }];
    [self.schoolAdressBtn.titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.bottom.left.right.equalTo(self.schoolAdressBtn);
        
    }];
    return self;
}

@end
