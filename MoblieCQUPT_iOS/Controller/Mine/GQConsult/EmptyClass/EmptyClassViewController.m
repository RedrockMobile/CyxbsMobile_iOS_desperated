//
//  EmptyClassViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/3/4.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "EmptyClassViewController.h"
#import "ShopTableViewCell.h"
#import "PickView.h"
#import "MBProgressHUD.h"

#define EmptyClassApi @"http://hongyan.cqupt.edu.cn/api/roomEmpty"

@interface EmptyClassViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat kCellHeight;
@property (strong, nonatomic) NSDictionary *classDic;
@property (strong, nonatomic) NSArray *foolArray;

@property (strong, nonatomic) UIBarButtonItem *edit;
@property (strong, nonatomic) PickView *pickView;

@property (assign, nonatomic) BOOL isOpenEidt;
@property (assign, nonatomic) BOOL isDone;
@property (strong, nonatomic) MBProgressHUD *HUD;

@property (strong, nonatomic) UIPickerView *timePickView;
@property (strong, nonatomic) UIPickerView *classPickView;
@property (strong, nonatomic) UIPickerView *sectionPickView;
@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) NSArray *timePickArray;
@property (strong, nonatomic) NSArray *timePickArray1;

@property (strong, nonatomic) NSArray *classPickArray;
@property (strong, nonatomic) NSArray *sectionPickArray;

@property (strong, nonatomic) UIToolbar *pickViewToolBar;

@property (strong, nonatomic) NSMutableDictionary *loadDic;

@property (assign, nonatomic) NSInteger buildRow;

@property (strong, nonatomic) NSMutableArray *cellViewArray;


@end

@implementation EmptyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *fontFamilies = [UIFont familyNames];
    for (int i = 0; i < [fontFamilies count]; i++)
    {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
    NSDictionary *dic = @{@"buildNum":@"",
                          @"week":@"",
                          @"sectionNum":@"",
                          @"weekdayNum":@""};
    _loadDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
    
    _cellViewArray = [NSMutableArray array];
    
    _foolArray = @[@"",@"一楼",@"二楼",@"三楼",@"四楼",@"五楼"];
    
    _timePickArray = @[@"请选择周",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周",@"第十九周",@"第二十周"];
    _timePickArray1 = @[@"请选择日期",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    _classPickArray = @[@"请选择教学楼",@"2教",@"3教",@"4教",@"5教",@"8教"];
    _sectionPickArray = @[@"请选择时间",@"1~2节",@"3~4节",@"5~6节",@"7~8节",@"9~10节",@"11~12节"];
    
    

    
    _isDone = NO;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 84, 17, 20)];
    imageView.image = [UIImage imageNamed:@"emptyClass.png"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, imageView.frame.origin.y, 200, 20)];
    label.text = @"查询结果";
    label.font = [UIFont systemFontOfSize:19];
    label.textColor = MAIN_COLOR;
    [label sizeToFit];
    [self.view addSubview:label];
    
    [self.view addSubview:self.tableView];
    _pickView = [[PickView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [_pickView.searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pickView];
    
    [_pickView.timeBtn addTarget:self action:@selector(timeBtnPick:) forControlEvents:UIControlEventTouchUpInside];
    [_pickView.classBtn addTarget:self action:@selector(classBtnPick:) forControlEvents:UIControlEventTouchUpInside];
    [_pickView.sectionBtn addTarget:self action:@selector(sectionBtnPick:) forControlEvents:UIControlEventTouchUpInside];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0;
    UIButton *backgroundViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backgroundViewBtn.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [backgroundViewBtn addTarget:self action:@selector(clickToolBarCancel) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:backgroundViewBtn];
    _backView.hidden = YES;
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:_backView];
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.timePickView];
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.classPickView];
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.sectionPickView];
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.pickViewToolBar];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (UIBarButtonItem *)edit {
    if (!_edit) {
//        _edit = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"edit2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(editEmptyClass)];
        _edit.tintColor = [UIColor whiteColor];
        
        UIButton *barBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [barBtn setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
        [barBtn addTarget:self  action:@selector(editEmptyClass) forControlEvents:UIControlEventTouchUpInside];
        barBtn.frame = CGRectMake(0, 0, 22, 22);
        _edit = [[UIBarButtonItem alloc]initWithCustomView:barBtn];

    }
    return _edit;
}

- (UIToolbar *)pickViewToolBar {
    if(!_pickViewToolBar) {
        _pickViewToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, _timePickView.frame.origin.y, ScreenWidth, 45)];
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickToolBarCancel)];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        flexSpace.width = ScreenWidth-100;
        UIBarButtonItem *flexSpace1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        flexSpace1.width = 10;
        UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickToolBarDone)];
        
        _pickViewToolBar.barTintColor = [UIColor whiteColor];
        _pickViewToolBar.items = @[flexSpace1,cancel,flexSpace,done,flexSpace1];
        _pickViewToolBar.hidden = YES;
    }
    return _pickViewToolBar;
}

