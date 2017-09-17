//
//  LZPersonAddView.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/21.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZPersonAddView.h"
@interface LZPersonAddView()
@property UILabel *titleLabel;
@property UIImageView *cancelImageView;
@end


@implementation LZPersonAddView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        _titleLabel = [[UILabel alloc]initWithFrame:frame];
        _titleLabel.layer.borderWidth = 1;
        _titleLabel.layer.borderColor = [UIColor colorWithHexString:@"788EFA"].CGColor;
        [_titleLabel setTextColor:[UIColor colorWithHexString:@"788EFA"]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _cancelImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"date_image_cancel"]];
        [self addSubview:_titleLabel];
        [_cancelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(0);
            make.top.mas_offset(0);
            make.height.mas_offset(15);
            make.width.mas_offset(15);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(-15);
            make.right.mas_offset(-15);
            make.left.mas_offset(0);
            make.bottom.mas_offset(0);
        }];
    }
    return self;
}

- (NSString *)title{
    return _titleLabel.text;
}

- (void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
