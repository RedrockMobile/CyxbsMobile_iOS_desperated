//
//  YouWenBottomButtonView.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/4/6.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenBottomButtonView.h"
#import <Masonry.h>

@implementation YouWenBottomButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype) init{
    self = [super init];
    
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] firstObject];
    }
    
    return self;
}

@end
