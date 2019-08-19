//
//  OnlineActivitiesCell.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/3.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "OnlineActivitiesCell.h"
//#import <Masonry.h>

@interface OnlineActivitiesCell ()

@end

@implementation OnlineActivitiesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 背景图片
        UIImageView *backgroundIamgeView = [[UIImageView alloc] init];
        UIEdgeInsets edge = UIEdgeInsetsMake(30, 0, 30, 0);
        backgroundIamgeView.image = [UIImage imageNamed:@"背景"];
        self.backgroundIamgeView.image = [self.backgroundIamgeView.image resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
        [self.contentView addSubview:backgroundIamgeView];
        self.backgroundIamgeView = backgroundIamgeView;
        
        // 内容图片
        UIImageView *contentImageVIew = [[UIImageView alloc] init];
        [self.contentView addSubview:contentImageVIew];
        self.contentImageView = contentImageVIew;
        
        // 标题
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel = titleLabel;
        
        // 按钮
        UIButton *joinButton = [[UIButton alloc] init];
        [joinButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
        [joinButton setTitle:@"立即参与" forState:UIControlStateNormal];
        
        joinButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:joinButton];
        self.joinButton = joinButton;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backgroundIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.contentImageView.mas_bottom).offset(20);
    }];
    
    [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentImageView.mas_bottom).offset(12);
        make.bottom.equalTo(self).offset(-18);
        make.right.equalTo(self).offset(-18);
        make.width.equalTo(self).multipliedBy(0.258);
    }];
    
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.bottom.equalTo(self).offset(-60);
    }];
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 15;
    frame.origin.y += 15;
    frame.size.height -= 15;
    frame.size.width -= 30;
    
    [super setFrame:frame];
}

@end
