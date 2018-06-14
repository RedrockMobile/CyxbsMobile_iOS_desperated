//
//  YouWenTimeView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenTimeView.h"


@interface YouWenTimeView ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (copy, nonatomic) NSString *day;
@property (copy, nonatomic) NSString *hour;
@property (copy, nonatomic) NSString *minite;
@property (copy, nonatomic) NSString *nowday;
@property (strong, nonatomic) NSArray *nowtimeData;
@end
@implementation YouWenTimeView
-(NSArray *)timeData
{
    if (!_timeData) {
        NSMutableArray *minute = [NSMutableArray array];
        NSMutableArray *hour = [NSMutableArray array];
        for (int i = 21; i <= 23; i ++) {
            [hour appendObject:[NSString stringWithFormat:@"%d时", i]];
        }
        for (int i = 0; i <= 60; i ++) {
            [minute appendObject:[NSString stringWithFormat:@"%d分", i]];
        }
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy年MM月dd日";
        _nowday = [formatter stringFromDate:now].copy;
        NSTimeInterval interval = 60 * 60 * 24;
        NSMutableArray *day = [NSMutableArray array];
        [day appendObject:@"今天"];
        for (int i = 1; i <= 2; i ++){
            NSString *nextDay = [formatter stringFromDate:[now initWithTimeInterval:interval * i sinceDate:now]];
            [day appendObject:nextDay];
        }
        
        NSMutableArray *nowHour = [NSMutableArray array];
        formatter.dateFormat = @"HH时";
        _nowday = [formatter stringFromDate:now].copy;
        for (int i = 1; ; i ++){
            NSString *nextHour = [formatter stringFromDate:[now initWithTimeInterval:60 * 60 * i sinceDate:now]];
            if ([nextHour isEqualToString:@"00时"]) {
                break;
            }
            [nowHour appendObject:nextHour];
        }
        if (!nowHour.count) {
            nowHour = @[@"01时", @"02时", @"03时", @"04时", @"05时", @"06时", @"07时", @"08时", @"09时", @"10时", @"11时", @"12时", @"13时", @"14时", @"15时", @"16时", @"17时", @"18时", @"19时", @"20时", @"21时", @"22时", @"23时"].mutableCopy;
        }
        _timeData = @[day, nowHour, minute];
        
    }
    return _timeData;
}

- (void)confirm{
    if (_day.length) {
        [self.inf appendString:_day];
    }
    if (_hour.length) {
        [self.inf appendString:_hour];
    }
    if (_minite.length) {
        [self.inf appendString:_minite];
    }
    NSNotification *notification = [[NSNotification alloc] initWithName:@"timeNotifi" object:@{@"time":self.inf} userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    [self removeFromSuperview];
}
- (void)addDetail{
    [super addDetail];
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.blackView.bottom, ScreenWidth, self.whiteView.height - self.blackView.bottom)];
    _pickView.delegate = self;
    _pickView.dataSource = self;
//    _day = @"今日";
//    _hour = @"21时";
//    _minite = @"0分";
//    self.inf = [NSString stringWithFormat:@"%@ %@ %@", _day, _hour, _minite].mutableCopy;
    [self.whiteView addSubview:_pickView];
    self.pickViewArray = self.timeData.mutableCopy;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [UIFont boldSystemFontOfSize:ZOOM(15)];
        pickerLabel.textColor =  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.pickViewArray.count;
    
}

- (NSMutableArray *)pickViewArray{
    if (!_pickViewArray) {
        _pickViewArray = [NSMutableArray array];
    }
    return _pickViewArray;
}
// 返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *items = self.pickViewArray[component];
    return items.count;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickViewArray[component][row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UILabel *piketLabel =  (UILabel *)[pickerView viewForRow:row forComponent:component];
    piketLabel.textColor = [UIColor colorWithHexString:@"7195FA"];
    NSMutableArray *items = self.pickViewArray[component];
    if (component == 0) {
        if (row == 0) {
            _day = _nowday;
            
        }
        else{
            _day = items[row];
        }
    }
    else if (component == 1){
        _hour = items[row];
    }
    else{
        _minite = items[row];
    }
    
}

@end
