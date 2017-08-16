//
//  IntroductionTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2017/8/11.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "IntroductionTableViewCell.h"

@implementation IntroductionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)height {
    if (self.contentLabel7.hidden == YES)
        return CGRectGetMaxY(_contentLabel6.frame) + 23;
    else
        return CGRectGetMaxY(_contentLabel7.frame) + 23;
}
@end
