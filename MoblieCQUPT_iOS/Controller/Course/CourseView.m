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
    
    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

    NSArray *array1 = [[NSArray alloc]initWithObjects:@"名称",@"老师",@"教室",@"时间",@"类型",@"周数", nil];
    NSArray *array2 = [[NSArray alloc]initWithObjects:@"iconfont-wodekecheng.png",@"iconfont-menuiconaccount.png",@"iconfont-location.png",@"iconfont-clock.png",@"iconfont-status.png",@"iconfont-week.png", nil];
    NSArray *array3 = [[NSArray alloc]initWithObjects:[dic objectForKey:@"course"],[dic objectForKey:@"teacher"],[dic objectForKey:@"classroom"],[NSString stringWithFormat:@"%@",[dic objectForKey:@"lesson"]],[dic objectForKey:@"type"],[dic objectForKey:@"rawWeek"], nil];
    NSArray *array4 = [[NSArray alloc]initWithObjects:@"8:00-9:40",@"10:05-11:45",@"14:00-15:40",@"16:05-17:45",@"19:00-20:40",@"21:05-22:45",nil];
    NSArray *array5 = [[NSArray alloc]initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(25, 15, 16, 20)];
    imageView1.image = [UIImage imageNamed:array2[0]];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(imageView1.frame.origin.x+imageView1.frame.size.width+10, 15, 20, 20)];
    label1.text = array1[0];
    label1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    label1.font = [UIFont systemFontOfSize:15];
    [label1 sizeToFit];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+10, 15, 50, 20)];
    label2.font = [UIFont systemFontOfSize:15];
    label2.text = array3[0];
    label2.numberOfLines = 0;
    CGRect rect = [label2.text boundingRectWithSize:CGSizeMake(infoView.frame.size.width-imageView1.frame.size.width-label1.frame.size.width-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:label2.font} context:nil];
    label2.frame = CGRectMake(label1.frame.origin.x+label1.frame.size.width+10, 15, rect.size.width, rect.size.height);
    
    [infoView addSubview:imageView1];
    [infoView addSubview:label1];
    [infoView addSubview:label2];

    NSMutableArray *imageArray = [NSMutableArray array];
    [imageArray addObject:imageView1];
    for (int i =1; i < 6; i++) {
        if (i < 4) {
            if (i == 3) {
                UIImageView *lastImageView = imageArray[imageArray.count-1];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, lastImageView.frame.origin.y+lastImageView.frame.size.height+20, 16, 20)];
                imageView.image = [UIImage imageNamed:array2[i]];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [imageArray addObject:imageView];
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, imageView.frame.origin.y, 20, 20)];
                label.text = array1[i];
                label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                label.font = [UIFont systemFontOfSize:15];
                [label sizeToFit];
                
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x+label.frame.size.width+10, label.frame.origin.y, 100, 20)];
                label1.font = [UIFont systemFontOfSize:15];
                label1.text = array3[i];
                NSInteger hash_lesson = [[dic objectForKey:@"hash_lesson"] integerValue];
                NSInteger day = [[dic objectForKey:@"day"] integerValue];
                label1.text = [NSString stringWithFormat:@"%@ %@",array5[day],array3[i]];
                label1.numberOfLines = 0;
                [label1 sizeToFit];
                
                _thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x, label1.frame.origin.y+label1.frame.size.height+10, 20, 20)];
                _thirdLabel.text = array4[hash_lesson];
                _thirdLabel.font = [UIFont systemFontOfSize:15];
                [_thirdLabel sizeToFit];
                [imageArray addObject:_thirdLabel];
                
                [infoView addSubview:imageView];
                [infoView addSubview:label];
                [infoView addSubview:label1];
                [infoView addSubview:_thirdLabel];
            }else {
                UIImageView *lastImageView = imageArray[imageArray.count-1];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, lastImageView.frame.origin.y+lastImageView.frame.size.height+20, 16, 20)];
                imageView.image = [UIImage imageNamed:array2[i]];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [imageArray addObject:imageView];
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, imageView.frame.origin.y, 20, 20)];
                label.text = array1[i];
                label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                label.font = [UIFont systemFontOfSize:15];
                [label sizeToFit];
                
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x+label.frame.size.width+10, label.frame.origin.y, 100, 20)];
                label1.font = [UIFont systemFontOfSize:15];
                label1.text = array3[i];
                label1.numberOfLines = 0;
                CGRect rect = [label1.text boundingRectWithSize:CGSizeMake(infoView.frame.size.width-imageView.frame.size.width-label.frame.size.width-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:label1.font} context:nil];
                label1.frame = CGRectMake(label.frame.origin.x+label.frame.size.width+10, label.frame.origin.y ,rect.size.width, rect.size.height);
                
                [infoView addSubview:imageView];
                [infoView addSubview:label];
                [infoView addSubview:label1];
            }
        }else {
            CGRect rect;
            if (i == 4) {
                UILabel *lastImageView = imageArray[imageArray.count-1];
                rect = lastImageView.frame;
            }else if (i == 5) {
                UIImageView *lastImageView = imageArray[imageArray.count-1];
                rect = lastImageView.frame;
            }
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, rect.origin.y+rect.size.height+20, 16, 20)];
            imageView.image = [UIImage imageNamed:array2[i]];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [imageArray addObject:imageView];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, imageView.frame.origin.y, 20, 20)];
            label.text = array1[i];
            label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:15];
            [label sizeToFit];
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x+label.frame.size.width+10, label.frame.origin.y, 100, 20)];
            label1.font = [UIFont systemFontOfSize:15];
            label1.text = array3[i];
            label1.numberOfLines = 0;
            
            [infoView addSubview:imageView];
            [infoView addSubview:label];
            [infoView addSubview:label1];
        }
    }
    [self addSubview:infoView];
}

@end
