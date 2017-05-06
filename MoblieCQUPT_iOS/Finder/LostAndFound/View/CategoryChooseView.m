//
//  CategoryChooseView.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/4/3.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "CategoryChooseView.h"
#import "UIColor+Hex.h"
@interface CategoryChooseView()
@property TickButton *selectedBtn;
@end
@implementation CategoryChooseView
- (instancetype)initWithFrame:(CGRect)frame{
    NSArray *categoryArray = @[@"一卡通",@"钱包",@"电子产品",@"书包",@"钥匙",@"雨伞",@"衣物",@"其它"];
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"#fbfbfb"];
        self.btnArray = [NSMutableArray array];
        NSInteger count = categoryArray.count;
        CGFloat lbHeight = frame.size.height/count;
        CGFloat lbWidth = frame.size.width;
        
        self.contentSize = CGSizeMake(lbWidth, lbHeight*count);
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        for (NSInteger i = 0; i<count; i++) {
            TickButton *btn = [[TickButton alloc] initWithFrame:CGRectMake(0, i*lbHeight, lbWidth, lbHeight-1)];
            UIView *assitView = [[UIView alloc]initWithFrame:CGRectMake(16, (i+1)*lbHeight-1, lbWidth-32, 1)];
            assitView.backgroundColor = [UIColor colorWithHex:@"#e3e3e3"];
            [btn setTitle:categoryArray[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self addSubview:assitView];
            [self.btnArray addObject:btn];
            btn.tag = i;
        }
    }
    return self;
}

- (void)click:(TickButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
