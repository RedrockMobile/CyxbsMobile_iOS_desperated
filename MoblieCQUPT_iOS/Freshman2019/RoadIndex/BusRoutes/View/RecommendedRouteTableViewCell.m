//
//  RecommendedRouteTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/11.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "RecommendedRouteTableViewCell.h"

@implementation RecommendedRouteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.roadLabel = [[UILabel alloc]init];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.roadLabel = [[UILabel alloc]init];
    self.roadLabel.numberOfLines = 0;
    _roadLabel.font = [UIFont systemFontOfSize:12];
    _roadLabel.textColor = RGBColor(102, 102, 102, 1);
    [self addSubview:self.roadLabel];
    
    [self.roadLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(19);
        make.right.equalTo(self).offset(-72);
        make.bottom.equalTo(self).offset(-10);
    }];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.roadLabel = [[UILabel alloc]init];
    self.roadLabel.numberOfLines = 0;
    _roadLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.roadLabel];
    
    [self.roadLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(19);
        make.right.equalTo(self).offset(-19);
        make.bottom.equalTo(self).offset(-10);
    }];
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
