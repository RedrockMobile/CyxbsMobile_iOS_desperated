//
//  OriginazitionCell.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/11.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "OriginazitionCell.h"
#import "PrefixHeader.pch"
#import "Masonry.h"
@implementation OriginazitionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setCell];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identify = @"cell";
    OriginazitionCell * cell = [[OriginazitionCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[OriginazitionCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identify];
    }
    return cell;
}
- (void)setCell{
    _namesLabel = [[UILabel alloc] init];
    _namesLabel.font = [UIFont systemFontOfSize:18*SCREENWIDTH/375];
    [self.contentView addSubview:_namesLabel];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.font =[UIFont systemFontOfSize:15*SCREENWIDTH/375];
    _detailLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.67];
    _detailLabel.numberOfLines = 0;
    [self.contentView addSubview:_detailLabel];
    
    _cutLine = [[UIView alloc]init];
    _cutLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
    _cutLine.width = 2;
    [self addSubview:_cutLine];
    
    [_namesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(20);
        make.height.mas_equalTo(@20);
        make.left.mas_equalTo(self).offset(25);
        make.right.mas_equalTo(self).offset(-25);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.namesLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self).offset(25);
        make.right.mas_equalTo(self).offset(-25);
        make.bottom.mas_equalTo(self).offset(-15);
    }];
    
    [_cutLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self).offset(0);
        make.right.equalTo(self).offset(-26);
        make.left.equalTo(self).offset(26);
    }];
}
- (void)setFrame:(CGRect)frame{
    frame.origin.y += 8;
    [super setFrame:frame];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:
     reuseIdentifier];
    if (self) {
        [self setCell];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