- (void)clickToolBarCancel {
    NSLog(@"cancel");
    if (!_timePickView.hidden) {
        [self animationWithPickView:_timePickView withMode:1];
    }else if (!_classPickView.hidden) {
        [self animationWithPickView:_classPickView withMode:1];
    }else if (!_sectionPickView.hidden) {
        [self animationWithPickView:_sectionPickView withMode:1];
    }
}
- (void)clickToolBarDone {
    NSLog(@"done");
    if (!_timePickView.hidden) {
        [self animationWithPickView:_timePickView withMode:1];
    }else if (!_classPickView.hidden) {
        [self animationWithPickView:_classPickView withMode:1];
    }else if (!_sectionPickView.hidden) {
        [self animationWithPickView:_sectionPickView withMode:1];
    }
    if ([_loadDic[@"week"] isEqualToString:@"0"] || [_loadDic[@"weekdayNum"] isEqualToString:@"0"]) {
        [_pickView.timeBtn setTitle:_timePickArray1[0] forState:UIControlStateNormal];
        [_pickView updateBtnFrame];
    }else if ([_loadDic[@"buildNum"] isEqualToString:@"0"]) {
        [_pickView.classBtn setTitle:_classPickArray[0] forState:UIControlStateNormal];
        [_pickView updateBtnFrame];
    }else if ([_loadDic[@"sectionNum"] isEqualToString:@"0"]) {
        [_pickView.sectionBtn setTitle:_sectionPickArray[0] forState:UIControlStateNormal];
        [_pickView updateBtnFrame];
    }
    if (![_loadDic[@"week"] isEqualToString:@""] || ![_loadDic[@"weekdayNum"] isEqualToString:@""]) {
        NSInteger week = [_loadDic[@"week"] integerValue];
        NSInteger weekDay = [_loadDic[@"weekdayNum"] integerValue];
        NSString *date = [NSString stringWithFormat:@"%@~%@",_timePickArray[week],_timePickArray1[weekDay]];
        [_pickView.timeBtn setTitle:date forState:UIControlStateNormal];
        [_pickView updateBtnFrame];
    }
    if (![_loadDic[@"buildNum"] isEqualToString:@""]) {
        [_pickView.classBtn setTitle:_classPickArray[_buildRow] forState:UIControlStateNormal];
        [_pickView updateBtnFrame];
    }
    if (![_loadDic[@"sectionNum"] isEqualToString:@""]) {
        NSInteger sectionNum = [_loadDic[@"sectionNum"] integerValue];
        [_pickView.sectionBtn setTitle:_sectionPickArray[sectionNum] forState:UIControlStateNormal];
        [_pickView updateBtnFrame];
    }
    
    
    NSLog(@"%@",_loadDic);
}

- (UIPickerView *)timePickView {
    if (!_timePickView) {
        _timePickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight/10*4)];
        _timePickView.backgroundColor = [UIColor whiteColor];
        _timePickView.delegate = self;
        _timePickView.dataSource = self;
        _timePickView.hidden = YES;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth, 1)];
        line.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:0.5];
        [_timePickView addSubview:line];
    }
    return _timePickView;
}
- (UIPickerView *)classPickView {
    if (!_classPickView) {
        _classPickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight/10*4)];
        _classPickView.backgroundColor = [UIColor whiteColor];
        _classPickView.delegate = self;
        _classPickView.dataSource = self;
        _classPickView.hidden = YES;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth, 1)];
        line.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:0.5];
        [_classPickView addSubview:line];
    }
    return _classPickView;
}
- (UIPickerView *)sectionPickView {
    if (!_sectionPickView) {
        _sectionPickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight/10*4)];
        _sectionPickView.backgroundColor = [UIColor whiteColor];
        _sectionPickView.delegate = self;
        _sectionPickView.dataSource = self;
        _sectionPickView.hidden = YES;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth, 1)];
        line.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:0.5];
        [_sectionPickView addSubview:line];
    }
    return _sectionPickView;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == _timePickView) {
        return 2;
    }else if (pickerView == _classPickView) {
        return 1;
    }else if (pickerView == _sectionPickView) {
        return 1;
    }else {
        return 0;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == _timePickView) {
        if (component == 0) {
            return _timePickArray.count;
        }else if (component == 1) {
            return _timePickArray1.count;
        }else {
            return 0;
        }
    }else if (pickerView == _classPickView) {
        return _classPickArray.count;
    }else if (pickerView == _sectionPickView) {
        return _sectionPickArray.count;
    }else {
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == _timePickView) {
        if (component == 0) {
            return _timePickArray[row];
        }else if (component == 1) {
            return _timePickArray1[row];
        }else {
            return @"";
        }
    }else if (pickerView == _classPickView) {
        return _classPickArray[row];
    }else if (pickerView == _sectionPickView) {
        return _sectionPickArray[row];
    }else {
        return @"";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == _timePickView) {
        if (component == 0) {
            NSString *week = [NSString stringWithFormat:@"%ld",row];
            [_loadDic setObject:week forKey:@"week"];
        }else if (component == 1) {
            NSString *weekDayNum = [NSString stringWithFormat:@"%ld",row];
            [_loadDic setObject:weekDayNum forKey:@"weekdayNum"];
        }
    }else if (pickerView == _classPickView) {
        _buildRow = row;
        NSString *buildNum = [_classPickArray[row] substringWithRange:NSMakeRange(0, 1)];
        [_loadDic setObject:buildNum forKey:@"buildNum"];
    }else if (pickerView == _sectionPickView) {
        NSString *sectionNum = [NSString stringWithFormat:@"%ld",row];
        [_loadDic setObject:sectionNum forKey:@"sectionNum"];
    }
}

