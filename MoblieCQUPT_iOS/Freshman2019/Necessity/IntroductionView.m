//
//  IntroductionView.m
//  MoblieCQUPT_iOS
//
//  Created by 汪明天 on 2019/8/10.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "IntroductionView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width/375
#define HEIGHT [UIScreen mainScreen].bounds.size.height/667


@implementation IntroductionView
- (id)initWithFrame:(CGRect)frame{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lab2 = [[UILabel alloc] init];
        lab2.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
        lab2.text = @"1.文本框右侧【箭头】查看每一项任务具体详情。\n2.右上角的【编辑】，通过勾选进行选择性删除（未标识可删除圆圈的则为报道必需）。\n3.点击左侧【空方框】勾选该项即为完成，再次单击即可恢复。\n4.右下角【加号】图样可自定义添加新待办。";
        lab2.textColor = [UIColor darkGrayColor];
        lab2.numberOfLines = 0;
        [self setLabelSpace:lab2 withValue:lab2.text withFont:14*HEIGHT];
        CGRect rect = [lab2.text boundingRectWithSize:CGSizeMake(width-150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:self.dic context:nil];
        lab2.frame = CGRectMake(33*WIDTH, 63*HEIGHT, 253*WIDTH, ceil(rect.size.height));
        
        UIImageView *bkg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        bkg.image = [UIImage imageNamed:@"展开白底"];
        [self addSubview:bkg];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(286*WIDTH, 12*HEIGHT, 18*WIDTH, 18*HEIGHT)];
        [btn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        [self addSubview:btn];
        self.btn = btn;
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(124*WIDTH, 30*HEIGHT, 66*WIDTH, 16*HEIGHT)];
        lab1.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14*HEIGHT];
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

#pragma  - 设置label行间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(CGFloat)fontSize {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = 4.0; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    //设置字间距 NSKernAttributeName:@1.5f
    
    self.dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                 };
    
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:self.dic];
    
    label.attributedText = attributeStr;
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
    // Drawing code
//}
//*/

@end
