//
//  YouWenTimeView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenNextView.h"
@interface YouWenNextView()
@end
@implementation YouWenNextView
- (void)addDetail{
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(10, 10, 50, 30);
    _cancelBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _cancelBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:_cancelBtn];
    
    _confirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirBtn.frame = CGRectMake(ScreenWidth - 70, 10, 60, 25);
    _cancelBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _cancelBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_confirBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_confirBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_confirBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:_confirBtn];
    
    _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, _confirBtn.bottom + 10, ScreenWidth, 1)];
    _blackView.backgroundColor = [UIColor blackColor];
    [self.whiteView addSubview:_blackView];
    
   

}


- (void)quit{
    [self removeFromSuperview];
}

- (void)confirm{
    [self.delegate sendInformation:_inf.copy];
}

- (NSMutableString *)inf{
    if (!_inf) {
        _inf = [[NSMutableString alloc] init];    }
    return _inf;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
