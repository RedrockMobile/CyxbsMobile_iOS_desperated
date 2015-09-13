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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    self.buildingSelectorButton.frame                = CGRectMake(0, 64, 188, 44);
    self.buildingSelectorButton.backgroundColor      = MAIN_COLOR;
    self.buildingSelectorButton.titleLabel.textColor = [UIColor whiteColor];
    self.dateSelectorButton                          = [[UIButton alloc]init];
    self.dateSelectorButton.frame                    = CGRectMake(188, 64, 187, 44);
    self.dateSelectorButton.backgroundColor          = MAIN_COLOR;
    self.dateSelectorButton.titleLabel.textColor     = [UIColor whiteColor];
    [self.buildingSelectorButton setTitle:@"二教" forState:UIControlStateNormal];
    [self.dateSelectorButton setTitle:@"9月13日" forState:UIControlStateNormal];
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
    
    //UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 240, ScreenWidth, ScreenHeight - 240) style:UITableViewStylePlain];
    //table.dataSource = self;
    //加入
    [self.view addSubview:self.buildingSelectorButton];
    [self.view addSubview:self.dateSelectorButton];
    [self.view addSubview:consultLabel];
    [self.view addSubview:consultIconImageView];
    //[self.view addSubview:table];
}

#pragma mark - UITableViewDataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return <#number#>;
//}

//- (NSInteger)tableView:(UITableView *)tableView
// numberOfRowsInSection:(NSInteger)section
//{
//    return 10;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 80;
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    XBSFindClassroomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"XBSFindClassroomTableViewCell" owner:self options:nil]lastObject];
//    }
//    [self configureCell:cell forRowAtIndexPath:indexPath];
//    
//    return cell;
//}

- (void)configureCell:(XBSFindClassroomTableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell.cellLabel1.text = @"hhhh";
}


@end
