//
//  CQUPTTecherCell.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/14.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "CQUPTTecherCell.h"
#import "Masonry.h"
#import "Masonry.h"
@implementation CQUPTTecherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _imagesView1 = [[UIImageView alloc]init];
        _imagesView1.contentMode = UIViewContentModeScaleAspectFill;
        _imagesView1.clipsToBounds = YES;
        _imagesView1.layer.cornerRadius = 6;
        [self.contentView addSubview:_imagesView1];

        _namesLabel1 = [[UILabel alloc] init];
        _namesLabel1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_namesLabel1];
        
        _imagesView2 = [[UIImageView alloc]init];
        _imagesView2.contentMode = UIViewContentModeScaleAspectFill;
        _imagesView2.clipsToBounds = YES;
        _imagesView2.layer.cornerRadius = 6;
        [self.contentView addSubview:_imagesView2];

        _namesLabel2 = [[UILabel alloc] init];
        _namesLabel2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_namesLabel2];

        
        [_imagesView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(15);
            make.width.mas_equalTo(@((ScreenWidth  - 40)/2));
            make.height.mas_equalTo(@((ScreenWidth  - 40)/2 - 20));
            make.left.mas_equalTo(self).offset(15);
        }];
        [_imagesView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(15);
            make.width.mas_equalTo(@((ScreenWidth  - 40)/2));
            make.left.mas_equalTo(_imagesView1.mas_right).offset(10);
            make.height.mas_equalTo(@((ScreenWidth  - 40)/2 - 20));
            make.right.mas_equalTo(self).offset(-15);
  
        }];
        [_namesLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imagesView1.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self.imagesView1.mas_centerX);
            make.width.mas_equalTo(@50);
            make.height.mas_equalTo(@20);
            make.bottom.mas_equalTo(self).offset(-8);
        }];
        [_namesLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imagesView2.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self.imagesView2.mas_centerX);
            make.width.mas_equalTo(@50);
            make.height.mas_equalTo(@20);
            make.bottom.mas_equalTo(self).offset(-8);
        }];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    
    frame.origin.y += 8;
    
    [super setFrame:frame];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
