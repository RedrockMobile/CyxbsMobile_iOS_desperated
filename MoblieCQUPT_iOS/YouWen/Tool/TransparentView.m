//
//  TransparentView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/8.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "TransparentView.h"

@implementation TransparentView
- (instancetype)initTheWhiteViewHeight:(CGFloat)height{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        [self setSelf];
        [self setUpWhiteView:height];
    }
    return self;
}
- (void)setSelf{
    self.backgroundColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:0.8];
    self.enableBack = YES;
    UITapGestureRecognizer *touchBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [touchBack setNumberOfTapsRequired:1];
    [self addGestureRecognizer:touchBack];
    
}

- (void)back{
    [self removeFromSuperview];
}
- (void)setEnableBack:(BOOL)enableBack{
    _enableBack = enableBack;
    if (self.enableBack) {
        self.userInteractionEnabled = YES;
    }
    else{
        self.userInteractionEnabled = NO;
    }
}

- (void)setUpWhiteView:(CGFloat)height{
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, height)];
    [UIView animateWithDuration:0.5 animations:^{
        _whiteView.centerY = ScreenHeight - height / 2;
    }];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteView];
}
//不传递
-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == _whiteView) {
        return nil;
    } else {
        return hitView;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
