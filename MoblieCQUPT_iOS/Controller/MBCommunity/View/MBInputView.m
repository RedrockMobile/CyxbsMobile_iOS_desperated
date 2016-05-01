//
//  MBInputView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/27.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBInputView.h"
#import "MBAddPhotoContainerView.h"

@implementation MBInputView

- (instancetype)initWithFrame:(CGRect)frame withInptuViewStyle:(MBInputViewStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        if (style == MBInputViewStyleDefault) {
            _textView = [[MBTextView alloc]initWithFrame:CGRectMake(10, 7, ScreenWidth - 20, frame.size.height - 20)];
            [self addSubview:self.textView];
            _textView.placeholderColor = [UIColor lightGrayColor];
        }else if (style == MBInputViewStyleWithPhoto) {
            _textView = [[MBTextView alloc]initWithFrame:CGRectMake(10, 7, ScreenWidth - 20, 120)];
            [self addSubview:self.textView];
            
            MBAddPhotoContainerView *container = [[MBAddPhotoContainerView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_textView.frame) + 10, ScreenWidth - 20, 200)];
            
            
            NSArray *pic = @[@"图片1.png",@"图片2.png",@"图片3.png",@"图片4.png",@"图片5.png"];
            NSMutableArray *picMutable = [NSMutableArray array];
            for (int i = 0; i < 4; i ++) {
                int index = arc4random()%3;
                [picMutable addObject:pic[index]];
            }
            
            container.sourcePicArray = [picMutable mutableCopy];
            [self addSubview:container];
        }
    }
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
