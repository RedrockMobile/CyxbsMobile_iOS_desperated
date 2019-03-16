//
//  YouWenTopicView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenTopicView.h"
@interface YouWenTopicView ()
@property (copy, nonatomic) NSArray *topics;
@end
@implementation YouWenTopicView

- (void)addDetail{
    [super addDetail];
    [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"chacha"] forState:UIControlStateNormal];
    self.cancelBtn.size = CGSizeMake(17, 17);
    self.cancelBtn.centerX = self.whiteView.centerX;
    [self.cancelBtn setTitle:@"" forState:UIControlStateNormal];
    self.cancelBtn.centerY = self.whiteView.height - 50;
    [self.confirBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
    self.confirBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"选择求助类型";
    titleLab.font = [UIFont fontWithName:@"Arial" size:16];
    self.blackView.hidden = YES;
    [self.whiteView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(101).multipliedBy(SCREEN_RATE);
        make.height.mas_equalTo(16).multipliedBy(SCREEN_RATE);
        make.top.equalTo(self.whiteView).offset(15);
        make.centerX.equalTo(self.whiteView);
    }];
    _topics = @[@"学习",  @"生活", @"情感", @"其他"];
    NSArray *topicImages = @[@"learning", @"live", @"emotion", @"other"];
    NSArray *selectImages = @[@"learning_in", @"live_in", @"emotion_in", @"other_in"];
    CGFloat btnWidth = (SCREENWIDTH - 120) / 4;
    for (int i = 0 ; i < 4; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:topicImages[i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:selectImages[i]] forState:UIControlStateSelected];
        btn.frame = CGRectMake(15 + (btnWidth + 30)* i, self.blackView.bottom + 50, btnWidth, ZOOM(88));
        btn.tag = i;
        [btn addTarget:self action:@selector(selectStyle:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:btn];
    }
}

- (NSMutableString *)style{
    if (!_style) {
        _style = [NSMutableString string];
    }
    return _style;
}
-(void)selectStyle:(UIButton *)btn{
    self.style = _topics[btn.tag];
    [self removeFromSuperview];
    [self.topicDelegate topicStyle:self.style];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
