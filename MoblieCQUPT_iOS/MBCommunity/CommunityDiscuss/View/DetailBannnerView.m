//
//  DetailBannnerView.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/24.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "DetailBannnerView.h"
#import <Masonry.h>
@interface DetailBannnerView()
@property UIImageView *backGroundImageView;
@property UILabel *titleLabel;
@property UILabel *contentLabel;
@property UILabel *numLabel;
@property TopicModel *topic;
@property bool isExtend;
@property CGFloat initialHeight;
@end
@implementation DetailBannnerView
- (instancetype)initWithFrame:(CGRect)frame andTopic:(TopicModel *)topic{
    self = [super initWithFrame:frame];
    if (self) {
        self.extendHeight = self.initialHeight = frame.size.height;
        self.isExtend = NO;
        self.topic = topic;
        self.backGroundImageView = [[UIImageView alloc]init];
        self.titleLabel = [[UILabel alloc]init];
        self.contentLabel = [[UILabel alloc]init];
        [self addSubview:self.backGroundImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self.backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(16);
            make.right.equalTo(self.mas_right).with.offset(-16);
            make.size.mas_equalTo(frame.size.height/3*2);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(16);
            make.right.equalTo(self.mas_right).with.offset(-16);
            make.top.equalTo(self.backGroundImageView.mas_bottom).offset(16);
            make.height.mas_equalTo(0.087*frame.size.height);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(16);
            make.right.equalTo(self.mas_right).with.offset(-16);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
            make.bottom.equalTo(self.mas_bottom).offset(-16);
        }];
        [self.backGroundImageView setImageWithURL:[NSURL URLWithString:topic.img_src] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        self.titleLabel.text = self.topic.keyword;
        self.contentLabel.text = @"#关键字# 这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试哈哈哈";
        [self.contentLabel setFont:[UIFont systemFontOfSize:15]];
        self.contentLabel.numberOfLines = 0;
        self.numLabel.text = [NSString stringWithFormat:@"%@人已参与",topic.join_num];
    }
        return self;
}

- (void)extend{
    CGFloat height;
    self.isExtend = !self.isExtend;
    if (self.isExtend) {
        height = [self.contentLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width-32, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size.height;
    }else{
//        height = [self.contentLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}].height;
        self.extendHeight = self.initialHeight;
        return;
    }
    height += 16;
    height += 1;
    self.extendHeight = height+self.height-self.contentLabel.height;
    // Add an extra point to the height to account for the cell separator, which is added between the bottom of the cell's contentView and the bottom of the table view cell.
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
