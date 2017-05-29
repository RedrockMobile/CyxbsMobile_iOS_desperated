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
#import "TopicViewController.h"
@interface TopicBtn()
@property TopicModel *model;
@property UILabel *hotLabel;
@property CALayer *colorLayer;
@end
@implementation TopicBtn
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"topic_image_alltopic"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(touchTopic) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame andTopic:(TopicModel *)topic{
    self = [self initWithFrame:frame];
    self.model = topic;
    if (self) {
        self.colorLayer = [CALayer layer]
        ;
        self.colorLayer.backgroundColor = [UIColor colorWithRGB:0x212121 alpha:0.5].CGColor;
        self.colorLayer.frame = self.bounds;
        [self.layer addSublayer:self.colorLayer];
    
    
        [self setBackgroundImageWithURL:[NSURL URLWithString:[topic.imgArray firstObject]] forState:UIControlStateNormal placeholder:[UIImage imageWithColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]]];
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        label.text = topic.keyword;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [label setTextColor:[UIColor colorWithHexString:@"ffffff"]];
        label.numberOfLines = 0;
        [self addSubview:label];
        UIEdgeInsets padding = UIEdgeInsetsMake(25, 0, 25, 0);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(padding);
            
        }];
        
        
        self.hotLabel = [[UILabel alloc]initWithFrame:frame];
        self.hotLabel.font = [UIFont systemFontOfSize:11];
        self.hotLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        self.hotLabel.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.5];
        self.hotLabel.text = @"热门话题";
        self.hotLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.hotLabel];
        [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(frame.size.width/3);
            make.height.mas_equalTo(frame.size.width/9);
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(0);

        }];
    

    }
    return self;
}
- (void)touchTopic{
    if (self.model == nil) {
        TopicViewController *vc = [[TopicViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:vc animated:YES];
        
    }else{
        DetailTopicViewController *vc = [[DetailTopicViewController alloc]initWithTopic:self.model];
        vc.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.hotLabel.bounds
           byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight
       cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = self.hotLabel.bounds;
    self.hotLabel.layer.mask = maskLayer;
    
    self.colorLayer.frame = self.bounds;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
