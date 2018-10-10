//
//  AboutMePraiseTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/8.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "AboutMePraiseTableViewCell.h"

@implementation AboutMePraiseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
//    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
