//
//  WillCopy.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/5.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "WillCopy.h"
//#import <Masonry.h>

@interface WillCopy ()

@property (nonatomic, weak) UIView *messageWindow;

@end

@implementation WillCopy

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        
        UIView *messageWindow = [[UIView alloc] init];
        messageWindow.backgroundColor = [UIColor whiteColor];
        messageWindow.layer.borderWidth = 1;
        messageWindow.layer.borderColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1].CGColor;
        [self addSubview:messageWindow];
        self.messageWindow = messageWindow;
        
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        cancel.titleLabel.font = [UIFont systemFontOfSize:16];
        cancel.layer.borderWidth = 1;
        cancel.layer.borderColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1].CGColor;
        [self.messageWindow addSubview:cancel];
        self.cancel = cancel;
        
        UIButton *certain = [UIButton buttonWithType:UIButtonTypeCustom];
        [certain setTitle:@"复制" forState:UIControlStateNormal];
        [certain setTitleColor:[UIColor colorWithRed:70/255.0 green:114/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        certain.titleLabel.font = [UIFont systemFontOfSize:16];
        certain.layer.borderWidth = 1;
        certain.layer.borderColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1].CGColor;
        
        [self.messageWindow addSubview:certain];
        self.certain = certain;
        
        UILabel *academy = [[UILabel alloc] init];
        academy.font = [UIFont systemFontOfSize:15];
        academy.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        academy.numberOfLines = 0;
        academy.textAlignment = NSTextAlignmentCenter;
        [self.messageWindow addSubview:academy];
        self.academy = academy;
        
        UILabel* groupNumber = [[UILabel alloc] init];
        groupNumber.font = [UIFont systemFontOfSize:15];
        academy.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [self.messageWindow addSubview:groupNumber];
        self.groupNumber = groupNumber;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = [UIScreen mainScreen].bounds;

    self.messageWindow.frame = CGRectMake(0, 0, MAIN_SCREEN_W - 80, MAIN_SCREEN_W * 1.778 * 0.24);
    self.messageWindow.center = CGPointMake(MAIN_SCREEN_W * 0.5, MAIN_SCREEN_H * 0.4);

    CGFloat window_H = self.messageWindow.frame.size.height;
    CGFloat window_W = self.messageWindow.frame.size.width;
    
    NSLog(@"%@", NSStringFromCGRect(self.window.frame));
    
    self.cancel.frame = CGRectMake(0, window_H * 0.63, window_W * 0.5, window_H * 0.37);
    self.certain.frame = CGRectMake(window_W * 0.5, window_H * 0.63, window_W * 0.5, window_H * 0.37);
    
    [self.academy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.messageWindow);
        make.top.equalTo(self.messageWindow).offset(window_H * 0.23);
        make.width.lessThanOrEqualTo(self.messageWindow);
    }];
    
    [self.groupNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.academy.mas_bottom).offset(5);
        make.centerX.equalTo(self);
    }];
}

@end
