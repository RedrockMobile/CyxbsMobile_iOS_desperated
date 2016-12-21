//
//  DetailRemindTableViewCell.m
//  Demo
//
//  Created by 李展 on 2016/12/2.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "DetailRemindTableViewCell.h"
#import "UIColor+Hex.h"
@implementation DetailRemindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithHex:@"#f5f5f5"];
    self.stackView.layer.cornerRadius = 4.f;
    self.stackView.layer.masksToBounds = YES;
    self.timeLabel.textColor = [UIColor colorWithHex:@"#42a9fe"];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.weekLabel.textColor = [UIColor colorWithHex:@"#42a3ff"];
    self.weekLabel.font = [UIFont systemFontOfSize:13];
    self.segmentView.backgroundColor = [UIColor colorWithHex:@"#e1e1e1"];
    self.contentLabel.textColor = [UIColor colorWithHex:@"#737373"];
    self.contentLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.remindTimeLabel.textColor = [UIColor colorWithHex:@"#c7c7c7"];
    self.remindTimeLabel.font = [UIFont systemFontOfSize:11];
    self.editView.alpha = 0;
    [self.deleteButton setBackgroundImage:[UIImage imageNamed:@"椭圆"] forState:UIControlStateNormal];
    self.contentLabel.numberOfLines = 0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
