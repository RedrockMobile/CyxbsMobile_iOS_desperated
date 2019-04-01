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
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"求助设置";
    titleLab.font = [UIFont fontWithName:@"Arial" size:ZOOM(16)];
    self.blackView.hidden = YES;
    [self.whiteView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.whiteView).mas_offset(18);
        make.centerX.mas_equalTo(self.whiteView);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(80);
    }];
    [titleLab.superview layoutIfNeeded];
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, titleLab.bottom + 50, SCREEN_WIDTH - 30, 40)];
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
