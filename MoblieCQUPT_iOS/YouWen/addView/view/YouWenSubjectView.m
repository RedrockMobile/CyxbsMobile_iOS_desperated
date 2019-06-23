//
//  YouWenSubjectView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/18.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenSubjectView.h"

@interface YouWenSubjectView()


@end

@implementation YouWenSubjectView

- (instancetype)initTheWhiteViewHeight:(CGFloat)height subject:(NSString *)subject{
    _subject = subject;
    self = [super initTheWhiteViewHeight:height];
    return self;
}

- (void)setUpUI{
    [super setUpUI];

    _btnArray = [NSMutableArray array];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"添加话题"];
    [str addAttribute:NSKernAttributeName value:@(1) range:NSMakeRange(0, str.length)];
    self.titleLabel.attributedText = str;
    [self.confirBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    UIView *grayLine = [[UIView alloc] init];
    grayLine.backgroundColor = [UIColor grayColor];
    grayLine.layer.opacity = 0.4;
    [self.whiteView addSubview:grayLine];
    [grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel).with.offset(75);
        make.centerX.equalTo(self.whiteView);
        make.width.mas_equalTo(SCREEN_WIDTH - 30);
        make.height.mas_equalTo(0.3);
    }];
    
    UILabel *hotTopic  = [[UILabel alloc] init];
    hotTopic.text = @"热门话题";
    hotTopic.textColor = [UIColor grayColor];
    hotTopic.font = [UIFont systemFontOfSize:14];
    hotTopic.layer.opacity = 0.8;
    [self.whiteView addSubview:hotTopic];
    [hotTopic mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.whiteView).with.offset(15);
        make.top.equalTo(grayLine).with.offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 30);
        make.height.mas_equalTo(32);
    }];
    
    _topicField = [[UITextField alloc] init];
    NSLog(@"%@", _subject);
    if (_subject) {
        _topicField.text = _subject;
    }else{
        _topicField.placeholder = @"话题";
    }
    _topicField.textColor = [UIColor colorWithHexString:@"7195FA"];
    [self.whiteView addSubview:_topicField];
    [_topicField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(grayLine.mas_top);
        make.left.equalTo(grayLine);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    CGFloat btnWidth = (SCREEN_WIDTH - 75) /4;
    NSArray *topicArray = @[@"大物", @"英语", @"线代", @"高数", @"几何", @"思修"];
    for (int i = 0; i < topicArray.count; i ++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"emptybox"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bluebox"]
            forState:UIControlStateSelected];
        [btn setTitle:topicArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"7195FA"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectTopic:) forControlEvents:UIControlEventTouchUpInside];
        btn.adjustsImageWhenHighlighted = NO;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.whiteView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15 + (btnWidth + 15) * (i % 4));
            make.top.equalTo(hotTopic).with.offset(40 + (i / 4) * 50);
            make.width.mas_equalTo(btnWidth);
            make.height.mas_equalTo(35);
        }];
        [_btnArray addObject:btn];
    }
    
}

- (void)selectTopic:(UIButton *)button{
    if (button.selected) {
        button.highlighted = YES;
        button.selected = NO;
        _topicField.text = @"";
    } else{
        button.highlighted = NO;
        for (UIButton *btn in _btnArray) {
            btn.selected = NO;
        }
        button.selected = YES;
        _topicField.text = [NSString stringWithFormat:@"#%@#", button.currentTitle];
    }
    [_topicField resignFirstResponder];
}

- (void)confirm{
    _subject = _topicField.text;
    NSNotification *notification = [[NSNotification alloc] initWithName:@"subjectNotifi" object:@{@"subject":_subject} userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self pushWhiteView];
}

@end
