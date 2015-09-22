//
//  CourseView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/8/22.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "CourseView.h"
#define kViewWidth infoView.frame.size.width
#define kViewHeight infoView.frame.size.height/6
@implementation CourseView

- (instancetype)initWithFrame:(CGRect)frame withDictionary:(NSDictionary *)dic
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadAlertView:dic];
    }
    return self;
}

- (void)loadAlertView:(NSDictionary *)dic {
    
    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/9*7-30, ScreenHeight/7*5-75-65)];

    NSArray *array1 = [[NSArray alloc]initWithObjects:@"名称",@"老师",@"教室",@"时间",@"属性",@"周数", nil];
    NSArray *array2 = [[NSArray alloc]initWithObjects:@"iconfont-wodekecheng.png",@"iconfont-menuiconaccount.png",@"iconfont-location.png",@"iconfont-clock.png",@"iconfont-status.png",@"iconfont-week.png", nil];
    NSArray *array3 = [[NSArray alloc]initWithObjects:[dic objectForKey:@"course"],[dic objectForKey:@"teacher"],[dic objectForKey:@"classroom"],[NSString stringWithFormat:@"%@",[dic objectForKey:@"lesson"]],[dic objectForKey:@"type"],[dic objectForKey:@"rawWeek"], nil];
    for (int i = 0; i < 6; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kViewHeight*i, kViewWidth, kViewHeight)];
        [infoView addSubview:view];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/20, view.frame.size.height/2.5, view.frame.size.width/15, view.frame.size.width/15)];
        imageView.center = CGPointMake(view.frame.size.width/15, view.frame.size.height/2);
        imageView.image = [UIImage imageNamed:array2[i]];
        [view addSubview:imageView];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.size.width+view.frame.size.width/25*2, view.frame.size.height/3, view.frame.size.width/10*1.5, view.frame.size.width/10)];
        label1.center = CGPointMake(view.frame.size.width/10*2, view.frame.size.height/2);
        label1.text = array1[i];
        label1.font = [UIFont systemFontOfSize:14];
        label1.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.size.width+view.frame.size.width/10*2, view.frame.size.height/3, view.frame.size.width/10*6, view.frame.size.width/10)];
        label2.center = CGPointMake(view.frame.size.width/10*6, view.frame.size.height/2);
        label2.font = [UIFont systemFontOfSize:16];
        label2.text = array3[i];
        [view addSubview:label2];
    }
    [self addSubview:infoView];
}

@end
