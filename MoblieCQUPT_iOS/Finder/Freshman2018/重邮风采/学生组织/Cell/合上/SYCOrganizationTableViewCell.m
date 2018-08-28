//
//  SYCOrganizationTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/16.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCOrganizationTableViewCell.h"
#import "SYCOrganizationManager.h"

@implementation SYCOrganizationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect{
    CGFloat backgroundViewWidth = self.frame.size.width * 0.95;
    CGFloat backgroundViewHeight = self.frame.size.height * 0.95;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - backgroundViewWidth) / 2.0, (self.frame.size.height - backgroundViewHeight) / 2.0, backgroundViewWidth, backgroundViewHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.masksToBounds = YES;
    backgroundView.layer.cornerRadius = 8.0;
    [self.contentView addSubview:backgroundView];
    self.contentView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    backgroundView.layer.shadowOffset = CGSizeMake(2, 5);
    backgroundView.layer.shadowOpacity = 0.1;
    backgroundView.layer.shadowColor = [UIColor grayColor].CGColor;
    
    
    CGFloat imageViewWidth = SCREENWIDTH * 0.9;
    CGFloat imageViewHeight = imageViewWidth * 0.5625;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018%@", self.organization.imagesURLs[0]]]];
    UIImage *image = [UIImage imageWithData: imageData];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((backgroundViewWidth - imageViewWidth) / 2.0, (backgroundViewWidth - imageViewWidth) / 2.0, imageViewWidth, imageViewHeight)];
    imageView.image = image;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 8.0;
    [backgroundView addSubview:imageView];
    
    CGFloat labelWidth = backgroundViewWidth * 0.8;
    CGFloat labelHeight = backgroundViewHeight * 0.03;
    CGFloat labelX = (backgroundViewWidth - imageViewWidth) / 2.0;
    CGFloat labelY = (backgroundViewWidth - imageViewWidth) / 2.0 + imageViewHeight + backgroundViewHeight * 0.04;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
    nameLabel.text = self.organization.name;
    nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    [backgroundView addSubview:nameLabel];
    
    CGFloat textWidth = backgroundViewWidth * 0.95;
    CGFloat textX = (backgroundViewWidth - imageViewWidth) / 2.0;
    CGFloat textY = labelY + labelHeight + backgroundViewHeight * 0.03;
    UILabel *detailText = [[UILabel alloc] initWithFrame:CGRectMake(textX, textY, textWidth, 0)];
    detailText.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1.0];
    detailText.font = [UIFont systemFontOfSize:16 weight:UIFontWeightUltraLight];
    detailText.text = self.organization.detail;
    detailText.numberOfLines = 8;
    [detailText sizeToFit];
    [backgroundView addSubview:detailText];
    
    CGFloat btnWidth = backgroundViewWidth * 0.07;
    CGFloat btnHeight = btnWidth * 0.5625;
    CGFloat btnX = (backgroundViewWidth - btnWidth) / 2.0;
    CGFloat btnY = backgroundViewHeight -  backgroundViewWidth * 0.1;
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX , btnY, btnWidth, btnHeight)];;
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
    [backgroundView addSubview:moreBtn];
}
@end
