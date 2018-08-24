//
//  SYCCollageTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/22.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCCollageTableViewCell.h"

@implementation SYCCollageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect{
    self.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    self.contentView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    
    CGFloat backgroundWidth = self.frame.size.width * 0.9;
    CGFloat backgroundHeight = self.frame.size.height * 0.8;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - backgroundWidth) / 2.0, (self.frame.size.height - backgroundHeight) / 2.0, backgroundWidth, backgroundHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = 6.0;
    backgroundView.layer.shadowOffset = CGSizeMake(2, 5);
    backgroundView.layer.shadowOpacity = 0.1;
    backgroundView.layer.shadowColor = [UIColor grayColor].CGColor;
    [self addSubview:backgroundView];
    
    CGFloat labelWidth = self.frame.size.width * 0.9;
    CGFloat labelHeight = self.frame.size.height * 0.7;
    UILabel *collageNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.08, (self.frame.size.height - labelHeight) / 2.0, labelWidth, labelHeight)];
    collageNameLabel.text = self.collageName;
    collageNameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
    [self addSubview:collageNameLabel];
    
    CGFloat imageWidth = self.frame.size.width * 0.02;
    CGFloat imageHeight = imageWidth * 1.95;
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.9, (self.frame.size.height - imageHeight) / 2.0, imageWidth, imageHeight)];
    arrowImage.image = [UIImage imageNamed:@"backPoint"];
    [self addSubview:arrowImage];
}

@end
