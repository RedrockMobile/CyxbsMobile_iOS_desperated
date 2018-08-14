//
//  IntroductionView.m
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "IntroductionView.h"

@implementation IntroductionView

- (id)initWithFrame:(CGRect)frame{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lab2 = [[UILabel alloc] init];
        lab2.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        lab2.text = @"1.文本框右侧【箭头】查看每一项任务具体详情。\n2.右上角的【编辑】，通过勾选进行选择性删除（未标识可删除圆圈的则为报道必需）。\n3.点击左侧【空方框】勾选该项即为完成，再次单击即可恢复。\n4.右下角【加号】图样可自定义添加新待办。";
        lab2.textColor = [UIColor darkGrayColor];
        lab2.numberOfLines = 0;
        CGRect rect = [lab2.text boundingRectWithSize:CGSizeMake(width-150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:15]} context:nil];
        lab2.frame = CGRectMake(33, 73, width-150, ceil(rect.size.height));
        
        UIImageView *bkg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, self.frame.size.width, self.frame.size.height-20)];
        bkg.image = [UIImage imageNamed:@"白底"];
        [self addSubview:bkg];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(width-120, 20, 20, 20)];
        [btn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        [self addSubview:btn];
        self.btn = btn;
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(width/2-80, 40, 80, 16)];
        lab1.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:17];
        lab1.text = @"功能介绍";
        lab1.textColor = [UIColor darkGrayColor];
        [self addSubview:lab1];
        self.lab1 = lab1;
        
        
        [self addSubview:lab2];
        self.lab2 = lab2;
    }
    self.backgroundColor = [UIColor clearColor];
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
