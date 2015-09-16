//
//  ORWInputTextView.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/16.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "ORWInputTextView.h"

@implementation ORWInputTextView


- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.borderWidth =1;
    self.layer.borderColor = RGBColor(202, 202, 202, 1).CGColor;
    self.layer.cornerRadius = 1;
    [self addSubview:self.placeHolderLabel];
    
    _placeHolderLabel.font = [UIFont fontWithName:@"Helvetica" size:14];


}





- (void)setPlaceHolder:(NSString *)placeHolder{
    [self.placeHolderLabel setText:@""];
    _placeHolderLabel.text = [placeHolder copy];
    _placeHolder = placeHolder;
    
    CGSize maximumSize = CGSizeMake(self.frame.size.width-16, self.frame.size.height-16);

    CGRect stringRect= [_placeHolder boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:14]} context:nil];
    CGRect finalFrame = CGRectMake(8, 8,  stringRect.size.width, stringRect.size.height);
    _placeHolderLabel.frame = finalFrame;
}

- (UILabel *)placeHolderLabel{
    if (!_placeHolderLabel) {
        
        _placeHolderLabel= [[UILabel alloc]initWithFrame:CGRectMake(8, 8, self.frame.size.width-16, self.frame.size.height-16)];
        
        _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.textAlignment = 0;
        _placeHolderLabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        

//        [_placeHolderLabel sizeThatFits:];
//        _placeHolderLabel.backgroundColor = [UIColor blackColor];
        
    }
    return _placeHolderLabel;
}

@end
