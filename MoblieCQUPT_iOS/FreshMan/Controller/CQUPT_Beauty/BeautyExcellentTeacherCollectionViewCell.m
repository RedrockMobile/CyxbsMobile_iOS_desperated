//
//  BeautyExcellentTeacherCollectionViewCell.m
//  FreshManFeature
//
//  Created by hzl on 16/8/12.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "BeautyExcellentTeacherCollectionViewCell.h"
#define maxScreenHeight [UIScreen mainScreen].bounds.size.height
#define maxScreenWdith [UIScreen mainScreen].bounds.size.width

@implementation BeautyExcellentTeacherCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _teacherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0.427 * maxScreenWdith, 0.281 * maxScreenHeight)];
        _teacherLabel.layer.cornerRadius = 12;
        _teacherLabel.layer.masksToBounds = YES;
        
        _teacherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.296 * maxScreenHeight, 0.427 * maxScreenWdith, 0.018 * maxScreenHeight)];
        _teacherLabel.textColor = [UIColor blackColor];
        
        _collegeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.322 * maxScreenHeight, 0.423 * maxScreenWdith, 0.018 * maxScreenHeight)];
        _collegeLabel.font = [UIFont systemFontOfSize:12];
        _collegeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [self addSubview:self.teacherImageView];
        [self addSubview:self.teacherLabel];
        [self addSubview:self.collegeLabel];
    }
    return self;
}

@end
