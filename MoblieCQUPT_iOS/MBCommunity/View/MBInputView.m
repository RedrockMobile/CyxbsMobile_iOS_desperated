//
//  MBInputView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/27.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBInputView.h"
#import "MBAddPhotoContainerView.h"
#import <Masonry.h>
@interface MBInputView ()


@end

@implementation MBInputView

- (instancetype)initWithFrame:(CGRect)frame withInptuViewStyle:(MBInputViewStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        self.addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 12, 90, 20)];
        self.addBtn .titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.addBtn  setTitle:@"添加话题 #" forState:UIControlStateNormal];
        [self.addBtn  setTitleColor:[UIColor colorWithHexString:@"41a3ff"] forState:UIControlStateNormal];
        [self.addBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:self.addBtn];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.addBtn.bounds
             byRoundingCorners:UIRectCornerBottomRight |UIRectCornerTopRight
               cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor clearColor].CGColor;
        maskLayer.lineWidth = 1;
        maskLayer.strokeColor = [UIColor colorWithRGB:0xe3e3e5 alpha:1].CGColor;
        maskLayer.path = maskPath.CGPath;
        maskLayer.frame = self.addBtn.bounds;
        [self.addBtn.layer addSublayer:maskLayer];
      
        if (style == MBInputViewStyleDefault) {
            _textView = [[MBTextView alloc]initWithFrame:CGRectMake(12, 37, ScreenWidth - 24, frame.size.height - 20)];
            [self addSubview:self.textView];
            _textView.placeholderColor = [UIColor lightGrayColor];
        }else if (style == MBInputViewStyleWithPhoto) {
            _textView = [[MBTextView alloc]initWithFrame:CGRectMake(12, 37, ScreenWidth - 24, 0.26*ScreenHeight)];
            [self addSubview:self.textView];
            _container = [[MBAddPhotoContainerView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_textView.frame) + 10, ScreenWidth - 24, 1000)];
            
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
