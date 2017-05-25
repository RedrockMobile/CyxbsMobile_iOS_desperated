//
//  TopicSearchCollectionViewCell.m
//  TopicSearch
//
//  Created by hzl on 2017/5/21.
//  Copyright © 2017年 hzl. All rights reserved.
//

#import "TopicSearchCollectionViewCell.h"

#define font(R) (R)*([UIScreen mainScreen].bounds.size.width)/375.0
#define autoSizeScaleX [UIScreen mainScreen].bounds.size.width/375.0
#define autoSizeScaleY [UIScreen mainScreen].bounds.size.height/667.0

CG_INLINE CGRect
CHANGE_CGRectMake(CGFloat x, CGFloat y,CGFloat width,CGFloat height){
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}


@interface TopicSearchCollectionViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation TopicSearchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.bgImageView = [[UIImageView alloc] initWithFrame:CHANGE_CGRectMake(0, 0, 165, 138)];
    self.bgImageView.backgroundColor = [UIColor clearColor];
    self.bgImageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.bgImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(0, 35, 165, 36)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:font(18)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CHANGE_CGRectMake(50, 75, 20, 18)];
    self.iconImageView.image = [UIImage imageNamed:@"aNumIcon.png"];
    self.iconImageView.backgroundColor = [UIColor clearColor];
    self.iconImageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.iconImageView];
    
    self.attendNumLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(70, 75, 85, 15)];
    self.attendNumLabel.textColor = [UIColor whiteColor];
    self.attendNumLabel.textAlignment = NSTextAlignmentLeft;
    self.attendNumLabel.font = [UIFont systemFontOfSize:font(10)];
    self.attendNumLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.attendNumLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CHANGE_CGRectMake(57, 98, 50, 1)];
    self.lineView.backgroundColor = [UIColor colorWithRed:27/255.0 green:184/255.0 blue:250/255.0 alpha:1];
    [self.contentView addSubview:self.lineView];
}

@end
