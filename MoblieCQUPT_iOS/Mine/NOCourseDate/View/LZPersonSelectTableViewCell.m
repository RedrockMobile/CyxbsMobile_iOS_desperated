//
//  LZPersonSelectTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/22.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZPersonSelectTableViewCell.h"

@implementation LZPersonSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.majorLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.stuNumLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.majorLabel.font = [UIFont systemFontOfSize:13];
    self.stuNumLabel.font = [UIFont systemFontOfSize:13];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
