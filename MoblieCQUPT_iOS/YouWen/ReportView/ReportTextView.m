//
//  ReportTextView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ReportTextView.h"
#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)
#define ZOOM(x) x / SCREEN_RATE
#define WORDNUMWIDTH self.width / 5
@interface ReportTextView()<UITextViewDelegate>

@property (assign, nonatomic) wordNumState wnState;
@end
@implementation ReportTextView
- (UITextView *)initWithFrame:(CGRect)frame andState:(wordNumState)state{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = NO;
        _wnState = state;
        self.font = [UIFont fontWithName:@"Arial" size: ZOOM(15)];
        if (_wnState == NoneWordNum) {
            _placeHolder.hidden = YES;
        }
        else{
            _limitNum = 200;
            self.delegate = self;
            [self addSubview:self.wordNum];
            [self addSubview:self.placeHolder];
        }
    }
    return self;
}

-(UILabel *)wordNum{
    if (!_wordNum) {
        int wordNumHeight = (self.height > 20)?20:self.height;
        self.wordNum = [[UILabel alloc] initWithFrame:CGRectMake(self.width - WORDNUMWIDTH - 10, self.height - wordNumHeight , WORDNUMWIDTH, wordNumHeight)];
        self.wordNum.textAlignment = NSTextAlignmentJustified    ;
        switch (_wnState) {
            case 0:
                self.wordNum.hidden = YES;
                break;
            case 1:
                self.wordNum.text = @"0";
                break;
            case CountWordNum:
                self.wordNum.text = [NSString stringWithFormat:@"0/%ld", (long)_limitNum];
                break;
            default:
                break;
        }
        
    }
    return _wordNum;
}

- (UILabel *)placeHolder{
    if (!_placeHolder) {
        self.placeHolder = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, self.size.width - 20, self.size.height / 2)];
        self.placeHolder.textColor = [UIColor grayColor];
        self.placeHolder.numberOfLines = 0;
        self.placeHolder.textAlignment = NSTextAlignmentLeft;
    }
    return _placeHolder;
}

- (void)textViewDidChange:(UITextView *)textView{
    NSUInteger Num = textView.text.length;
    if (Num <= _limitNum) {
        if (_wnState == OnlyWordNum){
            self.wordNum.text = [NSString stringWithFormat:@"%lu", (unsigned long)Num];
        }
        else if (_wnState == CountWordNum){
            self.wordNum.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)Num, (long)_limitNum];
        }
    }
    else if (Num == 0) {
        self.placeHolder.hidden = NO;
    }
    else{
        if (_wnState == OnlyWordNum){
            self.text = [self.text substringToIndex:_limitNum];
            self.wordNum.text = [NSString stringWithFormat:@"%ld", (long)_limitNum];
        }
        else if (_wnState == CountWordNum){
            self.text = [self.text substringToIndex:_limitNum];
            self.wordNum.text = [NSString stringWithFormat:@"%ld/%ld", (long)_limitNum, (long)_limitNum];
        }
        
    }
}

- (CGRect)zoomFrame:(CGRect)frame{
    CGRect newFrame;
    newFrame.origin.x = frame.origin.x;
    newFrame.origin.y = frame.origin.y;
    newFrame.size.height = frame.size.height / SCREEN_RATE;
    newFrame.size.width = frame.size.width / SCREEN_RATE;
    return newFrame;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
