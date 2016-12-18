//
//  WeekScrollView.m
//  Demo
//
//  Created by 李展 on 2016/11/8.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "WeekScrollView.h"
#import "UIImage+Color.h"
#import "UIColor+Hex.h"
@implementation WeekScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (void)setFrame:(CGRect)frame{
//    self
//}
- (instancetype)initWithFrame:(CGRect)frame{
    NSArray *weekArray = @[@"整学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周",@"第十九周",@"第二十周"];
    self = [super initWithFrame:frame];
    if (self) {
        self.btnArray = [NSMutableArray array];
        NSInteger weekNum = weekArray.count;
        CGFloat lbHeight = frame.size.height/7.f;
        CGFloat lbWidth = frame.size.width;
        
        self.contentSize = CGSizeMake(lbWidth, lbHeight*weekNum);
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        for (NSInteger i = 0; i<weekNum; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, i*lbHeight, lbWidth, lbHeight)];
            [btn setTitle:weekArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHex:@"#343434"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHex:@"#ffffff"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor colorWithHex:@"#ffffff"] forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor colorWithHex:@"#ffffff"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor colorWithHex:@"#ffffff"] forState:UIControlStateHighlighted|UIControlStateSelected];
            
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#41a2ff"]] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#41a2ff"]] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#41a2ff"]] forState:UIControlStateSelected|UIControlStateHighlighted];
            [self addSubview:btn];
            [self.btnArray addObject:btn];
        }
    }
    return  self;
}

@end
