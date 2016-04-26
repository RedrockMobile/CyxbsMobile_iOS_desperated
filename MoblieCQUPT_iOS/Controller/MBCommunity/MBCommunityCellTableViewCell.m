//
//  MBCommunityCellTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommunityCellTableViewCell.h"
#import "MBPhotoContainerView.h"

@interface MBCommunityCellTableViewCell ()

//@property (strong, nonatomic) MBPhotoContainerView *photoContainerView;

@end

@implementation MBCommunityCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadContentView];
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0.5);
        self.layer.shadowOpacity = 0.4;
        self.layer.shadowRadius = 1;
    }
    return self;
}
//初始化UI控件
- (void)loadContentView {
    _headImageView = [[UIImageView alloc]init];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 35/2;
    _headImageView.layer.borderWidth = 0.5;
    _headImageView.layer.borderColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.5].CGColor;
    
    _IDLabel = [[UILabel alloc]init];
    _IDLabel.font = [UIFont systemFontOfSize:16];
    _IDLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:16];
    _contentLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
    _contentLabel.numberOfLines = 0;
    
    _photoContainer = [[MBPhotoContainerView alloc]init];
    
    _supportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _supportBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_supportBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    _supportBtn.tag = 1;
    [_supportBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _supportImage = [[UIImageView alloc]init];
    _supportImage.image = [UIImage imageNamed:@"support1.png"];
    
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_commentBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    _commentBtn.tag = 2;
    [_commentBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _commentImage = [[UIImageView alloc]init];
    _commentImage.image = [UIImage imageNamed:@"comment1.png"];
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.IDLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.photoContainer];
    [self.contentView addSubview:self.supportBtn];
    [self.contentView addSubview:self.supportImage];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.commentImage];
}

- (void)clickBtn:(UIButton *)sender {
    NSLog(@"%@",sender.titleLabel.text);
}

+ (instancetype)cellWithTableView:(MBCommunityTableView *)tableView
{
    static NSString *identify = @"CommunityCell";
    MBCommunityCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[MBCommunityCellTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    return cell;
}

//重写viewModel的set方法 在设置ViewModel的时候 自动进行数据加载
- (void)setSubViewFrame:(MBCommunity_ViewModel *)subViewFrame {
    _subViewFrame = subViewFrame;
    
    //为控件设置数据
    [self setupData];
    //为控件设置frame
    [self setupFrame];
}

- (void)setupData {
    MBCommunityModel *model = self.subViewFrame.model;
    
    _headImageView.image = [UIImage imageNamed:model.headImageView];
    _IDLabel.text = model.IDLabel;
    _timeLabel.text = model.timeLabel;
    _contentLabel.text = model.contentLabel;
    _photoContainer.picNameArray = model.pictureArray;
    [_supportBtn setTitle:model.numOfSupport forState:UIControlStateNormal];
    [_commentBtn setTitle:model.numOfComment forState:UIControlStateNormal];
    
}
- (void)setupFrame {
    _headImageView.frame = self.subViewFrame.headImageViewFrame;
    _IDLabel.frame = self.subViewFrame.IDLabelFrame;
    _timeLabel.frame = self.subViewFrame.timeLabelFrame;
    _contentLabel.frame = self.subViewFrame.contentLabelFrame;
    _photoContainer.frame = self.subViewFrame.photoContainerViewFrame;
    _supportBtn.frame = self.subViewFrame.numOfSupportFrame;
    _supportImage.frame = self.subViewFrame.supportImageFrame;
    _commentBtn.frame = self.subViewFrame.numOfCommentFrame;
    _commentImage.frame = self.subViewFrame.commentImageFrame;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
