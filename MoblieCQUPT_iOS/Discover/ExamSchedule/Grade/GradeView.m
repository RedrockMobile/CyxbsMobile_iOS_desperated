//
//  GradeView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/3/5.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "GradeView.h"
#import <Masonry.h>
@implementation GradeView

- (instancetype)initWithFrame:(CGRect)frame
        titileWithDic:(NSDictionary *)dic
             fontSize:(CGFloat)fontSize
{
    
    
    self = [super initWithFrame:frame];
    UILabel *grade = [[UILabel alloc]initWithFrame:CGRectZero];
    grade.text = dic[@"grade"];
    grade.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    grade.font = [UIFont systemFontOfSize:fontSize];
    grade.textAlignment = NSTextAlignmentRight;
    [grade sizeToFit];

    UILabel *type = [[UILabel alloc]initWithFrame:CGRectZero];
    type.text = [dic[@"property"] substringToIndex:2];
    type.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    type.font = [UIFont systemFontOfSize:fontSize];
    [type sizeToFit];

    
    UILabel *courseName = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width-type.frame.origin.x-5, self.frame.size.height)];
    courseName.text = dic[@"course"] ;
    courseName.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    courseName.font = [UIFont systemFontOfSize:fontSize];
    [courseName sizeToFit];

    [self addSubview:grade];
    [self addSubview:type];
    [self addSubview:courseName];
    
    [courseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(16);
        make.bottom.mas_equalTo(self).offset(-18);
        make.left.mas_equalTo(self).offset(18);
    }];
    

    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(16);
        make.bottom.mas_equalTo(self).offset(-18);
        make.right.mas_equalTo(self).offset(-18);
    }];
    
    [grade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(16);
        make.bottom.mas_equalTo(self).offset(-18);
        make.right.mas_equalTo(type.mas_left).offset(-18);
    }];

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
