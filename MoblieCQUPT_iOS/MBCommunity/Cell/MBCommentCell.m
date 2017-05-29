//
//  MBCommentCell.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/25.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommentCell.h"

@implementation MBCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadContentView];
        self.contentView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    }
    return self;
}

+ (instancetype)cellWithTableView:(MBCommunityTableView *)tableView
{
    static NSString *identify = @"commentCell";
    MBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[MBCommentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    return cell;
}

- (void)loadContentView {
    _headImageView = [[UIImageView alloc]init];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 30/2;
    _headImageView.layer.borderWidth = 0.5;
    _headImageView.layer.borderColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.5].CGColor;
    
    //给评论的头像添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeadImageView:)];
    _headImageView.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:tap];
    
    _IDLabel = [[UILabel alloc]init];
    _IDLabel.font = [UIFont systemFontOfSize:13];
    _IDLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:11];
    _timeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
    _contentLabel.numberOfLines = 0;
    
    _underLine = [[UIView alloc]init];
    _underLine.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.IDLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.underLine];
}

- (void)setViewModel:(MBComment_ViewModel *)viewModel {
    _viewModel = viewModel;
    [self setupData];
    [self setupFrame];
    
}

- (void)setupData {
    _model = self.viewModel.model;
    UIImage *image = [UIImage imageNamed:@"headImage.png"];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.model.photo_src] placeholderImage:image];
    _IDLabel.text = self.model.nickname;
    _timeLabel.text = self.model.created_time;
    _contentLabel.text = self.model.content;
}

- (void)setupFrame {
    _headImageView.frame = self.viewModel.headImageViewFrame;
    _IDLabel.frame = self.viewModel.IDLabelFrame;
    _timeLabel.frame = self.viewModel.timeLabelFrame;
    _contentLabel.frame = self.viewModel.contentLabelFrame;
    _underLine.frame = CGRectMake(0, self.viewModel.cellHeight - 1, ScreenWidth, 1);
}

- (void)clickHeadImageView:(UITapGestureRecognizer *)gesture {
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(commentEvenWhenClickHeadImageView:)]) {
        [self.eventDelegate commentEvenWhenClickHeadImageView:self.model];
    }
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
