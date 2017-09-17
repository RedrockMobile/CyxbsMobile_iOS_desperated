//
//  LZSearchView.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/17.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZSearchView.h"
#import "LZTextField.h"
@interface LZSearchView()
@property (nonatomic, strong) LZTextField *textField;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *addBtn;
@end
@implementation LZSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textField = [[LZTextField alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        self.cancelBtn = [[UIButton alloc]init];
        self.addBtn = [[UIButton alloc]init];
        [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:self.textField];
        [self addSubview:self.addBtn];
        [self addSubview:self.cancelBtn];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(30);
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(self.mas_left).offset(18);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.right.mas_equalTo(self.mas_right).offset(-18);
        }];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.addBtn.mas_width);
            make.height.mas_equalTo(self.textField.mas_height);
            make.centerX.mas_equalTo(self.centerX);
            make.left.mas_equalTo(18);
            make.right.mas_equalTo(self.addBtn.mas_left).offset(-20);
        }];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.textField.mas_height);

            make.right.mas_equalTo(-18);
        }];
        
    }
    return self;
}

- (void)cancelAction{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)addAction{
    if (self.addBlock) {
        self.addBlock();
    }
}

- (UIColor *)cancelBtnTextColor{
    return self.cancelBtn.currentTitleColor;
}

- (UIColor *)addBtnTextColor{
    return self.addBtn.currentTitleColor;
}
- (UIColor *)textFieldTextColor{
    return self.textField.textColor;
}
//- (UIColor *)plcaeHolderTextColor{
//    return self.textField.attributedPlaceholder.color;
//}

- (void)setCancelBtnTextColor:(UIColor *)cancelBtnTextColor{
    [self.cancelBtn setTitleColor:cancelBtnTextColor forState:UIControlStateNormal];
}

- (void)setAddBtnTextColor:(UIColor *)addBtnTextColor{
    [self.addBtn setTitleColor:addBtnTextColor forState:UIControlStateNormal];
}

- (void)setTextFieldTextColor:(UIColor *)textFieldTextColor{
    self.textField.textColor = textFieldTextColor;
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    self.textField.placeholder = placeHolder;
}

- (NSString *)placeHolder{
    return self.textField.placeholder;
}

//- (void)setPlcaeHolderTextColor:(UIColor *)plcaeHolderTextColor{
//    self.textField.attributedPlaceholder.color = plcaeHolderTextColor;
//}

@end
