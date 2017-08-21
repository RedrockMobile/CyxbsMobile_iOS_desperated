//
//  LZConfirmButton.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/4/4.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZConfirmButton.h"

@implementation LZConfirmButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#41a3ff"]] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
