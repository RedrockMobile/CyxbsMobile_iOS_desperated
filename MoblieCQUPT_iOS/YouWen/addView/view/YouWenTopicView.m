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
    self.cancelBtn.centerX = self.whiteView.centerX;
    [self.cancelBtn setTitle:@"" forState:UIControlStateNormal];
    self.cancelBtn.centerY = self.whiteView.height - 50;
    self.cancelBtn.size = CGSizeMake(40, 40);
    [self.confirBtn setTitle:@"下一步" forState:UIControlStateNormal];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 80, self.confirBtn.top, 160, 50)];
    titleLab.text = @"选择求助类型";
    titleLab.font = [UIFont fontWithName:@"Arial" size:20];
    self.blackView.hidden = YES;
    [self.whiteView addSubview:titleLab];
    _topics = @[@"学习",  @"生活", @"情感", @"其他"];
    NSArray *topicImages = @[@"learning", @"live", @"emotion", @"other"];
    NSArray *selectImages = @[@"learning_in", @"live_in", @"emotion_in", @"other_in"];
    CGFloat btnWidth =  (ScreenWidth - 30) / 4;
    for (int i = 0 ; i < 4; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:topicImages[i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:selectImages[i]] forState:UIControlStateSelected];
        btn.frame = CGRectMake(30 + btnWidth * i, self.blackView.bottom + 50, btnWidth - 30, 100);
        btn.tag = i;
        [btn addTarget:self action:@selector(selectStyle:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:btn];
    }
}

-(void)selectStyle:(UIButton *)btn{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
