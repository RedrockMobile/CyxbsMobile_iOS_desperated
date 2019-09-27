//
//  ClassmatesSearchResultCell.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/9/27.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ClassmatesSearchResultCell.h"

@implementation ClassmatesSearchResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:nameLabel];
        nameLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
        self.nameLabel = nameLabel;
        
        UILabel *detaileLabel = [[UILabel alloc] init];
        [self.contentView addSubview:detaileLabel];
        detaileLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
        detaileLabel.font = [UIFont systemFontOfSize:12];
        self.detaileLabel = detaileLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(20);
        make.top.equalTo(self).offset(10);
        make.height.equalTo(@25);
    }];
    
    [self.detaileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.nameLabel);
        make.bottom.equalTo(self).offset(-10);
        make.height.equalTo(@20);
    }];
}

@end
