//
//  MBCommunityCellTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommunityCellTableViewCell.h"
#import "MBPhotoContainerView.h"
//#import "SDWebImageManager.h"

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
    
    //给头像添加点击事件
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tagImageView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeadImageView:)];
    [_headImageView addGestureRecognizer:tagImageView];
    
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
    [_supportBtn setTitleColor:[UIColor colorWithRed:225/255.0 green:65/255.0 blue:35/255.0 alpha:1] forState:UIControlStateSelected];
    _supportBtn.tag = 1;
    [_supportBtn addTarget:self action:@selector(clickSupportBtn) forControlEvents:UIControlEventTouchUpInside];
    
//    _supportImage = [[UIImageView alloc]init];
//    _supportImage.image = [UIImage imageNamed:@"support1.png"];
    _supportImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_supportImage setImage:[UIImage imageNamed:@"support1.png"] forState:UIControlStateNormal];
    [_supportImage setImage:[UIImage imageNamed:@"support.png"] forState:UIControlStateSelected];
    [_supportImage addTarget:self action:@selector(clickSupportBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_commentBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    _commentBtn.tag = 2;
//    [_commentBtn addTarget:self action:@selector(clickSupportBtn) forControlEvents:UIControlEventTouchUpInside];
    
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



- (void)clickSupportBtn {
//    if (_supportImage.selected && _supportBtn.selected) {
//        _supportImage.selected = !_supportImage.selected;
//        _supportBtn.selected = !_supportBtn.selected;
//    }else {
//        _supportImage.selected = !_supportImage.selected;
//        _supportBtn.selected = !_supportBtn.selected;
//    }
    if (self.clickSupportBtnBlock) {
        self.clickSupportBtnBlock(self.supportImage,self.supportBtn,self.subViewFrame);
    }
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
    _model = self.subViewFrame.model;
    UIImage *image = [UIImage imageNamed:@"headImage.png"];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.subViewFrame.model.headImageView] placeholderImage:image];
    _IDLabel.text = self.model.IDLabel;
    _timeLabel.text = self.model.timeLabel;
    _contentLabel.text = self.model.contentLabel;
    _photoContainer.thumbnailPictureArray = self.model.thumbnailPictureArray;
    _photoContainer.picNameArray = self.model.pictureArray;
    
    _supportImage.selected = [self.subViewFrame.model.isMyLike boolValue];
    _supportBtn.selected = [self.subViewFrame.model.isMyLike boolValue];
    [_supportBtn setTitle:self.model.numOfSupport forState:UIControlStateNormal];
    [_commentBtn setTitle:self.model.numOfComment forState:UIControlStateNormal];
    
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

- (void)clickHeadImageView:(UITapGestureRecognizer *)gesture {
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(eventWhenclickHeadImageView:)]) {
        [self.eventDelegate eventWhenclickHeadImageView:self.model];
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
