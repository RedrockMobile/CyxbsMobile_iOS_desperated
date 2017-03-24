//
//  MainView.m
//  Demo
//
//  Created by 李展 on 2016/10/26.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "MainView.h"
#import "PrefixHeader.pch"
@interface MainView()
@property NSArray *weekDay;

@end

@implementation MainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.weekDay = @[@"一", @"二", @"三", @"四", @"五", @"六",@"日"];
        [self initDayLb];
        [self initMainScrollView];
        [self initLessonLb];
//        [self initLeesonBtn];
    }
    return self;
}


- (void)initDayLb{
    self.monthLabel = [[DayLabel alloc]initWithFrame:CGRectMake(0, 0, MWIDTH, MHEIGHT)];
    [self addSubview:self.monthLabel];
    
    CGFloat dayLbHeight = MHEIGHT;
    CGFloat dayLbWidth = (self.frame.size.width-MWIDTH)/DAY;
    self.dayLabels = [NSMutableArray arrayWithCapacity:DAY];
    for (int i = 0; i < DAY; i++) {
        self.dayLabels[i] = [[DayLabel alloc]initWithFrame:CGRectMake(MWIDTH+i*dayLbWidth, 0,dayLbWidth, dayLbHeight)];
        self.dayLabels[i].text = self.weekDay[i];
        [self addSubview:self.dayLabels[i]];
    }
    [self loadDayLbTimeWithWeek:0 nowWeek:0];
}

- (void)loadDayLbTimeWithWeek:(NSInteger)week nowWeek:(NSInteger)nowWeek{
    NSDate *now = [NSDate date];
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc]init];
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc]init];
    [monthFormatter setDateFormat:@"MM"];
    [dayFormatter setDateFormat:@"dd"];

    
    NSTimeInterval  oneDay = 24*60*60;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:now];
    for (int i = 0; i < DAY; i++) {
        self.dayLabels[i].backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        NSTimeInterval timeInterval = ((week-nowWeek)*7+(i-(components.weekday+5)%7))*oneDay;
        NSDate *date = [NSDate dateWithTimeInterval:timeInterval sinceDate:now];
        if (i == 0) {
            self.monthLabel.text = [[monthFormatter stringFromDate:date] stringByAppendingString:@"\n月"];
        }
        NSString *day = [dayFormatter stringFromDate:date];
        if (i != 0 && [day isEqualToString:@"01"]) {
            day = [[monthFormatter stringFromDate:date] stringByAppendingString:@"月"];
        }
        self.dayLabels[i].text = [NSString stringWithFormat:@"%@\n%@",day,self.weekDay[i]];
        if (i == (components.weekday+5)%7) {
            self.dayLabels[i].textColor = [UIColor colorWithRed:138/255.0 green:179/255.0 blue:245/255.0 alpha:1];
        }
    }
}


- (void)removeDayLbTime{
    self.monthLabel.text = @" ";
    for (int i = 0; i < DAY; i++) {
        self.dayLabels[i].text = self.weekDay[i];
//        self.dayLabels[i].textColor = [UIColor blackColor];
    }
}

- (void)initMainScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, MHEIGHT, self.frame.size.width, self.frame.size.height-MHEIGHT)];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, LESSONBTNSIDE*LESSON);
    self.scrollView.bounces = NO;
    [self addSubview:self.scrollView];
}

- (void)initLessonLb{
    for (int i = 1; i <= LESSON; i++) {
        LessonNumLabel *lessonLb = [[LessonNumLabel alloc]initWithFrame:CGRectMake(0, (LESSONBTNSIDE)*(i-1), MWIDTH, LESSONBTNSIDE)];
        lessonLb.text = [NSString stringWithFormat:@"%d",i];
        [self.scrollView addSubview:lessonLb];
    }
}


//- (void)initLeesonBtn{
//    self.lessonBtns = [NSMutableArray array];
//    for (int i = 0; i<DAY; i++) {
//        for (int j = 0; j<LESSON/2; j++) {
//            LessonButton *lessonBtn = [[LessonButton alloc]initWithFrame:CGRectMake(MWIDTH+i*LESSONBTNSIDE+i*SEGMENT, j*LESSONBTNSIDE*2+j*SEGMENT, LESSONBTNSIDE, LESSONBTNSIDE*2)];
////            lessonBtn.backgroundColor = [UIColor whiteColor];
//            [self.scrollView addSubview:lessonBtn];
//            [self.lessonBtns addObject:lessonBtn];
//        }
//    }
//}


@end
