//
//  EmptyClassView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/10/5.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "EmptyClassView.h"
#import <Masonry.h>
@interface EmptyClassView ()<UIScrollViewDelegate>
{
    //储存各个按钮
   
    NSMutableArray<UIButton*> *weekArray;
    NSMutableArray<UIButton*> *buildArray;
    NSMutableArray<UIButton*> *classArray;
    NSMutableArray<UIButton*> *weekdayArray;
    //各个按钮当前位置
    NSInteger currentIndexInWeek;
    NSInteger currentIndexInWeekday;
    NSInteger currentIndexInbuild;
    
    //class按钮前的图
    NSMutableArray<UIImageView *> *imageForeClassArray;
    NSMutableArray<UIImageView *> *imageForeBuildArray;
    
}
//各个按键前的图
@property (nonatomic, strong) UIImageView *imageForeWeek;
@property (nonatomic, strong) UIImageView *imageForeWeekday;
@property (nonatomic, strong) UIImageView *imageForeBuild;
@property (nonatomic, strong) UIScrollView *weekScrollView;
@property (strong, nonatomic) NSMutableDictionary *emptyClassData;

@end
@implementation EmptyClassView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _time = [NSMutableArray array];
        _emptyClassData = [NSMutableDictionary dictionary];
        [self setUp];
        self.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    }
    return self;
}

