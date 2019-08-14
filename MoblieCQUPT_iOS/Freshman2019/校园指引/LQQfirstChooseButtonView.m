//
//  LQQfirstChooseButtonView.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/2.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "LQQfirstChooseButtonView.h"
#import <Masonry.h>
@implementation LQQfirstChooseButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dormitory = [[UIButton alloc]init];
        _dormitory.backgroundColor = [UIColor whiteColor];
        [_dormitory setTitleColor:[UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:1] forState:normal];
        [_dormitory setTitleColor:[UIColor colorWithRed:36/255.0 green:78/255.0 blue:254/255.0 alpha:1] forState:UIControlStateSelected];

        _shiTang = [[UIButton alloc]init];
        _shiTang.backgroundColor = _dormitory.backgroundColor;
        [_shiTang setTitleColor:[UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:1] forState:normal];
        [_shiTang setTitleColor:[UIColor colorWithRed:36/255.0 green:78/255.0 blue:254/255.0 alpha:1] forState:UIControlStateSelected];

        _kuaiDi = [[UIButton alloc]init];
        _kuaiDi.backgroundColor = _dormitory.backgroundColor;
        [_kuaiDi setTitleColor:[UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:1] forState:normal];
        [_kuaiDi  setTitleColor:[UIColor colorWithRed:36/255.0 green:78/255.0 blue:254/255.0 alpha:1] forState:UIControlStateSelected];
        _shuJuJieMi = [[UIButton alloc]init];
        _shuJuJieMi.backgroundColor = _dormitory.backgroundColor;
        [_shuJuJieMi setTitleColor:[UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:1] forState:normal];
        [_shuJuJieMi setTitleColor:[UIColor colorWithRed:36/255.0 green:78/255.0 blue:254/255.0 alpha:1] forState:UIControlStateSelected];
        [self addSubview:_dormitory];
        [_dormitory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40
                                );
            make.width.equalTo(self.mas_width).multipliedBy(0.25);
            make.left.equalTo(self);
            make.top.equalTo(self.mas_top).offset(10);
            
        }];
        [self addSubview:_shiTang];
        [_shiTang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40
                                );
            make.width.equalTo(self.mas_width).multipliedBy(0.25);
            make.left.equalTo(_dormitory.mas_right);
            make.top.equalTo(self.mas_top).offset(10);
            
        }];
        [self addSubview:_kuaiDi];
        [_kuaiDi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40
                                );
            make.width.equalTo(self.mas_width).multipliedBy(0.25);
            make.left.equalTo(_shiTang.mas_right);
            make.top.equalTo(self.mas_top).offset(10);
            
        }];
        [self addSubview:_shuJuJieMi];
        [_shuJuJieMi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40
                                );
            make.width.equalTo(self.mas_width).multipliedBy(0.25);
            make.left.equalTo(_kuaiDi.mas_right);
            make.top.equalTo(self.mas_top).offset(10);

        }];
//        [self addSubview:shuJuJieMi];

    }
    return self;
}

@end
