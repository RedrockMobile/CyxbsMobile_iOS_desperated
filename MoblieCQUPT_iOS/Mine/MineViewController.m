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
#import "AboutMeMainViewController.h"
#import "MyMessagesViewController.h"
#import "QueryViewController.h"
#import "QueryLoginViewController.h"
#import "MyInfoModel.h"
#import "draftsViewController.h"
#import "SettingViewController.h"
#import "LXAskViewController.h"
#import <sys/utsname.h>

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,LXAskViewControllerDelegate>

@property (copy, nonatomic) NSArray <NSArray *> *cellDicArray;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *introductionLabel;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    MyInfoModel *model = [MyInfoModel getMyInfo];
    if (model.photo_thumbnail_src == nil){
        self.headImageView.image = [UIImage imageNamed:@"headImage"];
    }else {
        self.headImageView.image = model.photo_thumbnail_src;
    }
    
    if (model.nickname.length == 0) {
        self.nameLabel.text = @"请填写用户名";
    }else {
        self.nameLabel.text = model.nickname;
    }
    
    if (model.introduction.length == 0) {
        self.introductionLabel.text = @"写下你想对世界说的话，就现在";
    }else {
        self.introductionLabel.text = model.introduction;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - LXAskDetailViewController delegate
- (void)enterYouWen {
    [self.tabBarController setSelectedIndex:1];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSArray *array1 =   @[
                @{@"title":@"每日签到",@"img":@"mine_sign_in",@"controller":@"dailyAttendanceViewController"}];
    NSArray *array2 = @[
                @{@"title":@"积分商城",@"img":@"mine_score_shop",@"controller":@"shopViewController"},
                @{@"title":@"问一问",@"img":@"mine_ask",@"controller":@"LXAskViewController"},
                @{@"title":@"帮一帮",@"img":@"mine_help",@"controller":@"LXHelpViewController"},
                @{@"title":@"草稿箱",@"img":@"mine_draft",@"controller":@"draftsViewController"}];
    NSArray *array3 = @[
                @{@"title":@"与我相关",@"img":@"mine_aboutMe",@"controller":@"AboutMeMainViewController"}];
    NSArray *array4 = @[
                @{@"title":@"设置",@"img":@"mine_setting",@"controller":@"SettingViewController"}];
    _cellDicArray = @[array1, array2, array3, array4];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, _tableView.top - 20, SCREEN_WIDTH, SCREEN_HEIGHT - _tableView.top - 20)];
    whiteView.backgroundColor = RGBColor(246, 246, 246, 1);;
    [self.view addSubview:whiteView];
    [self.view sendSubviewToBack:whiteView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineCell"];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImage)];
    [_headImageView addGestureRecognizer:gesture];
    _headImageView.userInteractionEnabled = YES;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _headImageView.layer.cornerRadius = self.headImageView.width/2;
    _headImageView.layer.borderWidth = 1;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImageView.layer.masksToBounds = YES;
}

#pragma mark - TableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellDicArray[section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _cellDicArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.type = MineCellTypeStart;
        }else if (indexPath.row == 3){
            cell.type = MineCellTypeEnd;
        }else{
            cell.type = MineCellTypeMiddle;
        }
    }else{
        cell.type = MineCellTypeNormal;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellImageView.image = [UIImage imageNamed:self.cellDicArray[indexPath.section][indexPath.row][@"img"]];
    cell.cellLabel.text = self.cellDicArray[indexPath.section][indexPath.row][@"title"];
    return cell;
}

#pragma mark 分割tableview设置
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT / 12;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = RGBColor(246, 246, 246, 1);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = _cellDicArray[indexPath.section][indexPath.row][@"controller"];
    
    UIViewController *vc;
    vc = (UIViewController *)[[NSClassFromString(className) alloc] init];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
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
        vc.delegate = self;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        vc.navigationItem.title = self.cellDicArray[indexPath.section][indexPath.row][@"title"];
        return;
    } else if ([className isEqualToString:@"LXHelpViewController"]) {
        LXAskViewController *vc = (LXAskViewController *)[[LXAskViewController alloc] init];
        vc.isAsk = NO;
        vc.delegate = self;
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
    [self.navigationController pushViewController:vc animated:YES];
}

@end

