//
//  LZTextField.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/17.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZTextField.h"

@interface LZTextField();
@property UIButton *deleteBtn;
@end

@implementation LZTextField

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
    
        self.deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 15+10, 15)];
        [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"date_image_cancel"] forState:UIControlStateNormal];
        self.deleteBtn.contentMode = UIViewContentModeCenter;
        self.rightView = self.deleteBtn;
        
        self.rightViewMode = UITextFieldViewModeWhileEditing;
//        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(self.mas_centerY);
//            make.width.mas_equalTo(15);
//            make.height.mas_equalTo(15);
//            make.right.equalTo(self.mas_right).offset(-12);
//        }];
        [self.deleteBtn addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 18, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 18, 0);
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.size.width-10-15, bounds.size.height/2-15.0/2, 15, 15);
}

- (void)clickDelete{
    self.text = @"";
}

@end
