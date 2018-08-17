//
//  SYCActivityTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCActivityTableViewCell.h"
#import "SYCActivityManager.h"

@implementation SYCActivityTableViewCell

- (void)drawRect:(CGRect)rect{
    self.activity = [SYCActivityManager sharedInstance].activityData[self.row];
    
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
    imageView.image = self.activity.imagesArray[0];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 8.0;
    [backgroundView addSubview:imageView];
    
    CGFloat labelWidth = backgroundViewWidth * 0.4;
    CGFloat labelHeight = backgroundViewHeight * 0.1;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(backgroundViewWidth * 0.04, backgroundViewHeight * 0.5, labelWidth, labelHeight)];
    nameLabel.text = self.activity.name;
    nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    [backgroundView addSubview:nameLabel];
    
    CGFloat textViewWidth = backgroundViewWidth * 0.95;
    CGFloat textViewHeight = backgroundViewHeight * 0.38;
    UITextView *detailText = [[UITextView alloc] initWithFrame:CGRectMake((backgroundViewWidth - textViewWidth) / 2.0, backgroundViewHeight * 0.578, textViewWidth, textViewHeight)];
    detailText.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1.0];
    detailText.font = [UIFont systemFontOfSize:16 weight:UIFontWeightUltraLight];
    detailText.text = self.activity.detail;
    [backgroundView addSubview:detailText];
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
