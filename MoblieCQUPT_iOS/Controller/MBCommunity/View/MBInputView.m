//
//  MBInputView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/27.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBInputView.h"


@implementation MBInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textView = [[MBTextView alloc]initWithFrame:CGRectMake(10, 7, ScreenWidth - 20, 120)];
        [self addSubview:self.textView];
        _textView.placeholder = @"和大家一起哔哔叨叨吧";
        _textView.placeholderColor = [UIColor lightGrayColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
