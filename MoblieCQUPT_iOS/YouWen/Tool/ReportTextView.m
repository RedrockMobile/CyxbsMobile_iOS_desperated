//
//  ReportTextView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ReportTextView.h"

#define WORDNUMWIDTH self.width / 5
#define DEFINECOLOR [UIColor colorWithHexString:@"999999"];
@interface ReportTextView()<UITextViewDelegate>
@property (assign, nonatomic) wordNumState wnState;
@property (assign, nonatomic) NSInteger topicLen;
@property (strong, nonatomic) NSMutableArray<NSString *> *topicArray;
@property (strong, nonatomic) NSMutableAttributedString *nowString;
@end
@implementation ReportTextView
- (UITextView *)initWithFrame:(CGRect)frame andState:(wordNumState)state{
    self = [super initWithFrame:frame];
    if (self) {
        _topicLen = 0;
        self.scrollEnabled = NO;
        _wnState = state;
        _nowString = [[NSMutableAttributedString alloc] init];
        self.textContainerInset = UIEdgeInsetsMake(10, 0, 0, 0);
        self.font = [UIFont fontWithName:@"Arial" size: 16];
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

- (NSMutableArray *)topicArray{
    if (!_topicArray) {
        _topicArray = [NSMutableArray array];
    }
    return _topicArray;
}

- (UILabel *)wordNum{
    if (!_wordNum) {
        int wordNumHeight = (self.height > 20)?20:self.height;
        self.wordNum = [[UILabel alloc] initWithFrame:CGRectMake(self.width - WORDNUMWIDTH - 10, self.height - wordNumHeight, WORDNUMWIDTH, wordNumHeight)];
        self.wordNum.textColor = DEFINECOLOR;
        self.wordNum.font = [UIFont fontWithName:@"Arial" size:13];
        self.wordNum.textAlignment = NSTextAlignmentRight;
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
        self.placeHolder = [[myUILabel alloc] initWithFrame: CGRectMake(4, 10, self.size.width - 4, self.size.height / 2)];
        self.placeHolder.font = self.font;
        self.placeHolder.textColor = DEFINECOLOR;
        self.placeHolder.numberOfLines = 0;
        self.placeHolder.textAlignment = NSTextAlignmentLeft;
        [self.placeHolder setVerticalAlignment:VerticalAlignmentTop];
    }
    return _placeHolder;
}

- (void)textViewDidChange:(UITextView *)textView{
    [self calculateNum:textView.text];
}

- (void)calculateNum:(NSString *)str{
    NSUInteger Num;
    self.placeHolder.hidden = YES;
    NSInteger flag = -1;
    for (int i = 0; i < _topicArray.count; i ++){
        NSRange range = [str rangeOfString:_topicArray[i]];
        if (range.location == NSNotFound) {
            flag = i;
            break;
        }
    }
    if (flag != -1) {
        NSMutableString *mstr = self.nowString.string.mutableCopy;
        NSRange range = [mstr rangeOfString:_topicArray[flag]];
        [mstr deleteCharactersInRange:range];
        NSMutableAttributedString *sub = [[NSMutableAttributedString alloc]initWithString:mstr];
        _topicLen -= _topicArray[flag].length;
        [sub addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"7195FA"] range:NSMakeRange(0, _topicLen)];
        self.attributedText = sub;
        [_topicArray removeObjectAtIndex:flag];
        Num = self.attributedText.length;
    }
    else {
        NSMutableAttributedString *sub = [[NSMutableAttributedString alloc]initWithString:str];
        [sub addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"7195FA"] range:NSMakeRange(0, _topicLen)];
        self.attributedText = sub;
        Num = self.attributedText.length;
    }
    if (Num <= _limitNum) {
        if (_wnState == OnlyWordNum){
            self.wordNum.text = [NSString stringWithFormat:@"%lu", (unsigned long)Num];
        }
        else if (_wnState == CountWordNum){
            self.wordNum.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)Num, (long)_limitNum];
        }
        if (Num == 0) {
            self.placeHolder.hidden = NO;
        }
    }
    else{
        if (_wnState == OnlyWordNum){
            self.attributedText = [self.attributedText attributedSubstringFromRange:NSMakeRange(0, _limitNum)];
            self.wordNum.text = [NSString stringWithFormat:@"%ld", (long)_limitNum];
        }
        else if (_wnState == CountWordNum){
            self.attributedText = [self.attributedText attributedSubstringFromRange:NSMakeRange(0, _limitNum)];
            self.wordNum.text = [NSString stringWithFormat:@"%ld/%ld", (long)_limitNum, (long)_limitNum];
        }
    }
    _nowString = self.attributedText.mutableCopy;
}

- (void)addTopic:(NSString *)subject{
    NSMutableAttributedString *sub = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@", subject, self.text]];
    _topicLen += subject.length;
    [self.topicArray appendObject:subject];
    [sub addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"7195FA"] range:NSMakeRange(0, _topicLen)];
    NSInteger Num = sub.length;
    if (Num < _limitNum) {
        self.attributedText = sub;
        if (_wnState == OnlyWordNum){
            self.wordNum.text = [NSString stringWithFormat:@"%lu", (unsigned long)Num];
        }
        else if (_wnState == CountWordNum){
            self.wordNum.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)Num, (long)_limitNum];
        }
        self.placeHolder.hidden = YES;
    }
    _nowString = self.attributedText.mutableCopy;
}

- (CGRect)zoomFrame:(CGRect)frame{
    CGRect newFrame;
    newFrame.origin.x = frame.origin.x;
    newFrame.origin.y = frame.origin.y;
    newFrame.size.height = frame.size.height / SCREEN_RATE;
    newFrame.size.width = frame.size.width / SCREEN_RATE;
    return newFrame;
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self calculateNum:text];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
