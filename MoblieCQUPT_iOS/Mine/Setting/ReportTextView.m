//
//  ReportTextView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ReportTextView.h"
@interface ReportTextView()<UITextViewDelegate>
@property (strong, nonatomic) UILabel *wordNum;
@property (strong, nonatomic) UILabel *placeHolder;
@end
@implementation ReportTextView
- (UITextView *)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSelf];
        self.delegate = self;
        [self setCountWordNumLabel];
    }
    return self;
}

-(void)setSelf{
    self.font = [UIFont fontWithName:@"Arial" size:20];

}
- (void)setCountWordNumLabel{
    self.wordNum = [[UILabel alloc] initWithFrame:CGRectMake(self.right - 80, self.bottom - 50, 60, 40)];
    self.wordNum.text = @"0/200";
    [self addSubview:self.wordNum];
    
    self.placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    self.placeHolder.textColor = [UIColor grayColor];
    self.placeHolder.text = @"请输入内容";
    [self addSubview:self.placeHolder];
}

- (void)textViewDidChange:(UITextView *)textView{
    NSUInteger Num = textView.text.length;
    self.placeHolder.hidden = YES;
    if (Num <= 200) {
        self.wordNum.text = [NSString stringWithFormat:@"%lu/200", (unsigned long)Num];
    }
    else if (Num == 0) {
        self.placeHolder.hidden = NO;
    }
    else{
        self.text = [self.text substringToIndex:200];
        self.wordNum.text = @"200/200";
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
