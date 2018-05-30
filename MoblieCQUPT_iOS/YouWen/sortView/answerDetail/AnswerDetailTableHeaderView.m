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
        if (model.photoUrlArr.count == 0) {
            [self.imageView1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@0);
            }];
            [self.imageView2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@0);
            }];
            [self.imageView1 updateConstraintsIfNeeded];
            [self.imageView2 updateConstraintsIfNeeded];
        } else {
            [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:self.imageView1, self.imageView2, nil];
            
            for (int i = 0; i < model.photoUrlArr.count; i++) {
                [arr[i] sd_setImageWithURL:[NSURL URLWithString:model.photoUrlArr[i]]];
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
