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
        if (_timeData == nil) {
            _timeData = @[day, hour, minute];
        }
    }
    return _timeData;
}
- (void)confirm{
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
    self.inf = [NSString stringWithFormat:@"%@ %@ %@", _day, _hour, _minite].mutableCopy;
}

@end
