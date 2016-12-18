//
//  LessonButton.m
//  Demo
//
//  Created by 李展 on 2016/10/28.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "LessonButton.h"
#import "DetailViewController.h"
@implementation LessonButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
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
