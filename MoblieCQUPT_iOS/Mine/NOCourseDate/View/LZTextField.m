//
//  LZTextField.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/17.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZTextField.h"

@interface LZTextField();
@property UIButton *deleteBtn;
@end

@implementation LZTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.deleteBtn = [[UIButton alloc]init];
        [self addSubview:self.deleteBtn];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.centerY);
            make.width.mas_equalTo(15);
            make.height.mas_equalTo(15);
            make.right.equalTo(self.mas_right).offset(12);
        }];
        [self.deleteBtn addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
- (void)clickDelete{
    self.text = @"";
}

@end
