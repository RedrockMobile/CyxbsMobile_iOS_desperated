//
//  QRCodeView.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/18.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "QRCodeView.h"


@implementation QRCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *background = [[UIView alloc] init];
        background.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [self addSubview:background];
        self.background = background;
        
        UIButton *cancelButton = [[UIButton alloc] init];
        [self addSubview:cancelButton];
        self.cancelButton = cancelButton;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor whiteColor];
        [self.cancelButton addSubview:imageView];
        self.QRCode = imageView;
    }
    return self;
}

- (void)layoutSubviews {
    self.background.frame = self.frame;
    self.cancelButton.frame = self.frame;
    self.QRCode.frame = CGRectMake(0, 0, MAIN_SCREEN_W * 0.79, MAIN_SCREEN_W * 1.778 * 0.55);
}

@end
