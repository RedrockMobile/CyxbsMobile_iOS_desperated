//
//  TodayViewController.m
//  ClassWidget
//
//  Created by user on 15/11/3.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//
//#warning 先放这测试,remove
//#if DEBUG
//#define NSLog(format, ...) do {                                                                          \
//fprintf(stderr, "<%s : %d> | %s\n",                                           \
//[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
//__LINE__, __func__);                                                        \
//(NSLog)((format), ##__VA_ARGS__);                                           \
//fprintf(stderr, "-------\n");                                               \
//} while (0)
//#else
//#define NSLog(format, ...) ;
//#endif
//#define kAPPGroupID @"group.com.redrock.mobile"
//#define kAppGroupShareNowDay @"nowDay"
//#define kAppGroupShareThisWeekArray @"thisWeekArray"
//#define kAutoUpdateInterval 60*5
//#define kTableViewCellRowHeight 100

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#define kAPPGroupID @"group.com.redrock.mobile"
#define MaxWidth [UIScreen mainScreen].bounds.size.width
#define NumberLabelHeight 17
#define NumberLabelWidth 17
#define LessonLabelWidth (MaxWidth -NumberLabelWidth) * 0.75
#define ClassroomLabelWidth (MaxWidth -NumberLabelWidth) * 0.37

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic, strong) NSMutableArray *weekDataArray;
@property (nonatomic, strong) NSMutableArray <UILabel *>*lessonLabelArray;

@end

@implementation TodayViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self newWeekDataArray];
    [self creatNumberLabel];
    [self creatLessonLabel];
    [self creatRoomLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

- (void)creatRoomLabel
{
    NSString *infoStr = [[NSString alloc] init];
    for (int i = 0;i < self.weekDataArray.count; i++)
    {
        infoStr = [NSString stringWithFormat:@"%@",self.weekDataArray[i][@"classroom"]];
        UILabel *infoLabel = [[UILabel alloc] init];
        CGRect labelFrame = self.lessonLabelArray[i].frame;
        
        labelFrame.origin.x = NumberLabelWidth + LessonLabelWidth;
        labelFrame.size.width = ClassroomLabelWidth;
        
        [self makeLabelWithText:infoStr frame:labelFrame label:infoLabel color:self.lessonLabelArray[i].backgroundColor courseLesson:YES];
        [self.view addSubview:infoLabel];
    }
}

- (void)creatLessonLabel
{
    NSString *infoStr = [[NSString alloc] init];
    UIColor *lableColor = [[UIColor alloc] init];
    self.lessonLabelArray = [[NSMutableArray alloc] init];
    int hashLesson,beginLesson,period;
    for (int i = 0; i < self.weekDataArray.count; i++) {
        UILabel *infoLabel = [[UILabel alloc] init];
        hashLesson = [[NSString stringWithFormat:@"%@",self.weekDataArray[i][@"hash_lesson"]] intValue];
        beginLesson = [[NSString stringWithFormat:@"%@",self.weekDataArray[i][@"begin_lesson"]] intValue];
        period = [[NSString stringWithFormat:@"%@",self.weekDataArray[i][@"period"]]intValue];
        infoStr = [NSString stringWithFormat:@"     %@",self.weekDataArray[i][@"course"]];
        if (beginLesson<=12) {
            lableColor = [UIColor colorWithRed:120/255.f green:219/255.f blue:195/255.f alpha:1];
        }
        if (beginLesson<=8){
            lableColor = [UIColor colorWithRed:249/255.f green:175/255.f blue:87/255.f alpha:1];
        }
        if (beginLesson<=4){
            lableColor = [UIColor colorWithRed:99/255.f green:210/255.f blue:246/255.f alpha:1];
        }
        if (hashLesson!=0) {
            hashLesson += period;
        }
        [self makeLabelWithText:infoStr frame:CGRectMake(NumberLabelWidth, hashLesson * NumberLabelHeight, LessonLabelWidth, period * NumberLabelHeight) label:infoLabel color:lableColor courseLesson:YES];
        [self.lessonLabelArray addObject:infoLabel];
        [self.view addSubview:infoLabel];
    }
}

- (void)creatNumberLabel
{
    for (int i = 0; i <= 12; i++) {
        UILabel *numberLabel = [[UILabel alloc] init];
        [self makeLabelWithText:[NSString stringWithFormat:@"%d",i+1] frame:CGRectMake(0, i * NumberLabelHeight, NumberLabelWidth, NumberLabelHeight) label:numberLabel color:nil courseLesson:NO];
        [self.view addSubview:numberLabel];
    }
}


- (void)makeLabelWithText:(NSString *)text frame:(CGRect)frame label:(UILabel *)label  color:(UIColor *)color courseLesson:(BOOL)course {
    label.numberOfLines = 0;
    if (course == YES) {
        label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        label.backgroundColor = color;
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentLeft;
    }else{
        label.textColor = [UIColor colorWithRed:97/255.0 green:102/255.0 blue:106/255.0 alpha:1];
        label.backgroundColor = [UIColor colorWithRed:206/255.0 green:214/255.0 blue:222/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:7];
    }
    label.text = text;
    [label setFrame:frame];
}


- (void)newWeekDataArray
{
    self.weekDataArray = [[NSMutableArray alloc]init];
    NSUserDefaults *userDefault = [[NSUserDefaults alloc]initWithSuiteName:kAPPGroupID];
    NSString *hashDate = [[NSString alloc] init];
    NSString *hashDay = [[NSString alloc] init];
    hashDate = [self weekDayStr];
    NSString *nowWeek = [NSString stringWithFormat:@"%@",[userDefault objectForKey:@"lessonResponse"][@"nowWeek"]];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[userDefault objectForKey:@"lessonResponse"][@"data"]];
    for (int i = 0; i < array.count; i++) {
        hashDay = [NSString stringWithFormat:@"%@",array[i][@"hash_day"]];
        if ([hashDay isEqualToString:hashDate]&&[array[i][@"week"] containsObject:[NSNumber numberWithInteger:[nowWeek integerValue]]]) {
            [self.weekDataArray addObject:array[i]];
        }
    }
}


- (NSString *)weekDayStr
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    
    [outputFormatter setDateFormat:@"EEEE"];
    
    NSString *newDateString = [outputFormatter stringFromDate:[NSDate date]];
    
    if ([newDateString isEqualToString:@"星期一"]) {
        return @"0";
    }
    if ([newDateString isEqualToString:@"星期二"]) {
        
        return @"1";
    }
    if ([newDateString isEqualToString:@"星期三"]) {
        
        return @"2";
    }
    if ([newDateString isEqualToString:@"星期四"]) {
        
        return @"3";
    }
    if ([newDateString isEqualToString:@"星期五"]) {
        
        return @"4";
    }
    if ([newDateString isEqualToString:@"星期六"]) {
        
        return @"5";
    }
    if ([newDateString isEqualToString:@"星期天"]) {
        return @"6";
    }
    return 0;
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    switch (activeDisplayMode)
    {
        case NCWidgetDisplayModeCompact:
        {
            self.preferredContentSize = CGSizeMake(0, 110);
        }
            break;
        case NCWidgetDisplayModeExpanded:
        {
            self.preferredContentSize = CGSizeMake(0, NumberLabelHeight*12);
        }
            break;
    }
}


@end
