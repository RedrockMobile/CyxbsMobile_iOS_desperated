//
//  TodayViewController.m
//  ClassWidget
//
//  Created by user on 15/11/3.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//
#warning 先放这测试,remove
#if DEBUG
#define NSLog(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> | %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)
#else
#define NSLog(format, ...) ;
#endif
#define kAPPGroupID @"group.com.mredrock.cyxbs"
#define kAppGroupShareNowDay @"nowDay"
#define kAppGroupShareThisTermArray @"thisTerm"
#define kAutoUpdateInterval 60*5
#define kTableViewCellRowHeight 100

#import "TodayViewController.h"
#import "ClassTableViewCell.h"
#import <NotificationCenter/NotificationCenter.h>
#import "MOHLessonTimeModel.h"

@interface TodayViewController () <NCWidgetProviding,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray *todayClassArray;
@property (strong, nonatomic) UITableView *classTableView;
@end

@implementation TodayViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:self.classTableView];
    [self autoUpdateTimer];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:kAPPGroupID];
    NSArray *itemDataArray = [shared objectForKey:kAppGroupShareThisTermArray];
    
    
    NSArray *weakDataArray = [self getWeek:[self getThisWeek] fromTermArray:itemDataArray];
//    NSLog(@"%@",weakDataArray);
    self.todayClassArray = [self todayClassArrayFromWeakClassArray:weakDataArray];
    
    if (self.todayClassArray) {
        completionHandler(NCUpdateResultNewData);
    }else{
        completionHandler(NCUpdateResultNoData);
    }
    

    
}



- (NSArray *)todayClassArrayFromWeakClassArray:(NSArray *)weakClassArray{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSInteger today =  [componets weekday];
    today -= 1; //从周日开始转为从周一开始
    today = today>0?today:7;
//    NSLog(@"%@",[NSDate date]);
//    today = 4;
    
    
    NSMutableArray *mutableToDayClassArray = [NSMutableArray array];
    for (NSDictionary *row in weakClassArray) {
        NSString *tmpString = row[@"day"];

        if ([tmpString integerValue] == today) {
            [mutableToDayClassArray addObject:row];
        }
    }
    if (mutableToDayClassArray.count == 0) {
        //如果今天没课
        mutableToDayClassArray = [@[
                                    @{
                                      @"course":@"今天没有课程",
                                      @"classroom":@"红岩网校工作站",
                                      @"teacher":@"难得的一天,尽情的玩耍下吧^_^",
                                      @"begin_lesson":@"-1"}
                                      ] mutableCopy];
    }
    NSLog(@"今日周%ld,数据:%@",(long)today,mutableToDayClassArray);
    return mutableToDayClassArray;
}

