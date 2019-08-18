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
@property (copy, nonatomic) NSMutableArray<UIButton *> *btnArray;
@end
@implementation YouWenTopicView

- (void)setUpUI{
    [super setUpUI];
    
    [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"chacha"] forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@"" forState:UIControlStateNormal];
    [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.centerX.equalTo(self.whiteView);
        make.bottom.equalTo(self.whiteView).with.offset(-40 - SAFE_AREA_BOTTOM);
    }];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"选择求助类型"];
    [str addAttribute:NSKernAttributeName value:@(1) range:NSMakeRange(0, str.length)];
    self.titleLabel.attributedText = str;

    _topics = @[@"学习", @"生活", @"情感", @"其他"];
    _btnArray = [NSMutableArray array];
    NSArray *topicImages = @[@"learning", @"live", @"emotion", @"other"];
    NSArray *selectImages = @[@"learning_in", @"live_in", @"emotion_in", @"other_in"];
    CGFloat btnWidth = (SCREEN_WIDTH - 120) / 4;
    for (int i = 0 ; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:topicImages[i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:selectImages[i]] forState:UIControlStateSelected];
        btn.frame = CGRectMake(15 + (btnWidth + 30) * i, 70, btnWidth, btnWidth * 1.4);
        btn.tag = i;
        [btn addTarget:self action:@selector(currentSelect:) forControlEvents:UIControlEventTouchUpInside];
        [_btnArray addObject:btn];
        [self.whiteView addSubview:btn];
    }
    //默认选中第一个
    _style = _topics[0];
    _btnArray[0].selected = YES;
    [self.confirBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
}

- (NSMutableString *)style{
    if (!_style) {
        _style = [NSMutableString string];
    }
    return _style;
}

- (void)currentSelect:(UIButton *)btn{
    for (UIButton *btn in _btnArray) {
        btn.selected = NO;
    }
    self.style = _topics[btn.tag];
    btn.selected = YES;
}

- (void)confirm{
    [super confirm];
    [self.topicDelegate topicStyle:self.style];
}
@end
