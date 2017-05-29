//
//  BannerScrollView.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/19.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "BannerScrollView.h"
#import <Masonry.h>
@interface BannerScrollView()<UIScrollViewDelegate>
@property NSMutableArray <TopicBtn *> *btnArray;
@end
@implementation BannerScrollView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnArray  = [NSMutableArray array];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame andTopics:(NSMutableArray *) topics{
    self = [self initWithFrame:frame];
    if (self) {
        NSInteger num = topics.count;
        for (NSInteger i = 0; i<=topics.count; i++) {
            TopicBtn *btn;
            if (i == topics.count) {
                btn = [[TopicBtn alloc]initWithFrame:CGRectMake(i*SCREENWIDTH*num/2.0+16*(i+1),0,SCREENWIDTH/2.0,frame.size.height)];
            }
            else{
                btn = [[TopicBtn alloc]initWithFrame:CGRectMake(i*SCREENWIDTH*num/2.0+16*(i+1),0,SCREENWIDTH/2.0,frame.size.height)andTopic:topics[i]];
            }
            [self.btnArray addObject:btn];
            [self addSubview:btn];
        }
        if (topics.count >0) {
            [self.btnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:16 leadSpacing:16 tailSpacing:16];
        }
        [self.btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(frame.size.width/2);
            make.height.mas_equalTo(frame.size.height-32);
            make.top.mas_equalTo(16);
            make.bottom.mas_equalTo(-16);
        }];
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
