//
//  UITextField+Empty.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/7.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "UITextField+Empty.h"
#import "ExamPickView.h"
@implementation UITextField(Empty)
- (UITextField *)initWithPlaceHolder:(NSString *)string andFrame:(CGRect)frame{
       self = [[UITextField alloc]initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];

    self.placeholder = string;
    self.font = [UIFont fontWithName:@"Arial" size:14];
    self.textAlignment = NSTextAlignmentLeft;
    UIImageView *backPoint = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 24, 17, 7, 14)];
    backPoint.image = [UIImage imageNamed:@"backPoint"];
    [self addSubview:backPoint];
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
