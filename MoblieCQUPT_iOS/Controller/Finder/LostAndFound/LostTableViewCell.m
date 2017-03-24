//
//  LostTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/8.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LostTableViewCell.h"

@implementation LostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.cornerRadius = self.headImageView.size.width/2;
    self.headImageView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
