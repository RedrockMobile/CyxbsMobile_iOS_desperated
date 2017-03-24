//
//  BeautyExcellentStudentCollectionViewCell.m
//  FreshManFeature
//
//  Created by hzl on 16/8/11.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "BeautyExcellentStudentCollectionViewCell.h"
#define maxScreenHeight [UIScreen mainScreen].bounds.size.height
#define maxScreenWdith [UIScreen mainScreen].bounds.size.width

@implementation BeautyExcellentStudentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _studentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0.427 * maxScreenWdith, 0.281 * maxScreenHeight)];
        _studentImageView.layer.cornerRadius = YES;
        _studentImageView.layer.masksToBounds = YES;
        
        _studentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.296 * maxScreenHeight, 0.427 * maxScreenWdith, 0.018 * maxScreenHeight)];
        _studentLabel.font = [UIFont systemFontOfSize:13];
        _studentLabel.textColor = [UIColor blackColor];
        
        _collegeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.322 * maxScreenHeight, 0.423 * maxScreenWdith, 0.018 * maxScreenHeight)];
        _collegeLabel.font = [UIFont systemFontOfSize:12];
        _collegeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        
        [self addSubview:self.studentImageView];
        [self addSubview:self.studentLabel];
        [self addSubview:self.collegeLabel];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}


@end
