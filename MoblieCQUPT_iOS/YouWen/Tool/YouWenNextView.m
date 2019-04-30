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
    _cancelBtn.frame = CGRectMake(10, 10, ZOOM(60), ZOOM(15));
    _cancelBtn.titleLabel.font = [UIFont fontWithName:@"Arail" size:14];
    _cancelBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _cancelBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"7195FA"] forState:UIControlStateNormal];
    [self.whiteView addSubview:_cancelBtn];
    
    
    _confirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirBtn.frame = CGRectMake(SCREEN_WIDTH - 70, 10, ZOOM(60), ZOOM(15));
    _confirBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_confirBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_confirBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_confirBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    _confirBtn.titleLabel.font = [UIFont fontWithName:@"Arail" size:14];
    [self.confirBtn setTitleColor:[UIColor colorWithHexString:@"7195FA"] forState:UIControlStateNormal];
    [self.whiteView addSubview:_confirBtn];
    
    _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, _confirBtn.bottom + 17, SCREEN_WIDTH, 1)];
    _blackView.backgroundColor =  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    [self.whiteView addSubview:_blackView];
}


- (void)quit{
    [UIView animateWithDuration:0.3f animations:^{
        self.whiteView.centerY = SCREEN_HEIGHT + 200;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)confirm{
    [self.delegate sendInformation:_inf.copy];
}

- (NSMutableString *)inf{
    if (!_inf) {
        _inf = [[NSMutableString alloc] init];    }
    return _inf;
}

@end
