//
//  YouWenSoreView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenSoreView.h"
@interface YouWenSoreView()
@property (strong, nonatomic) UILabel *soreLab;
@property (strong, nonatomic) NSMutableArray *btnArray;
@property (copy, nonatomic) NSString *sore;
@end
@implementation YouWenSoreView

- (void)addDetail{
    [super addDetail];
    _btnArray = [NSMutableArray array];
    UILabel *restSore = [[UILabel alloc] init];
    restSore.textColor = [UIColor grayColor];
    restSore.text = [NSString stringWithFormat:@"积分剩余:10"];
    [self.whiteView addSubview:restSore];
    [restSore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.blackView.mas_bottom).offset(18);
        make.left.mas_equalTo(self.whiteView).offset(16);
        make.height.mas_offset(12);
        make.width.mas_offset(100);
    }];
    
    _soreLab = [[UILabel alloc] init];
    _soreLab.font = [UIFont fontWithName:@"Arail" size:ZOOM(20)];
    _soreLab.textColor = [UIColor colorWithHexString:@"7195FA"];
    [self.whiteView addSubview:_soreLab];
    [_soreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(restSore.mas_bottom).offset(22);
        make.left.mas_equalTo(self.whiteView).offset(17);
        make.height.mas_offset(16);
        make.width.mas_offset(100);
    }];
    [_soreLab.superview layoutIfNeeded];
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(15, _soreLab.bottom, ScreenWidth - 30, 1)];
    blackView.backgroundColor = [UIColor grayColor];
    [self.whiteView addSubview:blackView];
    
    NSArray *numArray = @[@"1", @"2", @"3", @"5", @"10", @"15"];
    CGFloat  width = (ScreenWidth - 142)/ 6;
    for (int i = 0; i < numArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"square"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"blueSquare"] forState:UIControlStateSelected];
        [btn setTitle:numArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(16 + (width + 22)* i, blackView.bottom + 25, width, width);
        [btn addTarget:self action:@selector(selectSore:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:btn];
        [_btnArray addObject:btn];
    }
    
}
- (void)selectSore:(UIButton *)Ubtn{
    for (int i = 0; i < _btnArray.count; i ++) {
        UIButton *btn = _btnArray[i];
        btn.selected = NO;
    }
    Ubtn.selected = YES;
    _soreLab.text = [NSString stringWithFormat:@"%@积分", Ubtn.titleLabel.text];
    _sore = _soreLab.text;
}
- (void)confirm{
    NSNotification *notification = [[NSNotification alloc]initWithName:@"soreNotifi" object:@{@"sore":self.sore} userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