- (void)autoUpdateTimer{
    NSTimer *timer = [[NSTimer alloc]
                initWithFireDate:[NSDate distantPast]
                        interval:kAutoUpdateInterval
                        target:self
                        selector:@selector(updateTodayClass)
                        userInfo:nil
                        repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}


- (void)updateTodayClass{
    
    [self widgetPerformUpdateWithCompletionHandler:^(NCUpdateResult result) {
        
        [self updateView];
    }];
    NSLog(@"更新今日课程数据");
    
    
    
}

#pragma UI 相关
- (void) updateView{
    NSLog(@"更新界面:%ld",(unsigned long)self.todayClassArray.count);
    [self.classTableView reloadData];
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, kTableViewCellRowHeight*self.todayClassArray.count);
    self.classTableView.frame = self.view.bounds;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.todayClassArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTableViewCellRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.extensionContext openURL:[NSURL URLWithString:@"cyxbs://class"] completionHandler:^(BOOL success) {
        NSLog(@"open succeed");
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identify = @"ClassCell";
    ClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[ClassTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSDictionary *lessonDictionary = self.todayClassArray[indexPath.row];
    NSString *classTime =
    [MOHLessonTimeModel
        stringWithBeginLesson:[lessonDictionary[@"begin_lesson"] integerValue]
        period:[lessonDictionary[@"period"] integerValue]];

    if([lessonDictionary[@"begin_lesson"] integerValue]==-1){
        cell.classNameLabel.textColor = [UIColor orangeColor];
    }

    
    cell.classNameLabel.text = lessonDictionary[@"course"];
    cell.teacherLabel.text   = lessonDictionary[@"teacher"] ;
    cell.classroomLabel.text = lessonDictionary[@"classroom"];
    cell.classTimeLabel.text = classTime;

    return cell;
    
}


//- (NSString *)stringWithBeginLesson:(NSInteger)beginLesson
//                             period:(NSInteger)time{
//    NSLog(@"%ld==%ld",(long)beginLesson,(long)time);
//    NSString *startTimeString,*endTimeString,*string;
//    NSInteger baseClassNum = 1;
//    if (beginLesson == -1) {
//        //没课
//        return @"全天无课";
//    }
//    
//    
//    if (beginLesson<5) {
//        string = @"08:00";
//        
//    }else if(beginLesson <9){
//        string = @"14:00";
//        baseClassNum = 5;
//    }else{
//        string = @"19:00";
//        baseClassNum = 9;
//    }
//    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
//        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
//        [inputFormatter setDateFormat:@"HH:mm"];
//        NSDate *inputDate = [inputFormatter dateFromString:string];
//        NSInteger addMin = (beginLesson-baseClassNum)*55;
//        if (beginLesson-baseClassNum >=3) {
//            addMin += 10;
//        }
//        NSDate *classDate = [NSDate dateWithTimeInterval:addMin*60
//                                               sinceDate:inputDate];
//        addMin = time*45 + (time-1)*10;
//        if (time >=3 ) {
//            addMin+=10;
//        }
//        NSDate *classEndDate = [NSDate dateWithTimeInterval:addMin*60
//                                                  sinceDate:classDate];
//        
//        startTimeString = [inputFormatter stringFromDate:classDate];
//        endTimeString = [inputFormatter stringFromDate:classEndDate];
//
//    return [NSString stringWithFormat:@"%@~%@",startTimeString,endTimeString];
//}

- (UITableView *)classTableView{
    if (!_classTableView) {
        _classTableView = [[UITableView alloc]init];
        _classTableView.delegate = self;
        _classTableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44*self.todayClassArray.count);
        _classTableView.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"ClassTableViewCell" bundle:nil];
        [_classTableView registerNib:nib forCellReuseIdentifier:@"ClassCell"];
//        _classTableView.backgroundColor = [UIColor whiteColor]
    }
    return _classTableView;
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsMake(0, 8, 10, 10);
}


#pragma mark 当前周
- (NSInteger)getThisWeek{
    NSInteger time = [[self convertDateFromString:@"2016-02-09"] timeIntervalSinceNow];
    int week = ceil(labs(time/(3600*24*7)));
    NSLog(@"week:%d--",week);
   return  week;
}

- (NSDate*) convertDateFromString:(NSString*)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

#pragma mark 获取周课表
- (NSMutableArray *)getWeek:(NSInteger)week fromTermArray:(NSArray *)dataArray{
    
    NSMutableArray *weekCourseArray = [NSMutableArray array];
    if (week == 0) {
        weekCourseArray = [NSMutableArray arrayWithArray:dataArray];
    }else {
        for (int i = 0; i < dataArray.count; i ++) {
            if ([dataArray[i][@"week"] containsObject:[NSNumber numberWithInteger:week]]) {
                NSMutableDictionary *weekDataDic = [[NSMutableDictionary alloc]initWithDictionary:dataArray[i]];
                [weekCourseArray addObject:weekDataDic];
            }
        }
        //[self handleColor:weekCourseArray];
    }
    
    NSLog(@"weekCourse:%@",weekCourseArray);
    return weekCourseArray;
}
@end
