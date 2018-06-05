//
//  commitSuccessFrameView.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/6/1.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "commitSuccessFrameView.h"
#import <Masonry.h>

@implementation commitSuccessFrameView

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] firstObject];
    }
    
    return self;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [window addSubview:bgView];
    [bgView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(window);
        make.width.mas_equalTo(@(269/375.0*SCREENWIDTH));
        make.height.mas_equalTo(@(163/667.0*SCREENHEIGHT));
    }];
}

- (void)free {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
