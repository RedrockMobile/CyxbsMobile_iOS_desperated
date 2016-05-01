//
//  MBInputView.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/27.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBTextView.h"

typedef NS_ENUM(NSInteger, MBInputViewStyle) {
    MBInputViewStyleDefault, //普通的输入框
    MBInputViewStyleWithPhoto, //带照片的输入框
};


@interface MBInputView : UIView

@property (strong, nonatomic) MBTextView *textView;

@property (assign, nonatomic) MBInputViewStyle style;

- (instancetype)initWithFrame:(CGRect)frame withInptuViewStyle:(MBInputViewStyle)style;


@end
