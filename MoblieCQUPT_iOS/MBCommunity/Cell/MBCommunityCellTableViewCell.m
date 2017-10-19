//
//  MBCommunityCellTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommunityCellTableViewCell.h"
#import "MBPhotoContainerView.h"
#import "MBCommunityHandle.h"
@interface MBCommunityCellTableViewCell ()

//@property (strong, nonatomic) MBPhotoContainerView *photoContainerView;
@property (strong, nonatomic) UIImageView *extendBtnImageView;

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
    _IDLabel.font = [UIFont systemFontOfSize:14];
    _IDLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    
    _contentLabel = [[YYLabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    _contentLabel.userInteractionEnabled = NO;
    _contentLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1];

    
    _photoContainer = [[MBPhotoContainerView alloc]init];
    
    _extendLabel = [[UILabel alloc] init];
    _extendLabel.userInteractionEnabled = YES;
    _extendLabel.hidden = YES;
//    UITapGestureRecognizer *tapExtendLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapExtendLabel:)];
//    [_extendLabel addGestureRecognizer:tapExtendLabel];
    
    _dottedLineImageView = [[UIImageView alloc] init];
    
    _upvoteBtn = [[UIButton alloc] init];
    [_upvoteBtn addTarget:self action:@selector(tapUpvoteBtn) forControlEvents:UIControlEventTouchDown];
    
    _numOfUpvoteLabel = [[UILabel alloc] init];
    _numOfUpvoteLabel.font = [UIFont systemFontOfSize:14];
    _numOfUpvoteLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    
    _commentImageView = [[UIImageView alloc] init];
    
    _numOfCommentLabel = [[UILabel alloc] init];
    _numOfCommentLabel.font = [UIFont systemFontOfSize:14];
    _numOfCommentLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    
    _extendBtnImageView = [[UIImageView alloc] init];
    
    /*
    _supportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _supportBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_supportBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [_supportBtn setTitleColor:[UIColor colorWithRed:225/255.0 green:65/255.0 blue:35/255.0 alpha:1] forState:UIControlStateSelected];
    _supportBtn.tag = 1;
    [_supportBtn addTarget:self action:@selector(clickSupportBtn) forControlEvents:UIControlEventTouchUpInside];
    */
    
    //    _supportImage = [[UIImageView alloc]init];
    //    _supportImage.image = [UIImage imageNamed:@"support1.png"];
    /*
    _supportImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_supportImage setImage:[UIImage imageNamed:@"support1.png"] forState:UIControlStateNormal];
    [_supportImage setImage:[UIImage imageNamed:@"support.png"] forState:UIControlStateSelected];
    [_supportImage addTarget:self action:@selector(clickSupportBtn) forControlEvents:UIControlEventTouchUpInside];
    */
    
    /*
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_commentBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    _commentBtn.tag = 2;
    */
    
    //    [_commentBtn addTarget:self action:@selector(clickSupportBtn) forControlEvents:UIControlEventTouchUpInside];
    /*
    _commentImage = [[UIImageView alloc]init];
    _commentImage.image = [UIImage imageNamed:@"comment1.png"];
    */
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.IDLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.photoContainer];
    [self.contentView addSubview:self.extendLabel];
    [self.contentView addSubview:self.dottedLineImageView];
    [self.contentView addSubview:self.upvoteBtn];
    [self.contentView addSubview:self.numOfUpvoteLabel];
    [self.contentView addSubview:self.commentImageView];
    [self.contentView addSubview:self.numOfCommentLabel];
    [self.extendLabel addSubview:self.extendBtnImageView];
//    [self.contentView addSubview:self.supportBtn];
    //[self.contentView addSubview:self.supportImage];
//    [self.contentView addSubview:self.commentBtn];
    //[self.contentView addSubview:self.commentImage];
}

//- (void)tapExtendLabel:(UITapGestureRecognizer *)sender {
//    self.model.cellIsOpen = !self.model.cellIsOpen;
//}

