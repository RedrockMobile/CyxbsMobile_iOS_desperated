//
//  LostAndFoundButton.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/30.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LostAndFoundButton.h"

@implementation LostAndFoundButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
 
        [self setBackgroundColor:[UIColor colorWithHexString:@"#d9d9d9"]];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#41a3ff"]] forState:UIControlStateSelected];
        
        [self setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)select:(LostAndFoundButton *)sender{
    sender.selected = !sender.selected;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
