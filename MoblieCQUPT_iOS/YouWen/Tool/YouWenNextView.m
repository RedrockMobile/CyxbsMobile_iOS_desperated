//
//  YouWenTimeView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenNextView.h"

@implementation YouWenNextView

- (void)setUpUI{
    [super setUpUI];
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = RGBColor(87, 87, 87, 1);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self.whiteView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView).offset(12);
        make.centerX.equalTo(self.whiteView);
    }];
    
    //默认取消按钮设置
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"7195FA"] forState:UIControlStateNormal];
    [self.whiteView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView).offset(8);
        make.left.equalTo(self.whiteView).with.offset(20);
    }];

    //默认确认按钮设置
    _confirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_confirBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_confirBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.confirBtn setTitleColor:[UIColor colorWithHexString:@"7195FA"] forState:UIControlStateNormal];
    [self.whiteView addSubview:_confirBtn];
    [_confirBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView).offset(8);
        make.right.equalTo(self.whiteView).with.offset(-20);
    }];

}


- (void)cancel{
    [self pushWhiteView];
}

- (void)confirm{
    [self pushWhiteView];
    [self.delegate sendInformation:_inf.copy];
}

- (NSMutableString *)inf{
    if (!_inf) {
        _inf = [[NSMutableString alloc] init];
    }
    return _inf;
}

@end
