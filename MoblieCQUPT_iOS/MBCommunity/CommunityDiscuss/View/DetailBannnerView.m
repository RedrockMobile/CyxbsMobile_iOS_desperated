//
//  DetailBannnerView.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/24.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "DetailBannnerView.h"
#import <Masonry.h>
#import "CAShapeLayer+ViewMask.h"
@interface DetailBannnerView()
@property UIImageView *backGroundImageView;
@property UILabel *titleLabel;
@property UILabel *contentLabel;
@property YYLabel *numLabel;
@property TopicModel *topic;
@property bool isExtend;
@property CGFloat initialHeight;
@property CALayer *colorLayer;
@property CAShapeLayer *labelLayer;
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
        self.numLabel = [[YYLabel alloc]init];
        [self addSubview:self.backGroundImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.numLabel];
        
        [self.backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.size.mas_equalTo(frame.size.height/3*2);
        }];
        
        self.colorLayer = [CALayer layer]
        ;
        self.colorLayer.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.25].CGColor;
        self.colorLayer.frame = self.backGroundImageView.bounds;
        [self.backGroundImageView.layer addSublayer:self.colorLayer];
        
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
//        YYLabel *label = [[YYLabel alloc]init];
//        [label setBackgroundColor:[UIColor colorWithRGB:0x000000 alpha:0.4]];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.left).offset(300);
//            make.top.and.right.mas_equalTo(10);
//        }];
        
//        [self.backGroundImageView setImageWithURL:[NSURL URLWithString:topic.imgArray[0]] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        [self.backGroundImageView sd_setImageWithURL:[NSURL URLWithString:[topic.imgArray firstObject]] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        self.titleLabel.text = self.topic.keyword;
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.textColor = [UIColor colorWithRGB:0x212121 alpha:1];
        
        self.contentLabel.text = self.topic.content;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        self.contentLabel.textColor = [UIColor colorWithRGB:0x999999 alpha:1];
        
        self.numLabel.text = [NSString stringWithFormat:@"%@\n人已参与",topic.join_num];
        self.numLabel.numberOfLines = 0;
        self.numLabel.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.4];
        NSRange range = [self.numLabel.text rangeOfString:@"人已参与"];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:self.numLabel.text];
        text.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
        text.color = [UIColor colorWithRGB:0x41a3ff alpha:1];
        [text setColor:[UIColor colorWithRGB:0xffffff alpha:1]range:range];
        [text setFont:[UIFont systemFontOfSize:12.5] range:range];
        self.numLabel.attributedText = text;
        self.numLabel.textAlignment = NSTextAlignmentCenter;
        
     
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.left).offset(300*SCREENWIDTH/375);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(55);
        }];
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



- (void)layoutSubviews{
    [super layoutSubviews];
    self.colorLayer.frame = self.backGroundImageView.bounds;
    
    self.labelLayer = [CAShapeLayer createMaskLayerWithView:self.numLabel];
    self.numLabel.layer.mask = self.labelLayer;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
