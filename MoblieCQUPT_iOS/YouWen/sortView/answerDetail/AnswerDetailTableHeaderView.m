//
//  AnswerDetailTableHeaderView.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/4/3.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "AnswerDetailTableHeaderView.h"
#import <Masonry.h>
#import "YouWenQuestionDetailModel.h"

@implementation AnswerDetailTableHeaderView

- (instancetype) initWithModel:(YouWenQuestionDetailModel *)model {
    self = [super init];
    
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] firstObject];
        self.titleLabel.text = model.title;
        self.contentLabel.text = model.descriptionStr;
        self.dateLabel.text = model.disappearTime;
        self.nicknameLabel.text = model.nickName;
        if (model.picArr.count == 0) {
            [self.imageView1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@0);
            }];
            [self.imageView2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@0);
            }];
            [self.imageView1 updateConstraintsIfNeeded];
            [self.imageView2 updateConstraintsIfNeeded];
        } else {
            [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:self.imageView1, self.imageView2, nil];
            
            for (int i = 0; i < model.picArr.count; i++) {
                [arr[i] sd_setImageWithURL:[NSURL URLWithString:model.picArr[i]]];
            }
        }
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