- (void)tapUpvoteBtn  {
    self.numOfUpvoteLabel.text = [MBCommunityHandle clickUpvoteBtn:self.superview.viewController currentUpvoteNum:[self.numOfUpvoteLabel.text intValue]  upvoteIsSelect:self.subViewFrame.model.is_my_like viewModel:self.subViewFrame];
    if (self.subViewFrame.model.is_my_like == NO) {
        [self.upvoteBtn setImage:[UIImage imageNamed:@"icon_upvote_outside_notselect"] forState:UIControlStateNormal];
        self.numOfUpvoteLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    } else {
        [self.upvoteBtn setImage:[UIImage imageNamed:@"icon_upvote_outside_selected"] forState:UIControlStateNormal];
        self.numOfUpvoteLabel.textColor = [UIColor colorWithRed:120/255.0 green:142/255.0 blue:250/255.0 alpha:1];
    }
//    [self setupData];
//    [self setupFrame];
}

/*
- (void)clickSupportBtn {
    if (self.clickSupportBtnBlock) {
        self.clickSupportBtnBlock(self.supportImage,self.supportBtn,self.subViewFrame);
    }
}
*/

+ (instancetype)cellWithTableView:(MBCommunityTableView *)tableView type:(MBCommunityCellType)type row:(NSInteger)row
{
    static NSString *identify = @"CommunityCell";
    MBCommunityCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[MBCommunityCellTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    cell.type = type;
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
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.subViewFrame.model.user_photo_src] placeholderImage:image];
    _IDLabel.text = self.model.nickname;
    _timeLabel.text = self.model.time;
    
    if (self.type == MBCommunityViewCellDetail) {
        _contentLabel.text = self.model.detailContent;
    }
    else{
        _contentLabel.text = self.model.content;
        
        self.dottedLineImageView.image = [UIImage imageNamed:@"dottedLine"];
        self.numOfUpvoteLabel.text = [self.subViewFrame.model.like_num stringValue];
        self.extendLabel.font = [UIFont systemFontOfSize:14];
        self.extendLabel.textColor = [UIColor colorWithRed:120/255.0 green:142/255.0 blue:250/255.0 alpha:1];
        
        //展开
        CGFloat height = [self.model.content boundingRectWithSize:CGSizeMake(SCREENWIDTH-18, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        CGFloat twoLinesHeight = [UIFont systemFontOfSize:14].lineHeight * 2;
        
        if (height <= twoLinesHeight) {
            self.extendLabel.hidden = YES;
        } else {
            if (self.model.cellIsOpen == NO) {
                self.extendLabel.hidden = NO;
                self.extendLabel.text = @"展开";
                self.extendBtnImageView.image = [UIImage imageNamed:@"icon_down"];
            } else {
                self.extendLabel.hidden = NO;
                self.extendLabel.text = @"收起";
                self.extendBtnImageView.image = [UIImage imageNamed:@"icon_up"];
            }
        }
        
        if (self.model.is_my_like == YES) {
            [self.upvoteBtn setImage:[UIImage imageNamed:@"icon_upvote_outside_selected"] forState:UIControlStateNormal];
            self.numOfUpvoteLabel.textColor = [UIColor colorWithRed:120/255.0 green:142/255.0 blue:250/255.0 alpha:1];
        } else {
            [self.upvoteBtn setImage:[UIImage imageNamed:@"icon_upvote_outside_notselect"] forState:UIControlStateNormal];
            self.numOfUpvoteLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        }
        
        self.numOfUpvoteLabel.text = [self.model.like_num stringValue];
        self.commentImageView.image = [UIImage imageNamed:@"icon_comment_outside"];
        self.numOfCommentLabel.text = [self.model.remark_num stringValue];
    }
    NSError *error;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self.contentLabel.text];
    //正则匹配
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#.+?#"                                options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:self.contentLabel.text options:0 range:NSMakeRange(0, [self.contentLabel.text length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            
            [attributedStr setTextHighlightRange:resultRange color:[UIColor colorWithHexString:@"41a3ff"] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                //                NSLog(@"test");
            }];
            
        }
        //        NSLog(@"%@",error);
    }
