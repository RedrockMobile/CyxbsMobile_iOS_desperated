//
//  LZSearchView.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/17.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZSearchView.h"
#import "LZTextField.h"
@interface LZSearchView()<UITextFieldDelegate>
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

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    [self.textField becomeFirstResponder];
//    return YES;
//}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textField = [[LZTextField alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        self.textField.delegate = self;
        self.cancelBtn = [[UIButton alloc]init];
        self.addBtn = [[UIButton alloc]init];
        [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
        self.addBtn.backgroundColor = [UIColor whiteColor];
        self.cancelBtn.backgroundColor = [UIColor whiteColor];
        self.textField.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 2;
        self.addBtn.layer.cornerRadius = 2;
        self.cancelBtn.layer.cornerRadius = 2;
        self.textField.layer.cornerRadius = 2;
        
        [self addSubview:self.textField];
        [self addSubview:self.addBtn];
        [self addSubview:self.cancelBtn];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(30*SCREEN_HEIGHT/667);
            make.height.mas_equalTo(40*SCREEN_HEIGHT/667);
            make.left.mas_equalTo(self.mas_left).offset(18);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.right.mas_equalTo(self.mas_right).offset(-18);
        }];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.addBtn.mas_width);
            make.height.mas_equalTo(self.textField.mas_height);
            make.centerY.mas_equalTo(self.addBtn.mas_centerY);
            make.left.mas_equalTo(18);
            make.right.mas_equalTo(self.addBtn.mas_left).offset(-20);
            make.bottom.mas_equalTo(-30*SCREEN_HEIGHT/667);
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

- (NSString *)text{
    return self.textField.text;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField resignFirstResponder];
}
//- (void)setPlcaeHolderTextColor:(UIColor *)plcaeHolderTextColor{
//    self.textField.attributedPlaceholder.color = plcaeHolderTextColor;
//}

@end