- (void)editEmptyClass {
    self.navigationItem.rightBarButtonItem = nil;
    [self.view addSubview:_pickView];
}


- (void)loadNetData {
    [NetWork NetRequestPOSTWithRequestURL:EmptyClassApi WithParameter:_loadDic WithReturnValeuBlock:^(id returnValue) {
        self.navigationItem.rightBarButtonItem = self.edit;
        [_pickView removeFromSuperview];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _classDic = [self handleData:returnValue[@"data"]];
        NSLog(@"%@",_classDic);
        
        for (int i = 0; i < _cellViewArray.count; i ++) {
            [_cellViewArray[i] removeFromSuperview];
        }
        [_tableView reloadData];
        _tableView.contentSize = CGSizeMake(ScreenWidth, _tableView.frame.size.height);
        _tableView.frame = CGRectMake(0, 120, ScreenWidth, ScreenHeight-_tableView.frame.origin.y);
    } WithFailureBlock:^{
        NSLog(@"boom shakaleka");
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络不好，请重试！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}

- (NSMutableDictionary *)handleData:(NSArray *)array {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *array1 = @[@"1",@"2",@"3",@"4",@"5"];
    for (int i = 0; i < array1.count; i ++) {
        NSMutableArray *newArray = [NSMutableArray array];
        for (int j = 0; j < array.count; j++) {
            NSString *string = [array[j] substringWithRange:NSMakeRange(1, 1)];
            if ([string isEqualToString:array1[i]]) {
                [newArray addObject:array[j]];
            }
        }
        [dic setObject:newArray forKey:array1[i]];
    }
    return dic;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, ScreenWidth, ScreenHeight-_tableView.frame.origin.y) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        [_tableView setAutoresizesSubviews:NO];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    NSInteger classCount = ((NSArray *)_classDic[row]).count;
    if (classCount >= 0 && classCount <= 5) {
        return 55;
    }else if (classCount > 5 && classCount <= 10) {
        return 80;
    }else if (classCount > 10 && classCount <= 15) {
        return 105;
    }else {
        return 135;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    NSInteger classCount = ((NSArray *)_classDic[row]).count;
    if (classCount >= 0 && classCount <= 5) {
        _kCellHeight = 55;
    }else if (classCount > 5 && classCount <= 10) {
        _kCellHeight = 80;
    }else if (classCount > 10 && classCount <= 15) {
        _kCellHeight = 105;
    }else {
        _kCellHeight = 135;
    }
    
    static NSString *identifler = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifler];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifler];
    }
    
    UIView *ball = [[UIView alloc]initWithFrame:CGRectMake(20, 2, 10, 10)];
    ball.layer.cornerRadius = ball.frame.size.width/2;
    ball.backgroundColor = MAIN_COLOR;
    
    UIView *line = [[UIView alloc]init];
    
    if (indexPath.row == 0) {
        line.frame = CGRectMake(24, 2, 2, _kCellHeight-2);
        line.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        [_cellViewArray addObject:line];
        [cell addSubview:line];
    }else if (indexPath.row > 0 && indexPath.row < 4) {
        line.frame = CGRectMake(24, 0, 2, _kCellHeight+2);
        line.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        [_cellViewArray addObject:line];
        [cell addSubview:line];
    }
    
    UILabel *foolLabel = [[UILabel alloc]init];
    foolLabel.text = _foolArray[indexPath.row+1];
    foolLabel.font = [UIFont systemFontOfSize:14];
    [foolLabel sizeToFit];
    foolLabel.frame = CGRectMake(38, 0, foolLabel.frame.size.width, 20);
    foolLabel.center = CGPointMake(foolLabel.frame.origin.x+foolLabel.frame.size.width/2, ball.frame.origin.y+ball.frame.size.height/2);
    foolLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    
    
    UILabel *lastLabel = [[UILabel alloc]init];
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel = foolLabel;
    NSString *count = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    CGFloat margin;
    CGFloat fontSize;
    
    CGFloat labelWidth;
    CGFloat labelHeight;
    if (ScreenWidth == 375) {
        margin = 20;
        fontSize = 17;
        labelWidth = 49;
        labelHeight = 20;
    }else if (ScreenWidth == 320) {
        margin = 18;
        fontSize = 15;
        labelWidth = 38;
        labelHeight = 18;
    }else {
        margin = 28;
        fontSize = 19;
        labelWidth = 46;
        labelHeight = 23;
    }
    if (((NSArray *)_classDic[count]).count == 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(topLabel.frame.origin.x, topLabel.frame.origin.y+topLabel.frame.size.height+7, labelWidth, labelHeight)];
        label.text = @"此楼爆满，学霸请到别处练功";
        label.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:0.8];
        label.font = [UIFont systemFontOfSize:fontSize];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
        [label sizeToFit];
        label.frame = CGRectMake(topLabel.frame.origin.x, topLabel.frame.origin.y+topLabel.frame.size.height+7, label.frame.size.width, label.frame.size.height);
        [cell addSubview:label];
        [_cellViewArray addObject:label];
    }else {
        for (int i = 0; i < ((NSArray *)_classDic[count]).count; i ++) {
            if (i == 0 || i == 5 || i == 10 || i == 15) {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(topLabel.frame.origin.x, topLabel.frame.origin.y+topLabel.frame.size.height+7, labelWidth, labelHeight)];
                label.text = _classDic[count][i];
                label.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
                label.font = [UIFont systemFontOfSize:fontSize];
//                label.font = [UIFont fontWithName:@"PingFang Light" size:fontSize];
                [cell addSubview:label];
                [_cellViewArray addObject:label];
                lastLabel = label;
                topLabel = label;
            }else {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(lastLabel.frame.origin.x+lastLabel.frame.size.width+margin, lastLabel.frame.origin.y, labelWidth, labelHeight)];
                label.text = _classDic[count][i];
                label.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
                label.font = [UIFont systemFontOfSize:fontSize];
//                label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
                //字间距
//                NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:label.text attributes:@{NSKernAttributeName : @(2.0f)}];
//                [label setAttributedText:attributedString];
                
                [cell addSubview:label];
                [_cellViewArray addObject:label];
                lastLabel = label;
            }
        }
    }
    
    
    [cell addSubview:foolLabel];
    [cell addSubview:ball];
    [_cellViewArray addObject:foolLabel];
    [_cellViewArray addObject:ball];
    [cell setUserInteractionEnabled:NO];
    
    
    
    return cell;
    
}



