//
//  YouWenResultView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenResultView.h"

@implementation YouWenResultView
- (void)setUpUI{
    [super setUpUI];
    
    [self.confirBtn setTitle:@"发布" forState:UIControlStateNormal];
    
    self.titleLabel.text = @"求助设置";
 
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, self.titleLabel.bottom + 50, SCREEN_WIDTH - 30, 40)];
    NSMutableAttributedString* timeAttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最晚完成任务至：%@", _time]];
    [timeAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"7195FA"] range:NSMakeRange(8, _time.length)];
    [timeAttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:15] range:NSMakeRange(0, timeAttributedStr.length)];
    timeLab.attributedText = timeAttributedStr;
    [self.whiteView addSubview:timeLab];
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(15, timeLab.bottom + 20, SCREEN_WIDTH - 30, 1)];
    blackView.backgroundColor = RGBColor(221, 221, 221, 1.0);
    [self.whiteView addSubview:blackView];
    
    UILabel *soreLab = [[UILabel alloc] initWithFrame:CGRectMake(15, blackView.bottom + 20, SCREEN_WIDTH - 30, 40)];
    NSMutableAttributedString* soreAttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"奖励积分数额为：%@", _sore]];
    [soreAttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:15] range:NSMakeRange(0, soreAttributedStr.length)];
    [soreAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"7195FA"] range:NSMakeRange(8, _sore.length)];
    soreLab.attributedText = soreAttributedStr;
    [self.whiteView addSubview:soreLab];
}

- (void)confirm{
    NSNotification *notification = [[NSNotification alloc]initWithName:@"finalNotifi" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    [self removeFromSuperview];
}

@end
