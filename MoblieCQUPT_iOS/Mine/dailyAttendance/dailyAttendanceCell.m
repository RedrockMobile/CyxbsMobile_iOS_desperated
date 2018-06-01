//
//  dailyAttendanceCellTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/1.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "dailyAttendanceCell.h"

@implementation dailyAttendanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
