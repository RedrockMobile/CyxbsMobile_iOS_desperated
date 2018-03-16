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
@end
@implementation YouWenSoreView

- (void)addDetail{
    [super addDetail];
    _btnArray = [NSMutableArray array];
    UILabel *restSore = [[UILabel alloc] initWithFrame:CGRectMake(15, self.blackView.bottom + 10, 200, 40)];
    restSore.textColor = [UIColor grayColor];
    restSore.text = [NSString stringWithFormat:@"积分剩余:10"];
    [self.whiteView addSubview:restSore];
    
    _soreLab = [[UILabel alloc] initWithFrame:CGRectMake(15, restSore.bottom + 10, 150, 100)];
    _soreLab.font = [UIFont fontWithName:@"Arail" size:20];
    _soreLab.textColor = [UIColor blueColor];
    [self.whiteView addSubview:_soreLab];
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(15, _soreLab.bottom, ScreenWidth - 30, 1)];
    blackView.backgroundColor = [UIColor grayColor];
    [self.whiteView addSubview:blackView];
    
    NSArray *numArray = @[@"1", @"2", @"3", @"5", @"10", @"15"];
    CGFloat  width = (ScreenWidth - 15)/ 6;
    for (int i = 0; i < numArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"square"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"blueSquare"] forState:UIControlStateSelected];
        [btn setTitle:numArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(15 + width * i, blackView.bottom + 15, 45, 45);
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
}
- (void)confirm{
    [self removeFromSuperview];
    NSNotification *notification = [[NSNotification alloc]initWithName:@"soreNotifi" object:@{@"sore":_soreLab.text} userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
