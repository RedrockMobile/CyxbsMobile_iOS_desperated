//
//  YouWenResultView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenResultView.h"

@interface YouWenResultView()

@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *untilTime;

@end

@implementation YouWenResultView

- (instancetype)initTheWhiteViewHeight:(CGFloat)height score:(NSString *)score time:(NSString *)time{
    if (self = [super initTheWhiteViewHeight:height]) {
        _score = score;
        _untilTime = time;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    [super setUpUI];
    
    [self.confirBtn setTitle:@"发布" forState:UIControlStateNormal];
    self.titleLabel.text = @"求助设置";
 
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, self.titleLabel.bottom + 80 , SCREEN_WIDTH - 30, 40)];
    NSMutableAttributedString *timeAttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最晚完成任务至：%@", _untilTime]];
    [timeAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"7195FA"] range:NSMakeRange(8, _untilTime.length)];
    [timeAttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, timeAttributedStr.length)];
    [timeAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 8)];
    
    timeLab.attributedText = timeAttributedStr;
    [self.whiteView addSubview:timeLab];
    
    UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(15, timeLab.bottom + 20, SCREEN_WIDTH - 30, 1)];
    grayLine.backgroundColor = RGBColor(221, 221, 221, 1.0);
    [self.whiteView addSubview:grayLine];
    
    UILabel *soreLab = [[UILabel alloc] initWithFrame:CGRectMake(15, grayLine.bottom + 20, SCREEN_WIDTH - 30, 40)];
    NSMutableAttributedString* soreAttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"奖励积分数额为：%@", _score]];
    [soreAttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:15] range:NSMakeRange(0, soreAttributedStr.length)];
    [soreAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"7195FA"] range:NSMakeRange(8, _score.length)];
    [soreAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 8)];
    soreLab.attributedText = soreAttributedStr;
    [self.whiteView addSubview:soreLab];
}

- (void)confirm{
    NSNotification *notification = [[NSNotification alloc]initWithName:@"finalNotifi" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    [self removeFromSuperview];
}

@end
