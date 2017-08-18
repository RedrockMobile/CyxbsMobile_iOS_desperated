//
//  MineViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/30.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//
#import "MineViewController.h"
#import "LoginViewController.h"
#import "MineTableViewCell.h"
#import "XBSAboutViewController.h"
#import "AboutMeViewController.h"
#import "MyInfoViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray *cellDicArray;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    NSURL *url = [NSURL URLWithString:[UserDefaultTool valueWithKey:@"photo_thumbnail_src"]];
    [self.headImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = [UserDefaultTool valueWithKey:@"nickname"];
    self.introductionLabel.text = [UserDefaultTool valueWithKey:@"introduction"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    NSArray *array1 =   @[@{@"title":@"没课约",@"img":@"mine_image_date",@"controller":@"QGERestTimeCourseViewController"},
                          @{@"title":@"空教室",@"img":@"mine_image_classroom",@"controller":@"EmptyClassViewController"},
                          @{@"title":@"考试成绩",@"img":@"mine_image_exam",@"controller":@"ExamGradeViewController"},
                          @{@"title":@"期末安排",@"img":@"mine_image_calendar",@"controller":@"ExamScheduleViewController"},
                          @{@"title":@"校历",@"img":@"mine_image_remind",@"controller":@"CalendarViewController"}];
    NSArray *array2 = @[@{@"title":@"设置",@"img":@"mine_image_setting",@"controller":@"SettingViewController"}];
    self.cellDicArray = @[array1,array2];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.headImageView.layer.cornerRadius = self.headImageView.width/2;
    self.headImageView.layer.borderWidth = 1;
    self.headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImageView.layer.masksToBounds = YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cellDicArray[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellDicArray.count;
}

#pragma mark - TableView 代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MineTableViewCell" owner:nil options:nil] lastObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.cellImageView.image = [UIImage imageNamed:self.cellDicArray[indexPath.section][indexPath.row][@"img"]];
        cell.cellLabel.text = self.cellDicArray[indexPath.section][indexPath.row][@"title"];
    
    return cell;
}

#pragma mark 分割tableview设置
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.tableView.size.height-20)/6;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = self.cellDicArray[indexPath.section][indexPath.row][@"controller"];
    UIViewController *vc = (UIViewController *)[[NSClassFromString(className) alloc] init];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        if (indexPath.row == 2 || indexPath.row == 3) {
            if (![UserDefaultTool getStuNum]) {
                [self tint:vc];
                return;
            }
        }
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.navigationItem.title = self.cellDicArray[indexPath.section][indexPath.row][@"title"];
}

- (void)tint:(UIViewController *)controller{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否登录？" message:@"登录后才能查看更多信息" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *LVC = [[LoginViewController alloc] init];
        [weakSelf presentViewController:LVC animated:YES completion:nil];
    }];
    [alertC addAction:cancel];
    [alertC addAction:confirm];
    [self presentViewController:alertC animated:YES completion:nil];
}


- (IBAction)clickBtn:(UIButton *)sender {
    UIViewController *vc;
    switch (sender.tag) {
        case 0:
            vc = [[MyInfoViewController alloc]init];
            vc.navigationItem.title = @"修改信息";
            break;
        case 1:
            vc = [[AboutMeViewController alloc]init];
            vc.navigationItem.title = @"与我相关";
            break;
        case 2:
            vc = [[XBSAboutViewController alloc]init];
            vc.navigationItem.title = @"我的动态";
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    if (![UserDefaultTool getStuNum]) {
        [self tint:vc];
        return;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end

