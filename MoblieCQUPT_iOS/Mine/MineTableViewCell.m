//
//  MineTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/18.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.accessoryType = UITableViewCellAccessoryNone;
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    
    _backgroudView.layer.masksToBounds = YES;
    _backgroudView.layer.cornerRadius = 15.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
