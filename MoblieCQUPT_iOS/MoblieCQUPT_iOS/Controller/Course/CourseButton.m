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
        self.layer.cornerRadius = 5.0;
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
    }
    return self;
}

//- (void)setCourse:(Course *)course {
//    NSString *courseName = self.coures.course;
//    NSString *classroom = self.coures.classroom;
//    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self setTitle:[NSString stringWithFormat:@"%@ @%@",courseName,classroom] forState:UIControlStateNormal];
//    NSLog(@"1111");
//
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
