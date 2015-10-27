//
//  CourseButton.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/8/20.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "CourseButton.h"

@implementation CourseButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 1.5;
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 6;
    }
    return self;
}

@end
