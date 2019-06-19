//
//  YouWenSubjectView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/18.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenSubjectView.h"

@interface YouWenSubjectView()
@property (copy, nonatomic) NSMutableArray *btnArray;
@property (strong, nonatomic) UILabel *topicLab;
@property (copy, nonatomic) NSString *subject;
@end
@implementation YouWenSubjectView
- (void)setUpUI{
    [super setUpUI];
    self.cancelBtn.hidden = YES;
    self.blackView.hidden = YES;
    _btnArray = [NSMutableArray array];
    _subject = [NSString string];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"添加话题";
    titleLab.font = [UIFont fontWithName:@"Arial" size:ZOOM(16)];
    [self.whiteView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.whiteView).mas_offset(15);
        make.centerX.mas_equalTo(self.whiteView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    _topicLab = [[UILabel alloc] initWithFrame:CGRectMake(15, self.blackView.bottom + 23, SCREEN_WIDTH - 30, 18)];
    _topicLab.font = [UIFont fontWithName:@"Arial" size:ZOOM(17)];
    _topicLab.textColor = [UIColor colorWithHexString:@"7195FA"];
    [self.whiteView addSubview:_topicLab];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(15, _topicLab.bottom + 8, SCREEN_WIDTH - 30, 1)];
    grayView.backgroundColor = [UIColor grayColor];
    [self.whiteView addSubview:grayView];
    
    UILabel *hotTopic  = [[UILabel alloc] initWithFrame:CGRectMake(15, grayView.bottom + 23, SCREEN_WIDTH - 30, 32)];
    hotTopic.text = @"热门话题";
    hotTopic.textColor = [UIColor grayColor];
    hotTopic.font = [UIFont fontWithName:@"Arial" size:ZOOM(15)];
    [self.whiteView addSubview:hotTopic];
    CGFloat btnWidth = (SCREEN_WIDTH - 75) /4;
    NSArray *topicArray = @[@"大物", @"英语", @"线代", @"高数", @"几何", @"思修"];
    for (int i = 0; i < topicArray.count; i ++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15 + (btnWidth + 15)* (i % 4), hotTopic.bottom + 15 + (i / 4) * 50, btnWidth, 35);
        [btn setBackgroundImage:[UIImage imageNamed:@"emptybox"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bluebox"]
            forState:UIControlStateSelected];
        [btn setTitle:topicArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"7195FA"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectTopic:) forControlEvents:UIControlEventTouchUpInside];
        btn.adjustsImageWhenHighlighted = NO;
        [self.whiteView addSubview:btn];
        [_btnArray addObject:btn];
    }
    
}
- (void)selectTopic:(UIButton *)button{
    button.highlighted = NO;
    for (UIButton *btn in _btnArray) {
        btn.selected = NO;
    }
    button.selected = YES;
    _topicLab.text = [NSString stringWithFormat:@"#%@#", button.currentTitle];
    _subject = _topicLab.text;
}
- (void)confirm{
    NSNotification *notification = [[NSNotification alloc]initWithName:@"subjectNotifi" object:@{@"subject":self.subject} userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    [self removeFromSuperview];
}

@end
