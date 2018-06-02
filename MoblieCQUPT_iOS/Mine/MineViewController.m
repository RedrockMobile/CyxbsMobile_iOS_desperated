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
#import "MyInfoViewController.h"
#import "AboutMeViewController.h"
#import "MyMessagesViewController.h"
#import "QueryViewController.h"
#import "QueryLoginViewController.h"
#import "MyInfoModel.h"
#import "draftsViewController.h"
#import "SettingViewController.h"
#import "LXAskViewController.h"
#import <sys/utsname.h>

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray <NSArray *> *cellDicArray;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    MyInfoModel *model = [MyInfoModel getMyInfo];
    if (model.photo_thumbnail_src == nil){
        self.headImageView.image = [UIImage imageNamed:@"headImage"];
    }
    else {
        self.headImageView.image = model.photo_thumbnail_src;
    }
    if (model.nickname.length == 0) {
        self.nameLabel.text = @"请填写用户名";
    }
    else {
        self.nameLabel.text = model.nickname;
    }
    if (model.introduction.length == 0) {
        self.introductionLabel.text = @"写下你想对世界说的话，就现在";
    }
    else {
        self.introductionLabel.text = model.introduction;
    }
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    NSArray *array1 =   @[
                @{@"title":@"每日签到",@"img":@"mine_sign_in",@"controller":@"dailyAttendanceViewController"}];
    NSArray *array2 = @[
                @{@"title":@"积分商城",@"img":@"mine_score_shop",@"controller":@"shopViewController"},
                @{@"title":@"问一问",@"img":@"mine_ask",@"controller":@"LXAskViewController"},
                @{@"title":@"帮一帮",@"img":@"mine_help",@"controller":@"LXHelpViewController"},
                @{@"title":@"草稿箱",@"img":@"mine_draft",@"controller":@"draftsViewController"}];
    NSArray *array3 = @[
                @{@"title":@"与我相关",@"img":@"mine_aboutMe",@"controller":@"AboutMeViewController"}];
    NSArray *array4 = @[
                @{@"title":@"设置",@"img":@"mine_setting",@"controller":@"SettingController"}];
    self.cellDicArray = @[array1, array2, array3, array4];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.top - 20, SCREENWIDTH, SCREENHEIGHT - self.tableView.top - 20)];
    whiteView.backgroundColor = RGBColor(246, 246, 246, 1);;
    [self.view addSubview:whiteView];
    [self.view sendSubviewToBack:whiteView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImage)];
    [self.headImageView addGestureRecognizer:gesture];
    self.headImageView.userInteractionEnabled = YES;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.headImageView.layer.cornerRadius = self.headImageView.width/2;
    self.headImageView.layer.borderWidth = 1;
    self.headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImageView.layer.masksToBounds = YES;
}

#pragma mark - TableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellDicArray[section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellDicArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MineTableViewCell" owner:nil options:nil] lastObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    cell.cellImageView.image = [UIImage imageNamed:self.cellDicArray[indexPath.section][indexPath.row][@"img"]];
    cell.cellLabel.text = self.cellDicArray[indexPath.section][indexPath.row][@"title"];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.backgroudImage.image = [UIImage imageNamed:@"middle_t"];
        }
        else if (indexPath.row == 1 || indexPath.row == 2) {
            cell.backgroudImage.image = [UIImage imageNamed:@"middle_m"];
        }
        else {
            cell.backgroudImage.image = [UIImage imageNamed:@"middle_b"];
        }
    }
    else {
        cell.backgroudImage.image = [UIImage imageNamed:@"topBotton"];
    }
    return cell;
}

#pragma mark 分割tableview设置
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.tableView.size.height - 23)/7;
    
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = RGBColor(246, 246, 246, 1);;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = self.cellDicArray[indexPath.section][indexPath.row][@"controller"];
    
    UIViewController *vc;
    vc = (UIViewController *)[[NSClassFromString(className) alloc] init];

    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        if (indexPath.row == 1 || indexPath.row == 2 ||indexPath.row==5) {
            if (![UserDefaultTool getStuNum]) {
                [self tint:vc];
                return;
            }
        }
        if(indexPath.row == 3){
            if (![[NSUserDefaults standardUserDefaults] valueForKey:@"uid"]) {
                vc = [[QueryLoginViewController alloc]init];
            }else{
                vc = [[QueryViewController alloc]init];
            }
        }
    }
    if ([className isEqualToString:@"LXAskViewController"]) {
        LXAskViewController *vc = [[LXAskViewController alloc] init];
        vc.isAsk = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        vc.navigationItem.title = self.cellDicArray[indexPath.section][indexPath.row][@"title"];
        return;
        } else if ([className isEqualToString:@"LXHelpViewController"]) {
            LXAskViewController *vc = (LXAskViewController *)[[LXAskViewController alloc] init];
            vc.isAsk = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            vc.navigationItem.title = self.cellDicArray[indexPath.section][indexPath.row][@"title"];
            return;
        }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.navigationItem.title = self.cellDicArray[indexPath.section][indexPath.row][@"title"];
}

- (void)touchImage{
    MyInfoViewController *vc = [[MyInfoViewController alloc]init];
    vc.navigationItem.title = @"修改信息";
    vc.hidesBottomBarWhenPushed = YES;
    if (![UserDefaultTool getStuNum]) {
        [self tint:vc];
        return;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tint:(UIViewController *)controller{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否登录？" message:@"登录后才能查看更多信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *LVC = [[LoginViewController alloc] init];
        LVC.loginSuccessHandler = ^(BOOL success) {
            if (success) {
//                [self.navigationController pushViewController:controller animated:YES];
            }
        };
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
            vc = [[MyMessagesViewController alloc]init];
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

