//
//  TimeChooseScrollView.m
//  Demo
//
//  Created by 李展 on 2016/12/8.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "TimeChooseScrollView.h"
#import "UIColor+Hex.h"
@implementation TimeChooseScrollView
- (instancetype)initWithFrame:(CGRect)frame{
    NSArray *timeArray = @[@"不提醒",@"提前五分钟",@"提前十分钟",@"提前二十分钟",@"提前半小时",@"提前一小时"];
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"#fbfbfb"];
        self.btnArray = [NSMutableArray array];
        NSInteger count = timeArray.count;
        CGFloat lbHeight = frame.size.height/count;
        CGFloat lbWidth = frame.size.width;
        
        self.contentSize = CGSizeMake(lbWidth, lbHeight*count);
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        for (NSInteger i = 0; i<count; i++) {
            TickButton *btn = [[TickButton alloc] initWithFrame:CGRectMake(0, i*lbHeight, lbWidth, lbHeight-1)];
            UIView *assitView = [[UIView alloc]initWithFrame:CGRectMake(16, (i+1)*lbHeight-1, lbWidth-32, 1)];
            assitView.backgroundColor = [UIColor colorWithHex:@"#e3e3e3"];
            [btn setTitle:timeArray[i] forState:UIControlStateNormal];
            [self addSubview:btn];
            [self addSubview:assitView];
            [self.btnArray addObject:btn];
            btn.tag = i;
        }
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
