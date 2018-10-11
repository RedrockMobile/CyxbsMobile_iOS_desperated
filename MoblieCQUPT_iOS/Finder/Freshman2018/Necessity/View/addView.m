//
//  addView.m
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "addView.h"

@implementation addView

- (id)initWithFrame:(CGRect)frame{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(width-100, 10, 80, 40)];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"蓝色添加"] forState:UIControlStateNormal];
        [btn setTitle:@"添加" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:btn];
        self.btn = btn;
        
        
        UITextField *addContent = [[UITextField alloc]initWithFrame:CGRectMake(15, 10, width-135, 40)];
        addContent.borderStyle = UITextBorderStyleRoundedRect;
        addContent.placeholder = @"请输入待办事项(14字以内)";
        [self addSubview:addContent];
        self.addContent = addContent;
    }
    self.backgroundColor = [UIColor whiteColor];
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
