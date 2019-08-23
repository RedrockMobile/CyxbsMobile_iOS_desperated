//
//  LQQsubjectDataView.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/5.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#define HIGHTPERONE 26//每个单位的高度
#import "LQQsubjectDataView.h"

@implementation LQQsubjectDataView
-(instancetype)initWithDictionary:(NSArray<NSDictionary*> *)subjectArr;
{
    self = [super init];
        if (self) {
            _subjectArr = subjectArr;
            _x = 0;
        }
        return self;

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if(_x==0){
    UILabel*title = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 260, 40)];
    //            title.backgroundColor = [UIColor blackColor];
    title.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:17.0f];
    title.textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.75f];
    title.text = @"2018-2019部分学科难度系数";
    [self addSubview:title];
    
    
    _viewOne = [[UIView alloc]init];
    _viewOne.backgroundColor = [UIColor colorWithRed:128.0f/255.0f green:155.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    _viewTwo = [[UIView alloc]init];
    _viewTwo.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:116.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
    _viewThree = [[UIView alloc]init];
    _viewThree.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:206.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    
    _xyZhou = [[UIImageView alloc]init];
    [self addSubview:_xyZhou];
    [_xyZhou setImage:[UIImage imageNamed:@"xyZhou"]];
//    _xyZhou.backgroundColor = [UIColor blackColor];
    [_xyZhou mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(self).multipliedBy(0.90);
        make.height.equalTo(self).multipliedBy(0.55);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        
    }];
    UILabel*leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(-7, -13, 20, 110)];
    //            leftLabel.backgroundColor = [UIColor blackColor];
    leftLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f];
    leftLabel.text = @"难\n度\n系\n数";
    [_xyZhou addSubview:leftLabel];
    leftLabel.numberOfLines = [leftLabel.text length];
    [leftLabel setTextColor:[UIColor colorWithRed:153.0f/255.0f green:175.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    
    _viewOne.frame = CGRectMake( (148.0/(70+452+148))*self.bounds.size.width,self.bounds.size.height*(199+292.0-41)/(199+104+292), 40,0);
//    _viewOne.backgroundColor = [UIColor whiteColor];
    //            _viewOne
    _viewTwo.frame = CGRectMake((336.0/(70+336+315))*self.bounds.size.width,self.bounds.size.height*(199+292.0-41)/(199+104+292), 40,0);
    _viewThree.frame = CGRectMake((494.0/(70+453+147))*self.bounds.size.width,self.bounds.size.height*(199+292.0-41)/(199+104+292), 40,0);
    float x0 = 0;
    float x1 = 0;float x2 = 0;NSString*value0 = [[NSString alloc]init];NSString*value1 = [[NSString alloc]init];NSString*value2 = [[NSString alloc]init];//定义了六个值用来记录三个百分比和三个汉字
    [self addSubview:_viewTwo];
    [self addSubview:_viewThree];
    [self addSubview:_viewOne];
    int i =0;
    for (NSMutableDictionary*dic in _subjectArr) {
//        NSLog(@"*-*-*-%@",key);
        
        if(i == 0){
            x0 =  HIGHTPERONE*10*[[dic valueForKey:dic.allKeys[0]] floatValue];
            value0 = dic.allKeys[0];
        }
        if(i == 1){
            x1 =  HIGHTPERONE*10*[[dic valueForKey:dic.allKeys[0]] floatValue];
            value1 = dic.allKeys[0];
            
        }
        if(i == 2){
            x2 =  HIGHTPERONE*10*[[dic valueForKey:dic.allKeys[0]] floatValue];
            value2 =dic.allKeys[0];
            
        }
        i++;
    }
//    _viewOne.frame = CGRectMake(self.bounds.size.width/2.0, self.bounds.size.height*(199+292.0)/(199+104+292), 40,10);

    [UIView animateWithDuration:1 animations:^{
        //                _viewOne.frame = CGRectMake(75,306-x0,40,x0);
        _viewOne.frame = CGRectMake(148.0/(70+452+148)*self.bounds.size.width, self.bounds.size.height*(199+292.0-41)/(199+104+292)-x0,40, x0);
        
        UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(5, -15, 45, 15)];
        //                label.backgroundColor = [UIColor blackColor];
        label.text = [NSString stringWithFormat:@"%.2f",x0/(HIGHTPERONE*10.0)];
        label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f];
        label.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:0.8f];
        [_viewOne addSubview:label];
    }];
    
    
    [UIView animateWithDuration:1 animations:^{
        _viewTwo.frame = CGRectMake((336.0/(70+336+315))*self.bounds.size.width,self.bounds.size.height*(199+292.0-41)/(199+104+292)-x1, 40,x1);
        UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(5, -15, 45, 15)];
        //            label.backgroundColor = [UIColor blackColor];
        label.text = [NSString stringWithFormat:@"%.2f",x1/(HIGHTPERONE*10.0)];
        label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f];
        label.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:0.8f];
        [_viewTwo addSubview:label];
    }];
    [UIView animateWithDuration:1 animations:^{
        _viewThree.frame = CGRectMake((494.0/(70+453+147))*self.bounds.size.width,self.bounds.size.height*(199+292.0-41)/(199+104+292)-x2, 40,x2);
        UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(5, -15, 45, 15)];
        //            label.backgroundColor = [UIColor blackColor];
        label.text = [NSString stringWithFormat:@"%.2f",x2/(HIGHTPERONE*10.0)];
        label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f];
        label.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:0.8f];
        [_viewThree addSubview:label];
    }completion:^(BOOL finished) {
        
        
    }];
    UILabel*subject1 = [[UILabel alloc]init];//用来存放科目
    subject1.text = value0;
    [self addSubview:subject1];
    [subject1 setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f]];
    subject1.textColor = [UIColor colorWithRed:92.0f/255.0f green:127.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    //            subject1.backgroundColor = [UIColor blackColor];
    subject1.numberOfLines = 2;
    subject1.textAlignment = NSTextAlignmentCenter;
    [subject1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_viewOne);
        make.height.equalTo(@50);
        make.width.equalTo(_viewOne).offset(25);
        make.top.equalTo(_viewOne.mas_bottom).offset(8);
        
    }];
    UILabel*subject2 = [[UILabel alloc]init];//用来存放科目
    subject2.text = value1;
    [self addSubview:subject2];
    //            subject2.backgroundColor = [UIColor redColor];
    [subject2 setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f]];
    subject2.textColor = [UIColor colorWithRed:92.0f/255.0f green:127.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    subject2.numberOfLines = 2;
    subject2.textAlignment = NSTextAlignmentCenter;
    [subject2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_viewTwo);
        make.height.equalTo(@50);
        make.width.equalTo(_viewTwo).offset(25);
        make.top.equalTo(_viewTwo.mas_bottom).offset(8);
        
    }];
    UILabel*subject3 = [[UILabel alloc]init];//用来存放科目
    [self addSubview:subject3];
    subject3.text = value2;
    //            subject3.backgroundColor = [UIColor blackColor];
    [subject3 setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f]];
    subject3.textColor = [UIColor colorWithRed:92.0f/255.0f green:127.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    subject3.numberOfLines = 2;
    subject3.textAlignment = NSTextAlignmentCenter;
    [subject3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_viewThree);
        make.height.equalTo(@50);
        make.width.equalTo(_viewThree).offset(25);
        make.top.equalTo(_viewThree.mas_bottom).offset(8);
        
    }];

        _x+=1;
    }

}

@end
