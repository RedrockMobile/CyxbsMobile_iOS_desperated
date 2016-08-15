//
//  BeautyCquptTableViewCell.m
//  FreshManFeature
//
//  Created by hzl on 16/8/12.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "BeautyCquptTableViewCell.h"
#define maxScreenHeight [UIScreen mainScreen].bounds.size.height
#define maxScreenWdith [UIScreen mainScreen].bounds.size.width

@implementation BeautyCquptTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"cell";
    BeautyCquptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell)
    {
        cell = [[BeautyCquptTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identify];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setUpUi
{
    _introduceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, maxScreenWdith-30, 150)];
    _introduceImageView.contentMode = UIViewContentModeScaleAspectFill;
    _introduceImageView.layer.cornerRadius = 12;
    _introduceImageView.layer.masksToBounds = YES;
    
    _introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_introduceImageView.frame)+15, _introduceImageView.frame.size.width, 0)];
    _introduceLabel.font = [UIFont systemFontOfSize:15];
    _introduceLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    _introduceLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_introduceImageView];
    [self.contentView addSubview:_introduceLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUpUi];
    }
    return self;
}




@end