-(void)setUp{
    //阴影
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2,2);
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowRadius = 5.f;
    //界面设置
    _weekScrollView = [self setUpScrollView];
    _weekScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_weekScrollView];
    UIView *sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, _weekScrollView.bottom, SCREENWIDTH, 3)];
    sliderView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0/1.0];
    [self addSubview:sliderView];
 
    NSArray *weekday = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    UIView *weekdayView = [self setUpWeekdayBtn:weekday];
    weekdayView.backgroundColor = [UIColor whiteColor];
    weekdayView.frame = CGRectMake(0, sliderView.bottom, SCREENWIDTH, (self.size.height - 6 )/ 4 );
    [self addSubview: weekdayView];
    
    UIView *buildView = [self setUpBuildBtn];
    buildView.backgroundColor = [UIColor whiteColor];
    buildView.frame = CGRectMake(0, weekdayView.bottom + 1.5, SCREENWIDTH, (self.size.height - 6 )/ 4 );
    [self addSubview:buildView];

    UIView *classView = [self setUpClassBtn];
    classView.backgroundColor = [UIColor whiteColor];
    classView.frame = CGRectMake(0, buildView.bottom + 1.5, SCREENWIDTH, (self.size.height - 6 )/ 4 );
    [self addSubview:classView];

    //添加操作btn
    _handleBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    _handleBtn.selected = YES;
    _handleBtn.adjustsImageWhenHighlighted = NO;
    [_handleBtn addTarget:self action:@selector(changeSelected:) forControlEvents:UIControlEventTouchUpInside];
    [_handleBtn setImage:[UIImage imageNamed:@"pullUp"] forState:UIControlStateSelected];
    [_handleBtn setImage:[UIImage imageNamed:@"pullDown"] forState:UIControlStateNormal];
    _handleBtn.frame = CGRectMake(self.centerX - 12.5, self.bottom - 10, 25, 25);
    [self addSubview:_handleBtn];
}
//周数的滑动栏
-(UIScrollView *)setUpScrollView{
    //初始化时停在本周的位置上
    NSNumber *num = [UserDefaultTool valueWithKey:@"nowWeek"];
    NSString *nowWeek = [num stringValue];
    UIScrollView *weekScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height / 4)];
    weekScrollView.contentSize = CGSizeMake(65 * 19, 45);
    weekScrollView.showsVerticalScrollIndicator = NO;
    weekScrollView.showsHorizontalScrollIndicator = NO;
    [weekScrollView flashScrollIndicators];
    weekArray = [NSMutableArray array];
    for (int i = 1; i <= 19; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [weekArray addObject:btn];
        [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8300000000000001/1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(changeWeek:)  forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
        [btn setTitle:[NSString stringWithFormat:@"第%d周",i] forState:UIControlStateNormal];
        btn.frame = CGRectMake((i - 1) * 45 + i * 22, 13, 45, 17);
        if (i == 1) {
            _imageForeWeek = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imageForeWeek"]];
            _imageForeWeek.frame = CGRectMake(0, 9, 56, 27);
            [weekScrollView addSubview:_imageForeWeek];
        }
        if (i == nowWeek.intValue) {
            btn.selected = YES;
            [_emptyClassData setObject:[NSString stringWithFormat:@"%d",i] forKey:@"week"];
            [UIView beginAnimations:@"FrameAni" context:nil];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationDelegate:_imageForeWeek];
            [UIView setAnimationRepeatCount:1];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            _imageForeWeek.frame = CGRectMake(btn.centerX - 28, 9, 56, 27);
            [UIView commitAnimations];
            [weekScrollView setContentOffset:CGPointMake((i - 1) * 67, 0) animated:YES];
            currentIndexInWeek = i;
        }
        [weekScrollView addSubview:btn];
    }
    return weekScrollView;
}
//各个按钮栏
- (UIView *)setUpWeekdayBtn:(NSArray *)array{
    UIView *btnView = [[UIView alloc] init];
    NSString *index = [[NSString alloc]initWithFormat:@"%@",[UserDefaultTool valueWithKey:@"weekdayNum"]];
    [_emptyClassData setObject:index forKey:@"weekdayNum"];
    currentIndexInWeekday = index.intValue;
    weekdayArray = [NSMutableArray array];
    _imageForeWeekday = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ImageForeWeekday"]];
    _imageForeWeekday.frame = CGRectMake((index.intValue + 1) * 23 + index.intValue * 29 - 7  , 10, 45, 27);
    [btnView addSubview:_imageForeWeekday];
    for (int i = 0; i < array.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8300000000000001/1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(changeValue:)  forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake((i  + 1 ) * 23 + i * 29, 13, 29, 17);
        if (i == index.intValue) {
            btn.selected = YES;
        }
        [weekdayArray addObject:btn];
        [btnView addSubview:btn];
    }
    return btnView;
}
-(UIView *)setUpBuildBtn{
    UIView *btnView = [[UIView alloc]init];
    NSArray *buildArry = @[@"二教",@"三教",@"四教",@"五教",@"八教"];
    buildArray = [NSMutableArray array];
    imageForeBuildArray = [NSMutableArray array];
    for (int i = 0; i < buildArry.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8300000000000001/1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(changeBuildSelected:)  forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:buildArry[i] forState:UIControlStateNormal];
        if (i == 0) {
            btn.frame = CGRectMake(23, 10, 0, 0);
        }
        else{
            btn.frame = CGRectMake(20 + buildArray[i - 1].right, 10, 0, 0);
        }
        [btn sizeToFit];
        UIImageView *img = [[UIImageView alloc]init];
        img.size = CGSizeMake(45, 27);
        img.centerX = btn.centerX - 1;
        img.centerY = btn.centerY + 2;
        img.image = [UIImage imageNamed:@"ImageForeClass"];
        img.hidden = YES;
        [imageForeBuildArray addObject:img];
        [btnView addSubview:img];
        [buildArray addObject:btn];
        [btnView addSubview:btn];
    }
    return btnView;
}
//class的按钮
-(UIView *)setUpClassBtn{
    UIView *btnView = [[UIView alloc] init];
    NSArray *class = @[@"1-2节",@"3-4节",@"5-6节",@"7-8节",@"9-10节",@"11-12节"];
    classArray = [NSMutableArray array];
    imageForeClassArray = [NSMutableArray array];
    for (int i = 0; i < class.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8300000000000001/1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(changeClassSelected:)  forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:class[i] forState:UIControlStateNormal];
        if (i == 0) {
            btn.frame = CGRectMake(23, 10, 0, 0);
        }
        else{
            btn.frame = CGRectMake(20 + classArray[i - 1].right, 10, 0, 0);
        }
        [btn sizeToFit];
        UIImageView *img = [[UIImageView alloc]init];
        img.size = CGSizeMake(62, 33);
        img.centerX = btn.centerX - 1;
        img.centerY = btn.centerY + 2;
        img.image = [UIImage imageNamed:@"ImageForeClass"];
        img.hidden = YES;
        [imageForeClassArray addObject:img];
        [btnView addSubview:img];
        [classArray addObject:btn];
        [btnView addSubview:btn];
    }
    return btnView;
}
//周数的点击事件
- (void)changeWeek:(UIButton *)btn{
    if (![weekArray[currentIndexInWeek - 1] isEqual: btn]) {
        weekArray[currentIndexInWeek - 1].selected = NO;
        for (int i = 0; i < weekArray.count; i ++) {
            if([weekArray[i] isEqual: btn]){
                currentIndexInWeek = i + 1;
            }
        }
        [_emptyClassData setObject:[NSString stringWithFormat:@"%ld",(long)currentIndexInWeek] forKey:@"week"];
        [self checkUpTheDic:_emptyClassData];
        btn.selected = YES;
        //动画
        if (currentIndexInWeek ==  1){
            [_weekScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (currentIndexInWeek < 16) {
            [_weekScrollView setContentOffset:CGPointMake(btn.left - 50, 0) animated:YES];
        }
        else{
            [_weekScrollView setContentOffset:CGPointMake(14 * 65, 0) animated:YES];
        }
        [UIView beginAnimations:@"FrameAni" context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:_imageForeWeek];
        [UIView setAnimationRepeatCount:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        _imageForeWeek.frame = CGRectMake(btn.centerX - 28, 9, 56, 27);
        [UIView commitAnimations];


    }
    
}
- (void)changeValue:(UIButton *)btn{
    UIImageView *nowImageView;
    NSString *aString = [[NSString alloc]initWithString:btn.currentTitle];
    if ([[aString substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"周"]&&![weekdayArray[currentIndexInWeekday] isEqual: btn]) {
        weekdayArray[currentIndexInWeekday].selected = NO;
        for (int i = 0; i < weekdayArray.count; i ++) {
            if([weekdayArray[i] isEqual: btn]){
                currentIndexInWeekday = i;
                btn.selected = YES;
                [_emptyClassData setObject:[NSString stringWithFormat:@"%d",i] forKey:@"weekdayNum"];
                [self checkUpTheDic:_emptyClassData];
            }
        }
        nowImageView = _imageForeWeekday;
    }
    else{
        buildArray[currentIndexInbuild].selected = NO;
        for (int i = 0; i < buildArray.count; i ++) {
            if([buildArray[i] isEqual: btn]){
                currentIndexInbuild = i;
                [_emptyClassData setObject:[NSString stringWithFormat:@"%d",i] forKey:@"buildNum"];
                [self checkUpTheDic:_emptyClassData];
                btn.selected = YES;
            }
        }
        nowImageView = _imageForeBuild;
    }
    [UIView beginAnimations:@"FrameAni" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:nowImageView];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    nowImageView.frame = CGRectMake(btn.centerX - 22.5, nowImageView.frame.origin.y, nowImageView.frame.size.width, nowImageView.frame.size.height);
    [UIView commitAnimations];
}
-(void)changeBuildSelected:(UIButton *)btn{
    if (!btn.selected) {
        for (int i = 0; i < buildArray.count; i ++) {
            if([buildArray[i] isEqual: btn]){
                currentIndexInbuild =i;
                btn.selected = YES;
                [_emptyClassData setObject:[NSString stringWithFormat:@"%d",i] forKey:@"buildNum"];
                [self checkUpTheDic:_emptyClassData];
                imageForeBuildArray[i].hidden = NO;
            }
            else{
                imageForeBuildArray[i].hidden = YES;
                buildArray[i].selected = NO;
            }
        }
    }
}
-(void)changeClassSelected:(UIButton *)btn{
    if (!btn.selected) {
        btn.selected = !btn.selected;
        for (int i = 0; i < classArray.count; i ++) {
            if([classArray[i] isEqual: btn]){
                [_time addObject:[NSString stringWithFormat:@"%d", i]];
                btn.selected = YES;
                [_emptyClassData setObject:_time forKey:@"sectionNum"];
                [self checkUpTheDic:_emptyClassData];
                imageForeClassArray[i].hidden = NO;
            }
        }
        
    }
    else {
        for (int i = 0; i < classArray.count; i ++) {
            if([classArray[i] isEqual: btn]){
                [_time removeObject:[NSString stringWithFormat:@"%d", i]];
                [_emptyClassData setObject:_time forKey:@"section"];
                [self checkUpTheDic:_emptyClassData];
                btn.selected = NO;
                imageForeClassArray[i].hidden = YES;
            }
        }
    }
}
-(void)changeSelected:(UIButton *)btn{
    btn.selected = !btn.selected;
}
//解决按键在view外
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)even{
    if (CGRectContainsPoint(CGRectMake(0, 0, SCREENWIDTH, self.size.height),point)||CGRectContainsPoint(CGRectMake(0, self.size.height, SCREENWIDTH, 15),point)) {

        return YES;
    }
    else{
        return NO;
    }
}

- (void)checkUpTheDic:(NSDictionary *)dic{

    if (_emptyClassData[@"week"] && _emptyClassData[@"weekdayNum"] && _emptyClassData[@"buildNum"] &&
        _emptyClassData[@"sectionNum"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"checkReady" object:[self changeTheDic:self.emptyClassData]];
    }
}
//数据处理
- (NSDictionary *)changeTheDic:(NSDictionary *)dic{
    NSString *week = [[NSString alloc]initWithString:dic[@"week"]];
    NSString *weekdayNum = [[NSString alloc]initWithString:dic[@"weekdayNum"]];
    NSString *buildNum = [[NSString alloc]initWithString:dic[@"buildNum"]];
    NSArray *sectionNum = [[NSArray alloc] initWithArray:dic[@"sectionNum"]];
    NSMutableDictionary *newDic = [[NSMutableDictionary alloc]init];
    [newDic setObject:week forKey:@"week"];
    [newDic setObject:[[NSString alloc] initWithFormat:@"%d",weekdayNum.intValue + 1] forKey:@"weekdayNum"];
    if ([buildNum isEqualToString:@"4"]) {
        buildNum = @"8";
    }
    else{
        buildNum = [[NSString alloc]initWithFormat:@"%d", buildNum.intValue + 2 ];
    }
    [newDic setObject:buildNum forKey:@"buildNum"];
    [newDic setObject:sectionNum forKey:@"sectionNum"];
    return newDic;
}
    
@end
