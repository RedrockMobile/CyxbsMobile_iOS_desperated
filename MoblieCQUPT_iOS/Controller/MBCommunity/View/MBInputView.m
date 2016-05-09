//
//  MBInputView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/27.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBInputView.h"
#import "MBAddPhotoContainerView.h"

@interface MBInputView ()


@end

@implementation MBInputView

- (instancetype)initWithFrame:(CGRect)frame withInptuViewStyle:(MBInputViewStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        if (style == MBInputViewStyleDefault) {
            _textView = [[MBTextView alloc]initWithFrame:CGRectMake(10, 7, ScreenWidth - 20, frame.size.height - 20)];
            [self addSubview:self.textView];
            _textView.placeholderColor = [UIColor lightGrayColor];
        }else if (style == MBInputViewStyleWithPhoto) {
            _textView = [[MBTextView alloc]initWithFrame:CGRectMake(10, 7, ScreenWidth - 20, 120)];
            [self addSubview:self.textView];
            
            _container = [[MBAddPhotoContainerView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_textView.frame) + 10, ScreenWidth - 20, 200)];
            
            
            
            [self addSubview:self.container];
        }
    }
    return self;
}

- (void)layoutSubviews {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(self.container.frame) + 10);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