- (void)searchBtn:(UIButton *)sender {
    NSLog(@"查找、、、、、、");
    BOOL isOk = false;
    for (NSString *key in _loadDic) {
        if ([_loadDic[key] isEqualToString:@""] || [_loadDic[key] isEqualToString:@"0"]) {
            isOk = NO;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"信息未选择完全" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            break;
        }else {
            isOk = YES;
        }
    }
    if (isOk) {
        _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _HUD.labelText = @"正在查询...";
        [self loadNetData];
    }
    
}

- (void)timeBtnPick:(UIButton *)sender {
    NSLog(@"timePick");
    [self animationWithPickView:_timePickView withMode:0];
    
}
- (void)classBtnPick:(UIButton *)sender {
    NSLog(@"classPick");
    [self animationWithPickView:_classPickView withMode:0];
}
- (void)sectionBtnPick:(UIButton *)sender {
    NSLog(@"sectionPick");
    [self animationWithPickView:_sectionPickView withMode:0];
}

//动画方法
- (void)animationWithPickView:(UIPickerView *)pickView withMode:(NSInteger)mode {
    if (mode == 0) {
        pickView.hidden = NO;
        _pickViewToolBar.hidden = NO;
        _backView.hidden = NO;
        [UIView animateWithDuration:0.15 animations:^{
            pickView.frame = CGRectMake(0, ScreenHeight-ScreenHeight/10*4, ScreenWidth, ScreenHeight/10*4);
            _pickViewToolBar.frame = CGRectMake(0, pickView.frame.origin.y, ScreenWidth, 45);
            _backView.alpha = 0.7;
        } completion:^(BOOL finished) {
            
        }];
    }else if (mode == 1) {
        [UIView animateWithDuration:0.15 animations:^{
            pickView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight/10*4);
            _pickViewToolBar.frame = CGRectMake(0, pickView.frame.origin.y, ScreenWidth, 45);
            _backView.alpha = 0;
        } completion:^(BOOL finished) {
            pickView.hidden = YES;
            _pickViewToolBar.hidden = YES;
            _backView.hidden = YES;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
