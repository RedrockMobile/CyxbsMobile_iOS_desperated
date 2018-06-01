//
//  commitSuccessFrameView.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/6/1.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "commitSuccessFrameView.h"

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
    [window addSubview:self];
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
