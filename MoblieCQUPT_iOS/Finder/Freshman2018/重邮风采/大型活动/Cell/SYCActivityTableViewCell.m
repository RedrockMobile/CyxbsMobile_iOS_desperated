//
//  SYCActivityTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCActivityTableViewCell.h"

@implementation SYCActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    CGFloat backgroundViewWidth = [[UIScreen mainScreen] bounds].size.width - 20;
    CGFloat backgroundViewHeight = 400 - 30;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - backgroundViewWidth) / 2.0, (400 - backgroundViewHeight) / 2.0, backgroundViewWidth, backgroundViewHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.masksToBounds = YES;
    backgroundView.layer.cornerRadius = 8.0;
    [self.contentView addSubview:backgroundView];
    self.contentView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    
    CGFloat imageViewWidth = backgroundViewWidth * 0.93;
    CGFloat imageViewHeight = backgroundViewHeight * 0.45;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((backgroundViewWidth - imageViewWidth) / 2.0, backgroundViewHeight * 0.035, imageViewWidth, imageViewHeight)];
    imageView.image = [UIImage imageNamed:@"111.JPG"];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 8.0;
    [backgroundView addSubview:imageView];
    
    CGFloat labelWidth = backgroundViewWidth * 0.2;
    CGFloat labelHeight = backgroundViewHeight * 0.1;
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(backgroundViewWidth * 0.04, backgroundViewHeight * 0.5, labelWidth, labelHeight)];
    namelabel.text = @"十大歌手";
    namelabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    [backgroundView addSubview:namelabel];
    
    CGFloat textViewWidth = backgroundViewWidth * 0.95;
    CGFloat textViewHeight = backgroundViewHeight * 0.38;
    UITextView *detailText = [[UITextView alloc] initWithFrame:CGRectMake((backgroundViewWidth - textViewWidth) / 2.0, backgroundViewHeight * 0.578, textViewWidth, textViewHeight)];
    detailText.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1.0];
    detailText.font = [UIFont systemFontOfSize:16 weight:UIFontWeightUltraLight];
    detailText.text = @"“校园十大歌手赛”是由重庆邮电大学学生会承办，自1993年起举办的一项传统文娱活动，举办频率为两年一届，自开展以来一直以来深受广大师生欢迎，为广大学生展示青春才华，增进沟通交流搭建了平台。每届十大歌手举办时，不论从最初的线下海选还是到最终的决赛汇演，都为同学们所津津乐道，大家饱满的参与积极度为我们带来了一届又一届令人赞叹的歌声。";
    [backgroundView addSubview:detailText];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
