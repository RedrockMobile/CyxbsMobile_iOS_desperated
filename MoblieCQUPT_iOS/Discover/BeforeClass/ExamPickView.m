//
//  ExamPickView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/6.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "ExamPickView.h"
#define xgColor [UIColor colorWithRed:109/255.0 green:131/255.0 blue:238/255.0 alpha:1]
#define xgBuleColor [UIColor colorWithRed:237/255.0 green:246/255.0 blue:253/255.0 alpha:1]
@interface ExamPickView ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic)UIButton*quitBtn;
@property (strong, nonatomic)UIButton *confirmBtn;
@property (strong, nonatomic)UIPickerView *singlePicker;
@property (strong, nonatomic)NSString *result;
@property (strong, nonatomic)UIView *topView;
@end
@implementation ExamPickView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
    }
    return self;
}
#pragma mark 布局
- (void)layout{
    self.backgroundColor = [UIColor colorWithRed:189/255.0  green:189/255.0 blue:189/255.0 alpha:0.5];
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 250 + SCREEN_HEIGHT * 2/ 3 - 40, SCREEN_WIDTH, 40)];
    _topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topView];
    UIView *sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    sliderView.backgroundColor = [UIColor colorWithRed:189/255.0  green:189/255.0 blue:189/255.0 alpha:0.5];
    [_topView addSubview:sliderView];
    //退出
    _quitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
       _quitBtn.frame = CGRectMake(10, 10, 30, 30);
       [_quitBtn setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
       [_quitBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
       _quitBtn.userInteractionEnabled = YES;
       [_topView addSubview:_quitBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 5, 34, 19);
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:17];
    [_confirmBtn sizeToFit];
    [_confirmBtn setTitleColor:xgColor forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_confirmBtn];
    
    _singlePicker  = [[UIPickerView alloc]initWithFrame:CGRectMake(0,  250 + SCREEN_HEIGHT * 2/ 3, SCREEN_WIDTH, SCREEN_HEIGHT /3)];
    _singlePicker.delegate = self;
    _singlePicker.dataSource = self;
    _singlePicker.backgroundColor = [UIColor whiteColor];
    [self addSubview:_singlePicker];
}
//弹出
- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint point = self.center;
        point.y -= 250;
        self.center = point;
    }];
}
//退出
-(void)confirm{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        CGPoint point = self.center;
        point.y += 250;
        self.center = point;
    }completion:^(BOOL finished) {
        if (!_result) {
            _result = self.nameArray[0];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"value" object:self.result];
        [self removeFromSuperview];

    }];

}
-(void)quit{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        CGPoint point = self.center;
        point.y += 250;
        self.center = point;
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    }
#pragma mark 协议方法
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.nameArray.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
#pragma mark 代理方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.size = CGSizeMake(SCREEN_WIDTH, 2);
            singleLine.backgroundColor = xgBuleColor;
        }
    }
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setFont:[UIFont fontWithName:@"Arial" size:18]];
        pickerLabel.textColor = xgColor;
    }
    pickerLabel.text=self.nameArray[row];;
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    return pickerLabel;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.result = self.nameArray[row];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