//    attributedStr.font = self.contentLabel.font;
    [attributedStr setFont:[UIFont systemFontOfSize:14]];
    self.contentLabel.attributedText = attributedStr;
    
    _photoContainer.thumbnailPictureArray = self.model.articleThumbnailPictureArray;
    _photoContainer.picNameArray = self.model.articlePictureArray;
//    _supportImage.selected = self.subViewFrame.model.is_my_like;
    /*
    _supportBtn.selected = self.subViewFrame.model.is_my_like;
    [_supportBtn setTitle:self.model.like_num.stringValue forState:UIControlStateNormal];
    [_commentBtn setTitle:self.model.remark_num.stringValue forState:UIControlStateNormal];
    */
}
- (void)setupFrame {
    _headImageView.frame = self.subViewFrame.headImageViewFrame;
    _IDLabel.frame = self.subViewFrame.IDLabelFrame;
    _timeLabel.frame = self.subViewFrame.timeLabelFrame;
    if (self.type == MBCommunityViewCellDetail) {
        _contentLabel.frame = self.subViewFrame.detailContentLabelFrame;
        /*
        _supportBtn.frame = self.subViewFrame.detailNumOfSupportFrame;
         */
//        _supportImage.frame = self.subViewFrame.detailSupportImageFrame;
        /*
        _commentBtn.frame = self.subViewFrame.detailNumOfCommentFrame;
         */
//        _commentImage.frame = self.subViewFrame.detailCommentImageFrame;
        _photoContainer.frame = self.subViewFrame.detailPhotoContainerViewFrame;
    }
    else{
        CGFloat height = [self.model.content boundingRectWithSize:CGSizeMake(self.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        if (self.model.cellIsOpen == NO) {
            if (height > _contentLabel.font.lineHeight * 2) {
                self.extendLabel.hidden = NO;
                _contentLabel.numberOfLines = 2;
                _contentLabel.frame = self.subViewFrame.coverContentLabelFrame;
            } else {
  
                _extendLabel.hidden = YES;
                _contentLabel.frame = self.subViewFrame.contentLabelFrame;
            }
            
            self.upvoteBtn.frame = self.subViewFrame.upvotebtnFrame;
            self.numOfUpvoteLabel.frame = self.subViewFrame.numOfUpvoteFrame;
            self.commentImageView.frame = self.subViewFrame.commentImageviewFrame;
            self.numOfCommentLabel.frame = self.subViewFrame.numOfCommentFrame;
            self.extendLabel.frame = self.subViewFrame.extendLabelFrame;
            _photoContainer.frame = self.subViewFrame.photoContainerViewFrame;
            _extendBtnImageView.frame = CGRectMake(CGRectGetMaxX(_extendLabel.frame)-20, (self.extendLabel.height - 5) / 2.0, 12, 5);
            self.dottedLineImageView.frame = self.subViewFrame.dottedLineImageViewFrame;
            
        } else {
            _contentLabel.numberOfLines = 0;
            _contentLabel.frame = self.subViewFrame.extend_contentLabelFrame;
            _upvoteBtn.frame = self.subViewFrame.extend_upvotebtnFrame;
            _numOfUpvoteLabel.frame = self.subViewFrame.extend_numOfUpvoteFrame;
            _commentImageView.frame = self.subViewFrame.extend_commentImageviewFrame;
            _numOfCommentLabel.frame = self.subViewFrame.extend_numOfCommentFrame;
            _extendLabel.frame = self.subViewFrame.extend_extendLabelFrame;
            _photoContainer.frame = self.subViewFrame.extend_photoContainerViewFrame;
            _extendBtnImageView.frame = CGRectMake(CGRectGetMaxX(_extendLabel.frame)-20, (self.extendLabel.height - 5) / 2.0, 12, 5);
            _dottedLineImageView.frame = self.subViewFrame.extend_dottedLineImageViewFrame;
        }

        /*
        _supportBtn.frame = self.subViewFrame.numOfSupportFrame;
         */
//        _supportImage.frame = self.subViewFrame.supportImageFrame;
        /*
        _commentBtn.frame = self.subViewFrame.numOfCommentFrame;
         */
//        _commentImage.frame = self.subViewFrame.commentImageFrame;
        }
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
