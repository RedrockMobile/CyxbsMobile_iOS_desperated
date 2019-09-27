//
//  ClassmateSearchView.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/9/27.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ClassmateSearchView.h"


@implementation ClassmateSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UITextField *searchTextField = [[UITextField alloc] init];
        searchTextField.placeholder = @" 请输入姓名或学号";
        searchTextField.backgroundColor = [UIColor whiteColor];
        searchTextField.font = [UIFont systemFontOfSize:15];
        searchTextField.layer.masksToBounds = YES;
        searchTextField.layer.cornerRadius = 5;
        searchTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        searchTextField.leftView.userInteractionEnabled = NO;
        searchTextField.leftViewMode = UITextFieldViewModeAlways;
        [self addSubview:searchTextField];
        self.searchTextField = searchTextField;
        
        UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        searchButton.backgroundColor = [UIColor colorWithRed:140/255.0 green:159/255.0 blue:247/255.0 alpha:1];
        [searchButton setTitle:@"确定" forState:UIControlStateNormal];
        searchButton.titleLabel.font = [UIFont systemFontOfSize:18];
        searchButton.layer.masksToBounds = YES;
        searchButton.layer.cornerRadius = 5;
        [searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:searchButton];
        self.searchButton = searchButton;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.right.equalTo(self).offset(-25);
        make.top.equalTo(self).offset(100);
        make.height.equalTo(@45);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchTextField.mas_bottom).offset(45);
        make.centerX.equalTo(self);
        make.height.equalTo(@45);
        make.width.equalTo(@100);
    }];
}

- (void)searchButtonClicked {
    if ([self.delegate respondsToSelector:@selector(didClickedSearchButton)]) {
        [self.delegate didClickedSearchButton];
    }
}

@end
