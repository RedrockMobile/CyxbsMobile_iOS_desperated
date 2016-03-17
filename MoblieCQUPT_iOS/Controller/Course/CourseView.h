//
//  CourseView.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/8/22.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"



@interface CourseView : UIView

@property (strong, nonatomic) UILabel *thirdLabel;
- (CourseView *)initWithFrame:(CGRect)frame withDictionary:(NSDictionary *)dic;
@end
