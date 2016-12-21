//
//  RemindTableViewCell.m
//  Demo
//
//  Created by 李展 on 2016/11/26.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "RemindTableViewCell.h"
#import <Masonry.h>
@implementation RemindTableViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
    self.contentLabel.preferredMaxLayoutWidth = self.contentLabel.frame.size.width;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentLabel.numberOfLines = 0;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"箭头"]];
    __weak typeof (self) weakSelf = self;
    [self addSubview:self.accessoryView];
    [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.centerY.equalTo(self.contentLabel);
    }];
                                       
    self.tintColor = [UIColor colorWithRed:65/255.f green:163/255.f blue:255/255.f alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.textAlignment = NSTextAlignmentRight;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
