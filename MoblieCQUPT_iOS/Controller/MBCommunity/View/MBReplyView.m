//
//  MBReplyView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/5/8.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBReplyView.h"


@interface MBReplyView ()

@end

@implementation MBReplyView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, ScreenHeight - 55, ScreenWidth, 55);
        self.backgroundColor = BACK_GRAY_COLOR;
        _textView = [[MBTextView alloc]initWithFrame:CGRectMake(5, 10, ScreenWidth - 10, 30)];
        _textView.placeholderColor = [UIColor lightGrayColor];
        [self addSubview:self.textView];
    }
    return self;
}


@end
