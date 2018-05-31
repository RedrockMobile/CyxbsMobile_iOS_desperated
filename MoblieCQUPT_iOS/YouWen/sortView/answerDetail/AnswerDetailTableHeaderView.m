//
//  AnswerDetailTableHeaderView.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/4/3.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "AnswerDetailTableHeaderView.h"
#import <Masonry.h>
#import "YouWenAnswerDetailModel.h"

@implementation AnswerDetailTableHeaderView

- (instancetype) initWithModel:(YouWenAnswerDetailModel *)model {
    self = [super init];
    
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] firstObject];
        self.contentLabel.text = model.content;
        self.dateLabel.text = model.timeStr;
        self.nicknameLabel.text = model.nickname;
        [self layoutIfNeeded];
    }
    return self;
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
