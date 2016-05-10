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
        self.frame = CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50);
        self.backgroundColor = BACK_GRAY_COLOR;
        
        CALayer *line = [[CALayer alloc]init];
        line.frame = CGRectMake(0, 0, ScreenWidth, 0.5);
        line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:236/255.0 alpha:1].CGColor;
        
        
        _textView = [[MBTextView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 20 - 30, 30)];
        _textView.placeholderColor = [UIColor lightGrayColor];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.placeholder = @"评论";
        _textView.layer.cornerRadius = 5;
        
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancle setBackgroundImage:[UIImage imageNamed:@"xia.png"] forState:UIControlStateNormal];
        cancle.backgroundColor = BACK_GRAY_COLOR;
        
        CGFloat btnX = CGRectGetMaxX(_textView.frame);
        
        cancle.frame = CGRectMake(btnX + 10, self.textView.frame.origin.y, 20, 20);
        cancle.center = CGPointMake(CGRectGetMidX(cancle.frame), self.frame.size.height/2);
        
        [cancle addTarget:self action:@selector(clickCancle:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.layer addSublayer:line];
        [self addSubview:cancle];
        [self addSubview:self.textView];
    }
    return self;
}

- (void)clickCancle:(UIButton *)sender {
    [_textView resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, ScreenHeight - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        _textView.placeholder = @"评论";
    }];
}


@end
