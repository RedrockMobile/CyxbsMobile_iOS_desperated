//
//  ExamScheduleTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 2016/12/15.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "ExamScheduleTableViewCell.h"

@implementation ExamScheduleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
