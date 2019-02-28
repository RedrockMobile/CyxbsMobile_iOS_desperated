//
//  LZDatePicker.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/4/3.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZDatePicker.h"
@interface LZDatePicker()
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *saveBtn;
@end
@implementation LZDatePicker
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 0, frame.size.width/8, frame.size.height/6)];
        self.saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/8*7-16, 0, frame.size.width/8, frame.size.height/6)];
        self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, frame.size.height/5, frame.size.width, frame.size.height/6*5)];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.saveBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"41a3ff"] forState:UIControlStateNormal];
        [self.saveBtn setTitleColor:[UIColor colorWithHexString:@"41a3ff"] forState:UIControlStateNormal];
        [self.saveBtn addTarget:self action:@selector(saveDate:) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn addTarget:self action:@selector(saveDate:) forControlEvents:UIControlEventTouchUpInside];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        [self addSubview:self.datePicker];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.saveBtn];
    }
    return self;
}
- (void)saveDate:(UIButton *)btn{
    if ([btn.currentTitle isEqualToString:@"确定"]) {
        self.date = self.datePicker.date;
    }
    if ([self.delegate respondsToSelector:@selector(touchBtn:)]) {
        [self.delegate touchBtn:btn];
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
