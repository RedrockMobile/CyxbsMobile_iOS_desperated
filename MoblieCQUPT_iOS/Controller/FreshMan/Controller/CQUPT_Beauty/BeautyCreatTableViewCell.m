//
//  BeautyCreatTableViewCell.m
//  FreshManFeature
//
//  Created by hzl on 16/8/11.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "BeautyCreatTableViewCell.h"
#define maxScreenHeight [UIScreen mainScreen].bounds.size.height
#define maxScreenWdith [UIScreen mainScreen].bounds.size.width

@implementation BeautyCreatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
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

- (void)setUpUi
{
    _idLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.365 * maxScreenWdith, 0.045 * maxScreenHeight, 0.629 * maxScreenWdith, 0.022 * maxScreenHeight)];
    _idLabel.font = [UIFont systemFontOfSize:15];
    _idLabel.backgroundColor = [UIColor whiteColor];
    
    _videoView = [[UIImageView alloc] initWithFrame:CGRectMake(0.048 * maxScreenWdith, 0, 0.277 * maxScreenWdith, 0.166 * maxScreenHeight)];
    
    _videoView.layer.cornerRadius = 12;
    _videoView.layer.masksToBounds = YES;
    
    _introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake (0.365 * maxScreenWdith, 0.090 * maxScreenHeight, 0.629 * maxScreenWdith, 0.019 * maxScreenHeight)];
    _introduceLabel.font = [UIFont systemFontOfSize:13];
    _introduceLabel.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.365 * maxScreenWdith, 0.120 * maxScreenHeight, 0.354 * maxScreenWdith, 0.019 * maxScreenHeight)];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1];
    
    [self.contentView addSubview:_videoView ];
    [self.contentView addSubview:_idLabel];
    [self.contentView addSubview:_introduceLabel];
    [self.contentView addSubview:_timeLabel];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"cell";
    BeautyCreatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[BeautyCreatTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identify];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
