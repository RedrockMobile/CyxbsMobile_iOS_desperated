//
//  MBTextView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/27.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBTextView.h"

@interface MBTextView ()

@property (strong ,nonatomic) UILabel *placeholderLabel;

@end

@implementation MBTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        [self addSubview:label];
        self.placeholderLabel = label;
        self.placeholderColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:15];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    _placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}
- (void)setText:(NSString *)text {
    [super setText:text];
    [self textDidChange];
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self textDidChange];
}

- (void)textDidChange {
    //hasText BOOL型 如果textView有文字 返回yes 否则 返回no
    self.placeholderLabel.hidden = self.hasText;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect labelSize = [self.placeholderLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.placeholderLabel.font} context:nil];
    
    self.placeholderLabel.frame = (CGRect){{6,7},labelSize.size};
}
//移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
