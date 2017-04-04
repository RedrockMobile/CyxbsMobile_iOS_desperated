//
//  LZDatePicker.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/4/3.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZDatePickerDelegate<NSObject>
- (void)touchBtn:(UIButton *)btn;

@end

@interface LZDatePicker : UIView
@property id <LZDatePickerDelegate> delegate;
@property NSDate *date;

@end
