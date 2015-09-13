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

@interface XBSFindClassroomViewController ()

@end

@implementation XBSFindClassroomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.titleLabel.text = @"找空教室";
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initViews {
    //一组图标
    self.periodViewArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 6; i++) {
        XBSFindClassroomPeriodView *view = [[XBSFindClassroomPeriodView alloc]initWithIndex:i];
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
    UITableView *table                = [[UITableView alloc]init];
    table.frame                       = CGRectMake(0, 240, ScreenWidth, ScreenHeight - 240);
    table.dataSource                  = self;
    table.separatorStyle = NO;
    table.showsVerticalScrollIndicator = NO;
    //加入
    [self.view addSubview:self.buildingSelectorButton];
    [self.view addSubview:self.dateSelectorButton];
    [self.view addSubview:consultLabel];
    [self.view addSubview:consultIconImageView];
    [self.view addSubview:table];
}

#pragma mark - ButtonClicker
- (void)selectBuilding {
    NSLog(@"building");
}

- (void)selectDate {
    NSLog(@"date");
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    //do sth
}


@end
