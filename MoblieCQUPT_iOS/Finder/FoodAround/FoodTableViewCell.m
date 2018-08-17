//
//  FoodTableViewCell.m
//  迎新
//
//  Created by 陈大炮 on 2018/8/15.
//  Copyright © 2018年 陈大炮. All rights reserved.
//

#import "FoodTableViewCell.h"
#define  SCREEN_Width [UIScreen mainScreen].bounds.size.width / 375

@implementation FoodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10 *SCREEN_Width;
    frame.origin.y += 15 * SCREEN_Width;
    frame.size.height -= 30 *SCREEN_Width ;
    frame.size.width -= 30 *SCREEN_Width ;
    [super setFrame:frame];
    self.layer.cornerRadius = 5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
