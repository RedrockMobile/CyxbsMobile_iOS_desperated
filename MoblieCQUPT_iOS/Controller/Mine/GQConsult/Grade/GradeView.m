//
//  GradeView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/3/5.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "GradeView.h"

@implementation GradeView

- (instancetype)initWithFrame:(CGRect)frame
        titileWithDic:(NSDictionary *)dic
             fontSize:(CGFloat)fontSize
           gradeFrame:(CGRect)gradeFrame
            typeFrame:(CGRect)typeFrame {
    
    
    self = [super initWithFrame:frame];
    UILabel *grade = [[UILabel alloc]initWithFrame:CGRectZero];
    grade.text = dic[@"grade"];
    grade.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    grade.font = [UIFont systemFontOfSize:fontSize];
    [grade sizeToFit];
    grade.frame = CGRectMake(self.frame.size.width-35, 0, grade.frame.size.width, self.frame.size.height);
    grade.center = CGPointMake(gradeFrame.origin.x+gradeFrame.size.width/2, self.frame.size.height/2);
    
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectZero];
    type.text = dic[@"property"];
    type.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    type.font = [UIFont systemFontOfSize:fontSize];
    [type sizeToFit];
    type.frame = CGRectMake(grade.frame.origin.x-40, 0, type.frame.size.width, self.frame.size.height);
    type.center = CGPointMake(typeFrame.origin.x+typeFrame.size.width/2, self.frame.size.height/2);
    
    UILabel *courseName = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width-type.frame.origin.x-5, self.frame.size.height)];
    courseName.text = dic[@"course"];
    courseName.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    courseName.font = [UIFont systemFontOfSize:fontSize];
    [courseName sizeToFit];
    CGFloat nameWidth = courseName.frame.size.width > type.frame.origin.x-30 ? type.frame.origin.x-30:courseName.frame.size.width;
    courseName.frame = CGRectMake(20, 0, nameWidth, self.frame.size.height);
    

    [self addSubview:grade];
    [self addSubview:type];
    [self addSubview:courseName];
    
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
