//
//  SchoolPicCollectionViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/9.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "SchoolPicCollectionViewCell.h"

@implementation SchoolPicCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.layer.borderWidth = 1;
    self.layer.borderColor =  [UIColor colorWithHexString:@"d2deff"].CGColor;
    self.imageView = [[UIImageView alloc]init];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.borderColor =  [UIColor colorWithHexString:@"d2deff"].CGColor;
    [self addSubview:self.imageView];
    
    self.titlelabel = [[UILabel alloc]init];
    self.titlelabel.textColor = RGBColor(51, 51, 51, 0.7);
    self.titlelabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.titlelabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self).offset(6);
        make.left.equalTo(self).offset(6);
        make.right.equalTo(self).offset(-6);
        make.bottom.equalTo(self).offset(-30);
    }];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.imageView.mas_bottom).offset(6);
        make.left.equalTo(self).offset(6);
        make.right.equalTo(self).offset(-6);
        make.bottom.equalTo(self).offset(-6);
    }];
    return self;
}
@end
