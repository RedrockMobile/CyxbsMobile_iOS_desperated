//
//  YouWenResultView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenResultView.h"
#import "YouWenTimeView.h"
#import "YouWenSoreView.h"

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
 
    
    UIButton *timeLab = [[UIButton alloc] initWithFrame:CGRectMake(16, 86 - 20, SCREEN_WIDTH - 32, 40)];
    NSMutableAttributedString *timeAttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最晚完成任务至：%@", _untilTime]];
    [timeAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"7195FA"] range:NSMakeRange(8, _untilTime.length)];
    [timeAttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, timeAttributedStr.length)];
    [timeAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 8)];
    [timeLab setAttributedTitle:timeAttributedStr forState:UIControlStateNormal];
    [timeLab addTarget:self action:@selector(changeTime) forControlEvents:UIControlEventTouchUpInside];
    timeLab.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.whiteView addSubview:timeLab];
    
    UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(15, 120, SCREEN_WIDTH - 30, 1)];
    grayLine.backgroundColor = RGBColor(221, 221, 221, 1.0);
    [self.whiteView addSubview:grayLine];
    
    UIButton *soreLab = [[UIButton alloc] initWithFrame:CGRectMake(16, 141, SCREEN_WIDTH - 32, 40)];
    NSMutableAttributedString *soreAttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"奖励积分数额为：%@", _score]];
    [soreAttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:15] range:NSMakeRange(0, soreAttributedStr.length)];
    [soreAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"7195FA"] range:NSMakeRange(8, _score.length)];
    [soreAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 8)];
    [soreLab setAttributedTitle:soreAttributedStr forState:UIControlStateNormal];
    [soreLab addTarget:self action:@selector(changeSore) forControlEvents:UIControlEventTouchUpInside];
    soreLab.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.whiteView addSubview:soreLab];
}

- (void)confirm{
    NSNotification *notification = [[NSNotification alloc]initWithName:@"finalNotifi" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    [self removeFromSuperview];
}

- (void)changeTime{
    [self pushWhiteView];
    YouWenTimeView *nextView = [[YouWenTimeView alloc] initTheWhiteViewHeight:210 + SAFE_AREA_BOTTOM];
    [nextView popWhiteView];
    [[UIApplication sharedApplication].keyWindow addSubview:nextView];
}

- (void)changeSore{
    [self pushWhiteView];
    YouWenSoreView *nextView = [[YouWenSoreView alloc] initTheWhiteViewHeight:240 + SAFE_AREA_BOTTOM];
    [nextView popWhiteView];
    [[UIApplication sharedApplication].keyWindow addSubview:nextView];
}

- (void)cancel{
    NSNotification *notification = [[NSNotification alloc]initWithName:@"cancelPushed" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    [super cancel];
}

@end
