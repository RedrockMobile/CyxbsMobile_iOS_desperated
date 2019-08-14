//
//  YouWenDeatilHeadViewBottomView.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/3/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenDeatilHeadViewBottomView.h"

@implementation YouWenDeatilHeadViewBottomView


- (instancetype) init {
    self = [super init];
    
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] firstObject];
        self.genderImageview.contentMode = UIViewContentModeScaleAspectFit;
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
