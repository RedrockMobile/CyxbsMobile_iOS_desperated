//
//  LZLostRemindView.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/4/4.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZLostRemindView.h"
#import "LZConfirmButton.h"

@implementation LZLostRemindView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc]init];
        self.btn = [[LZConfirmButton alloc]init];
        self.label = [[UILabel alloc]init];
        [self addSubview:self.imageView];
        [self addSubview:self.btn];
        [self addSubview:self.label];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:16];
        self.label.textColor = [UIColor colorWithHexString:@"595959"];
        [self.btn setTitle:@"确定" forState:UIControlStateNormal];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (void)layoutSubviews{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(self.height*0.14);
        make.bottom.equalTo(self.label.mas_top).offset(-self.height*0.06);
        
        make.left.equalTo(self.mas_left).offset(self.width*0.13);
        make.right.equalTo(self.mas_right).offset(-self.width*0.13);
        make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(0.75);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.btn.mas_top).offset(-self.height*0.1);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);

//make.left.equalTo(self.mas_left).offset(self.width*0.36);
//        make.right.equalTo(self.mas_right).offset(-self.width*0.36);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-self.height*0.09);
        
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(self.btn.mas_width).multipliedBy(0.15);
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
