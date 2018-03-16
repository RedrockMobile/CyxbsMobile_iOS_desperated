//
//  YouWenResultView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenResultView.h"

@implementation YouWenResultView
- (void)addDetail{
    [super addDetail];
    [self.confirBtn setTitle:@"发布" forState:UIControlStateNormal];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 80, self.confirBtn.top, 160, 50)];
    titleLab.text = @"求助设置";
    titleLab.font = [UIFont fontWithName:@"Arial" size:20];
    self.blackView.hidden = YES;
    [self.whiteView addSubview:titleLab];
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, self.blackView.bottom + 10, ScreenWidth - 30, 40)];
    timeLab.text = [NSString stringWithFormat:@"最晚完成任务至：%@", _time];
    [self.whiteView addSubview:timeLab];
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(15, timeLab.bottom + 10, ScreenWidth - 30, 1)];
    blackView.backgroundColor = [UIColor grayColor];
    [self.whiteView addSubview:blackView];
    
    UILabel *soreLab = [[UILabel alloc] initWithFrame:CGRectMake(15, blackView.bottom + 10, ScreenWidth - 30, 40)];
    soreLab.text = [NSString stringWithFormat:@"奖励积分数额为：%@", _sore];
    [self.whiteView addSubview:soreLab];
}
    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
