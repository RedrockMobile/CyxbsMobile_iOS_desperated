//
//  YouWenAdoptFrame.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/5/30.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenAdoptFrame.h"
#import <Masonry.h>

@interface YouWenAdoptFrame()
@property (strong, nonatomic) UIView *bgView;
@end

@implementation YouWenAdoptFrame

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] firstObject];
        self.confirmBtn.backgroundColor = [UIColor colorWithRed:150/255.0 green:157/255.0 blue:254/255.0 alpha:1];
        [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return self;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [window addSubview:self.bgView];
    [self.bgView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(window);
        make.width.mas_equalTo(@(269/375.0*SCREEN_WIDTH));
        make.height.mas_equalTo(@(163/667.0*SCREEN_HEIGHT));
    }];
}

- (void)free {
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
}

@end
