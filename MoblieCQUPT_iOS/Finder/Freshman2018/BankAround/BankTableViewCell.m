//
//  BankTableViewCell.m
//  迎新
//
//  Created by 陈大炮 on 2018/8/17.
//  Copyright © 2018年 陈大炮. All rights reserved.
//

#import "BankTableViewCell.h"

@implementation BankTableViewCell

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 15;
    frame.origin.y += 15;
    frame.size.height -= 20;
    frame.size.width -= 30;
    [super setFrame:frame];
    
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
