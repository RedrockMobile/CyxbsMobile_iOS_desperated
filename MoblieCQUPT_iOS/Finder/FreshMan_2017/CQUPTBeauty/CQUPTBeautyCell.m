//
//  CQUPTBeautyCell.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/8.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "CQUPTBeautyCell.h"
#import "Masonry.h"
#import "BigView.h"
@implementation CQUPTBeautyCell
- (void)awakeFromNib {
    [super awakeFromNib];

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _imagesView = [[BigView alloc]init];
        _imagesView.contentMode = UIViewContentModeScaleAspectFill;
        _imagesView.layer.cornerRadius = 8;
        _imagesView.clipsToBounds = YES;
        [self.contentView addSubview:_imagesView];
        
        _namesLabel = [[UILabel alloc] init];
        _namesLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_namesLabel];
        
        _contextsLabel = [[UILabel alloc] init];
        _contextsLabel.numberOfLines = 0;
        _contextsLabel.font = [UIFont systemFontOfSize:13];
        _contextsLabel.textColor = COLOR_NONEED;
        [self.contentView addSubview:_contextsLabel];
        
        [_imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(15);
            make.centerX.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-15);
            make.height.mas_equalTo(@200);
            make.left.mas_equalTo(self).offset(15);
        }];
        [_namesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-215);
            make.left.mas_equalTo(self).offset(15);
            make.height.mas_equalTo(@20);
        }];
        [_contextsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.namesLabel.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-15);
            make.left.mas_equalTo(self).offset(15);
            make.bottom.mas_equalTo(self).offset(-10);
        }];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    
    frame.origin.y += 8;

    frame.size.height -= 8;
    
    [super setFrame:frame];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
