//
//  XBSFindClassroomViewController.m
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/12/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "XBSFindClassroomViewController.h"
#import "XBSFindClassroomPeriodView.h"
#import "XBSFindClassroomTableViewCell.h"
#import "XBSConsultConfig.h"
@interface XBSFindClassroomViewController ()
@property (nonatomic, assign) NSInteger nowRow;
@end

@implementation XBSFindClassroomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.titleLabel.text = ConsultFuntionName[3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init {
    //一组图标
    self = [super init];
    //为啥self.navigationBar.titleLabel.text = ConsultFuntionName[3];
    self.periodViewArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 6; i++) {
        XBSFindClassroomPeriodView *view = [[XBSFindClassroomPeriodView alloc]initWithIndex:i Delegate:self];
        [self.periodViewArray addObject:view];
        [self.view addSubview:view];
    }
    //两个按钮
    self.buildingSelectorButton                      = [[UIButton alloc]init];
    self.buildingSelectorButton.frame                = CGRectMake(0, 64, ScreenWidth / 2 + 1, 44);
    self.buildingSelectorButton.backgroundColor      = MAIN_COLOR;
    self.buildingSelectorButton.titleLabel.textColor = [UIColor whiteColor];
    self.dateSelectorButton                          = [[UIButton alloc]init];
    self.dateSelectorButton.frame                    = CGRectMake(ScreenWidth / 2, 64, ScreenWidth / 2 + 1, 44);
    self.dateSelectorButton.backgroundColor          = MAIN_COLOR;
    self.dateSelectorButton.titleLabel.textColor     = [UIColor whiteColor];
    [self.buildingSelectorButton setTitle:@"二教" forState:UIControlStateNormal];
    [self.buildingSelectorButton addTarget:self action:@selector(selectBuilding) forControlEvents:UIControlEventTouchUpInside];
    [self.dateSelectorButton setTitle:@"当天" forState:UIControlStateNormal];
    [self.dateSelectorButton addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
    
    //小图片+"查询结果"
    UIImage *aImage                   = [[UIImage imageNamed:@"consult_result"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *consultIconImageView = [[UIImageView alloc]init];
    consultIconImageView.image        = aImage;
    consultIconImageView.frame        = CGRectMake(10, 205, 30, 30);
    consultIconImageView.tintColor    = MAIN_COLOR;
    UILabel *consultLabel             = [[UILabel alloc]init];
    consultLabel.frame                = CGRectMake(45, 210, 80, 20);
    consultLabel.text                 = @"查询结果";
    consultLabel.textColor            = MAIN_COLOR;
    consultLabel.font                 = [UIFont boldSystemFontOfSize:20];
    //表格
    self.table                              = [[UITableView alloc]init];
    self.table.hidden                       = YES;
    self.table.frame                        = CGRectMake(0, 240, ScreenWidth, ScreenHeight - 240);
    self.table.dataSource                   = self;
    self.table.separatorStyle               = NO;
    self.table.showsVerticalScrollIndicator = NO;
    self.table.allowsSelection              = NO;
    //选取器
    self.buildingPickerView.delegate        = self;
    self.buildingPickerView.dataSource      = self;
    self.buildingPickerView.hidden          = YES;
    self.buildingPickerView.backgroundColor = [UIColor whiteColor];
    //toolBar
    self.doneToolBar.hidden          = YES;
    self.doneToolBar.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *item1           = self.doneToolBar.items.lastObject;
    UIBarButtonItem *item2           = self.doneToolBar.items[0];
    item1.target                     = self;
    item1.action                     = @selector(selectDone);
    item2.target                     = self;
    item2.action                     = @selector(selectCancelled);
    //加入
    [self.view addSubview:self.table];
    [self.view addSubview:self.buildingSelectorButton];
    [self.view addSubview:self.dateSelectorButton];
    [self.view addSubview:self.buildingPickerView];
    [self.view addSubview:self.doneToolBar];
    [self.view addSubview:consultLabel];
    [self.view addSubview:consultIconImageView];
    return self;
}

#pragma mark - ButtonClicker
- (void)selectBuilding {
    self.doneToolBar.hidden = NO;
    self.buildingPickerView.hidden = NO;
}

- (void)selectDate {
    
}

- (void)selectCancelled {
    self.doneToolBar.hidden = YES;
    self.buildingPickerView.hidden = YES;
}

- (void)selectDone {
    self.doneToolBar.hidden = YES;
    self.buildingPickerView.hidden = YES;
    self.buildingSelectorButton.tag = self.nowRow;
    [self.buildingSelectorButton setTitle:BuildList[self.nowRow] forState:UIControlStateNormal];
    [self.model refreshEmptyClassroomTableData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger returnNum;
    NSInteger n = self.model.resultClassroomArray.count;
    if (n % 4 == 0) {
        returnNum =  n / 4;
    }else{
        returnNum = n / 4 + 1;
    }
    NSLog(@"count = %ld",self.model.resultClassroomArray.count);
    NSLog(@"rowNum = %ld",returnNum);
    return returnNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBSFindClassroomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"XBSFindClassroomTableViewCell" owner:self options:nil]lastObject];
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(XBSFindClassroomTableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 13) {
        //do sth
    }
    NSLog(@"——————————第%ld行",indexPath.row);
    if (indexPath.row * 4 + 1 <= self.model.resultClassroomArray.count) {
        NSLog(@"%ld",indexPath.row * 4 + 0);
        cell.cellLabel1.text = self.model.resultClassroomArray[indexPath.row * 4 + 0];
    }else{
        cell.cellLabel1.text = @"";
    }
    if (indexPath.row * 4 + 2 <= self.model.resultClassroomArray.count) {
        NSLog(@"%ld",indexPath.row * 4 + 1);
        cell.cellLabel2.text = self.model.resultClassroomArray[indexPath.row * 4 + 1];
    }else{
        cell.cellLabel2.text = @"";
    }
    if (indexPath.row * 4 + 3 <= self.model.resultClassroomArray.count) {
        NSLog(@"%ld",indexPath.row * 4 + 2);
        cell.cellLabel3.text = self.model.resultClassroomArray[indexPath.row * 4 + 2];
    }else{
        cell.cellLabel3.text = @"";
    }
    if (indexPath.row * 4 + 4 <= self.model.resultClassroomArray.count) {
        NSLog(@"%ld",indexPath.row * 4 + 3);
        cell.cellLabel4.text = self.model.resultClassroomArray[indexPath.row * 4 + 3];
    }else{
        cell.cellLabel4.text = @"";
    }
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return BuildList[row];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    self.nowRow = row;
}

#pragma mark - UIPickerDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return BuildList.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


//#pragma mark - UITextFieldDelegate
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    NSInteger row = [selectPicker selectedRowInComponent:0];
//    self.textField.text = [ objectAtIndex:row];
//}






@end
