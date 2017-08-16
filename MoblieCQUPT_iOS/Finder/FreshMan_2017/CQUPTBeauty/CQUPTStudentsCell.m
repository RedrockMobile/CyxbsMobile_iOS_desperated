//
//  CQUPTStudentsCell.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/7.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "CQUPTStudentsCell.h"
#import "Masonry.h"
@implementation CQUPTStudentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:
            reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加控件
        _imagesView = [[UIImageView alloc]init];
        [_imagesView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _imagesView.contentMode =UIViewContentModeScaleAspectFill;
        CGFloat fromH = 10;
        CGFloat fromW = 26;
        _imagesView.layer.cornerRadius = 35;
        _imagesView.clipsToBounds = YES;
        [self.contentView addSubview: _imagesView];
        
        _idLabel = [[UILabel alloc]init];
        _idLabel.textColor = [UIColor blackColor];
        _idLabel.font = [UIFont systemFontOfSize:17* SCREENWIDTH / 375];
        [self.contentView addSubview:_idLabel];
        
        _contextLabel = [[UILabel alloc]init];
        _contextLabel.textColor = COLOR_NONEED;
        _contextLabel.font = [UIFont systemFontOfSize:13* SCREENWIDTH / 375];
        [self.contentView addSubview:_contextLabel];
        
        UILabel *award = [[UILabel alloc] init];
        award.text = @"颁奖词:";
        award.textColor = COLOR_NONEED;
        award.font = [UIFont systemFontOfSize:13* SCREENWIDTH / 375];
        [self.contextLabel addSubview:award];
        
        UIImageView * lab= [[UIImageView alloc] init];
        lab.image = [UIImage imageNamed:@"pointer"];
        [self addSubview:lab];
        
        _cutline = [[UILabel alloc] init];
        _cutline.backgroundColor = COLOR_NONEED;
        [self.contentView addSubview:_cutline];
        
        [_imagesView mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.width.equalTo(@70);
            maker.left.equalTo(self).offset(fromW);
            maker.top.equalTo(self).offset(fromH);
            maker.bottom.equalTo(self).offset(-fromH);
        }];
        
        [_idLabel mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.bottom.equalTo(self.mas_centerY).offset(-5);
            maker.left.mas_equalTo(self.imagesView.mas_right).offset(14);
            maker.height.equalTo(@17);
        }];
        [award mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.idLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self.imagesView.mas_right).offset(14);
            make.width.mas_equalTo(@(52* SCREENWIDTH / 375));
        }];
        [ _contextLabel mas_makeConstraints:^(MASConstraintMaker *maker){

            maker.top.mas_equalTo(self.idLabel.mas_bottom).offset(10);
            maker.left.mas_equalTo(award.mas_right).offset(0);
            maker.right.mas_equalTo(self.mas_right).offset(-55);
        }];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_contextLabel.mas_right).offset(10);
            make.top.mas_equalTo(self).offset(35);
            make.bottom.mas_equalTo(self).offset(-35);
            make.right.mas_equalTo(self).offset(-35);
        }];
        [_cutline mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.height.mas_equalTo(1);
            maker.bottom.equalTo(self).offset(0);
            maker.right.equalTo(self).offset(-fromW);
            maker.left.equalTo(self).offset(fromW);
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
