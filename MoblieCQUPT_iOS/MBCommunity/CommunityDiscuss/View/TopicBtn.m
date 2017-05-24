//
//  TopicBtn.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/21.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "TopicBtn.h"
#import <Masonry.h>
#import <UShareUI/UShareUI.h>
#import "DetailTopicViewController.h"
@interface TopicBtn()
@property TopicModel *model;
@end
@implementation TopicBtn
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"topic-image-alltopic"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(touchTopic) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame andTopic:(TopicModel *)topic{
    self.model = topic;
    self = [self initWithFrame:frame];
    if (self) {
        [self setBackgroundImageWithURL:[NSURL URLWithString:topic.img_src] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        label.text = topic.keyword;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        label.alpha = 0.5;
        [label setTextColor:[UIColor colorWithHexString:@"000000"]];
        UIEdgeInsets padding = UIEdgeInsetsMake(25, 25, 25, 25);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(padding);
        }];
        UILabel *hotLabel = [[UILabel alloc]initWithFrame:frame];
        [hotLabel setFont:[UIFont systemFontOfSize:11]];
        [hotLabel setTextColor:[UIColor colorWithHexString:@"000000"]];
        hotLabel.text = @"热门话题";
        [self addSubview:hotLabel];
        [hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(frame.size.width/3);
            make.height.mas_equalTo(self.width/3);
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(0);
        }];
    
    }
    return self;
}
- (void)touchTopic{
    if (self.model == nil) {
        NSLog(@"test");
    }else{
    DetailTopicViewController *vc = [[DetailTopicViewController alloc]initWithTopic:self.model];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
